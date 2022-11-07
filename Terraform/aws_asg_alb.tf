# Region and Provider
provider "aws" {
    region = "us-east-2"
}

# Application Load Balancer
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "prajwal-alb-terraform"

  load_balancer_type = "application"

  vpc_id             = "vpc-036d31bd5fc70a5ef"
  subnets            = ["subnet-00225cb9fd5dbcf5f", "subnet-07b1f4e2c636d566a"]
  security_groups    = ["sg-050a3411554a111d5"]

  target_groups = [
    {
      name_prefix      = "pratf"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = "i-0fc962fc8aafbeaae"
          port = 80
        }
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:acm:us-east-2:421320058418:certificate/ae42f480-f49e-4cdf-82e2-b7f57ceeeae4"
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Name = "prajwal-alb-terraform"
  }
}

# Auto Scaling Group
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  name = "prajwal-terraform-asg"

  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = ["subnet-07b1f4e2c636d566a", "subnet-00225cb9fd5dbcf5f"]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 60
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch template
  launch_template_name        = "prajwal-tf-template"
  launch_template_description = "Tf Launch template example"
  update_default_version      = true

  image_id          = "ami-0b61ac023a2b3a83f"
  instance_type     = "t3a.small"
  key_name          = "prajwal-key-aws"
  ebs_optimized     = true
  enable_monitoring = true

  # IAM role & instance profile
  create_iam_instance_profile = true
  iam_role_name               = "prajwal-tf-asg"
  iam_role_path               = "/ec2/"
  iam_role_description        = "IAM role example"
  iam_role_tags = {
    CustomIamRole = "Yes"
  }
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  tags = {
    Name = "prajwal-tf-asg"
  }
}

# Scaling Policy
resource "aws_autoscaling_policy" "asg-policy" {
  count                     = 1
  name                      = "prajwal-asg-cpu-policy"
  autoscaling_group_name    = module.asg.autoscaling_group_name
  estimated_instance_warmup = 60
  policy_type               = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}
