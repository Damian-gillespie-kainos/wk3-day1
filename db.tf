resource "aws_db_instance" "kpa-db-dg" {
  allocated_storage      = 20
  db_name                = "kpadbdg"
  db_subnet_group_name   = aws_db_subnet_group.kpa-db-sub-dg.name
  vpc_security_group_ids = [aws_security_group.kpa-rds-secgrp-dg.id]
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  username               = "samsung"
  password               = "#Kpabelfast23"
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
}