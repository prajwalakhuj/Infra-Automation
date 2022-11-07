provider "aws" {
    region = "us-east-2"
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = "prajwal-rds-terraform"

  engine            = "mysql"
  engine_version    = "5.7.33"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "mysqldb"
  username = "admin"
  password = "password"
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = ["sg-050a3411554a111d5"]
  monitoring_interval = "30"
  monitoring_role_name = "PrajwalRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Name         = "prajwal-rds-terraform"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = ["subnet-00225cb9fd5dbcf5f", "subnet-07b1f4e2c636d566a"]

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

}

