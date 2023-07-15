# In ./modules/asg/main.tf
resource "aws_key_pair" "asg" {
  key_name   = "${local.name_prefix}-key"
  public_key = var.public_key
}


resource "aws_launch_template" "template" {
  name_prefix   = "${local.name_prefix}-lt"
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.asg.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = var.security_groups
  }
  iam_instance_profile {
    name = var.instance_profile
  }

  user_data = var.user_data
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  tag {
    key                 = "timestamp"
    value               = timestamp()
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]

  }

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }

  vpc_zone_identifier = var.subnet_ids

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-asg"
    propagate_at_launch = true
  }
}

