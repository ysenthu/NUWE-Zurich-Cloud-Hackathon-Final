resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name = local.network_prefix
  }
}

# Create Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets_cidr)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.network_prefix}-public-subnet-${count.index}"
  }
}

# Create Private Subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${local.network_prefix}-private-subnet-${count.index}"
  }
}

# Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.network_prefix}-igw"
  }
}

# Create a routing table for Public subnet and attach Internet Gateway
resource "aws_route_table" "public" {
  count  = length(var.public_subnets_cidr)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${local.network_prefix}-public-route-${count.index}"
  }
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  count = length(var.public_subnets_cidr)
  vpc   = true

  tags = {
    Name = "${local.network_prefix}-nat-eip-${count.index}"
  }
}

# Create NAT Gateway
resource "aws_nat_gateway" "main" {
  count         = length(var.public_subnets_cidr)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "${local.network_prefix}-nat-gw-${count.index}"
  }
}

# Create Route Table for Private subnet and point all traffic to NAT Gateway
resource "aws_route_table" "private" {
  count  = length(var.public_subnets_cidr)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name = "${local.network_prefix}-private-route-${count.index}"
  }
}

# Associate the public subnets with the public route table
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}

# Associate the private subnets with the private route table
resource "aws_route_table_association" "private" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
