resource "aws_instance" "kpa-instance-dg" {
  ami                         = var.AMI
  instance_type               = "t2.micro"
  availability_zone           = var.ZONE
  key_name                    = aws_key_pair.kpa-key-dg.key_name
  vpc_security_group_ids      = [aws_security_group.kpa-secgrp-dg.id]
  associate_public_ip_address = true
  subnet_id = aws_subnet.kpa-pub-sub-dg.id          # NEED TO ASSOCIATE THE SUBNET ID!!
}
