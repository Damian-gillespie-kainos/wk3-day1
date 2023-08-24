resource "aws_security_group" "kpa-secgrp-dg" {
  name   = "kpa-secgrp-dg"
  vpc_id = aws_vpc.kpa-vpc-dg.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { # Allow SSH from Kainos trusted IPs
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.trusted_ips
  }

  ingress { # Allow HTTP from Kainos trusted IPs
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.trusted_ips
  }

  tags = { # TAGS NEEDED
    Name = "kpa-secgrp-dg"
  }
}

resource "aws_security_group" "kpa-rds-secgrp-dg" { # Specific secruity group needed for RDS
  name   = "kpa-rds-secgrp-dg"
  vpc_id = aws_vpc.kpa-vpc-dg.id

  ingress {
    description     = "Allow traffic from main secgrp"
    from_port       = "3306"
    to_port         = "3306"
    protocol        = "tcp"
    security_groups = [aws_security_group.kpa-secgrp-dg.id]
  }

  tags = {
    Name = "kpa-rds-secgrp-dg"
  }
}