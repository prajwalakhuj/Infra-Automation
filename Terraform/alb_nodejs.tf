# Region and Provider
provider "aws" {
    region = "us-east-2"
}

# Application Load Balancer
module "alb" "test"{
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "prajwal-alb-terraform"

  load_balancer_type = "application"

  vpc_id             = "vpc-036d31bd5fc70a5ef"
  subnets            = ["subnet-00225cb9fd5dbcf5f", "subnet-07b1f4e2c636d566a"]
  security_groups    = ["sg-050a3411554a111d5"]
    
  tags = {
    Environment = "test"
  }
}
  
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.asg.id}"
  alb_target_group_arn   = "${aws_alb_target_group.test.arn}"
}
