module "network" {
  source = "../../modules/network"

  name        = "zurich-hackathon"
  environment = "local"
  azs         = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

module "iam" {
  source        = "../../modules/iam"
  name          = "zurich-hackathon"
  environment   = "local"
  s3_bucket_arn = module.s3.s3_bucket_arn
  kms_arn       = module.s3.cmk_arn
}
module "asg" {
  source           = "../../modules/compute"
  user_data        = module.app.app_installation
  desired_capacity = 1
  max_size         = 1
  min_size         = 1
  subnet_ids       = module.network.private_subnets_ids
  name             = "zurich-hackathon"
  environment      = "local"
  image_id         = data.aws_ami.amazon-linux-2.id
  instance_type    = "t2.micro"
  public_key       = file("zurich.pub")
  security_groups  = [module.security_group.id]
  instance_profile = module.iam.instance_profile
}


module "security_group" {
  source = "../../modules/security"

  name   = "zurich-hackathon"
  vpc_id = module.network.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 1337
      to_port     = 1337
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 3035
      to_port     = 3035
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 3035
      to_port     = 3035
      protocol    = "udp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}


module "nlb" {
  source = "../../modules/loadbalancer"

  name        = "zurich-hackathon"
  environment = "local"
  asg_name    = module.asg.asg_name
  subnet_ids  = module.network.public_subnets_ids
  vpc_id      = module.network.vpc_id
}

module "s3" {
  source = "../../modules/storage"

  name        = "zurich-hackathon"
  environment = "local"

}

module "app" {
  source       = "../../modules/app"
  project_root = "../../"
  bucket_name  = module.s3.bucket_name
  object_key   = "package.zip"
}
