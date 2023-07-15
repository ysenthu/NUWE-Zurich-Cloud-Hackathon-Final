module "asg2" {
  source           = "../../modules/compute"
  user_data        = module.app.app_installation
  desired_capacity = 1
  max_size         = 1
  min_size         = 1
  subnet_ids       = module.network.private_subnets_ids
  name             = "zurich-hackathon2"
  environment      = "local"
  image_id         = data.aws_ami.amazon-linux-2.id
  instance_type    = "t2.micro"
  public_key       = file("zurich2.pub")
  security_groups  = [module.security_group.id]
  instance_profile = module.iam.instance_profile
}

module "nlb2" {
  source = "../../modules/loadbalancer"

  name        = "zurich-hackathon1"
  environment = "local"
  asg_name    = module.asg2.asg_name
  subnet_ids  = module.network.public_subnets_ids
  vpc_id      = module.network.vpc_id
}

