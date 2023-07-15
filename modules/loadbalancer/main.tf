

# Create Target Groups
resource "aws_lb_target_group" "target_group" {
  count             = length(var.ports)
  name_prefix       = "${var.ports[count.index].port}"
  port              = var.ports[count.index].port
  protocol          = var.ports[count.index].protocol
  vpc_id            = var.vpc_id
  target_type       = "instance"
}

# Create Network Load Balancer
resource "aws_lb" "nlb" {
  name                     = "${local.name_prefix}-nlb"
  internal                 = false
  load_balancer_type       = "network"
  subnets                  = var.subnet_ids
  enable_deletion_protection = true
}

# Create Listeners
resource "aws_lb_listener" "listener" {
  count             = length(var.ports)
  load_balancer_arn = aws_lb.nlb.arn
  port              = var.ports[count.index].port
  protocol          = var.ports[count.index].protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group[count.index].arn
  }
}

# Attach the Target Groups to the ASG
resource "aws_autoscaling_attachment" "asg_attachment" {
  count                   = length(var.ports)
  autoscaling_group_name  = var.asg_name
  lb_target_group_arn    = aws_lb_target_group.target_group[count.index].arn
}
