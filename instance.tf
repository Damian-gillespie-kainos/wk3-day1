resource "aws_instance" "kpa-instance1-dg" {
  ami                         = var.AMI
  instance_type               = "t2.micro"
  availability_zone           = var.ZONE
  key_name                    = aws_key_pair.kpa-key-dg.key_name
  vpc_security_group_ids      = [aws_security_group.kpa-secgrp-dg.id]
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.kpa-pub-sub1-dg.id # NEED TO ASSOCIATE THE SUBNET ID!!

  tags = {
    Name = "kpa-instance1-dg"
  }
}

resource "aws_ebs_volume" "kpa-vol1-dg" {
  availability_zone = var.ZONE
  size              = 8
  type              = "gp3"
  tags = {
    Name = "kpa-vol8-dg"
  }
}

resource "aws_volume_attachment" "kpa-vol1-att-dg" {
  volume_id   = aws_ebs_volume.kpa-vol1-dg.id
  instance_id = aws_instance.kpa-instance1-dg.id
  device_name = "/dev/xvdh"
}

resource "aws_eip" "kpa-eip1-dg" {
  instance = aws_instance.kpa-instance1-dg.id
  domain   = "vpc"

  tags = {
    Name = "kpa-eip-dg"
  }
}

resource "aws_eip_association" "kpa-eip1-asso-dg" {
  instance_id   = aws_instance.kpa-instance1-dg.id
  allocation_id = aws_eip.kpa-eip1-dg.id
}


resource "aws_instance" "kpa-instance2-dg" {
  ami                         = var.AMI
  instance_type               = "t2.micro"
  availability_zone           = var.ZONE
  key_name                    = aws_key_pair.kpa-key-dg.key_name
  vpc_security_group_ids      = [aws_security_group.kpa-secgrp-dg.id]
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.kpa-pub-sub2-dg.id # NEED TO ASSOCIATE THE SUBNET ID!!

  tags = {
    Name = "kpa-instance2-dg"
  }
}

resource "aws_ebs_volume" "kpa-vol2-dg" {
  availability_zone = var.ZONE
  size              = 8
  type              = "gp3"
  tags = {
    Name = "kpa-vol8-dg"
  }
}

resource "aws_volume_attachment" "kpa-vol2-att-dg" {
  volume_id   = aws_ebs_volume.kpa-vol2-dg.id
  instance_id = aws_instance.kpa-instance2-dg.id
  device_name = "/dev/xvdh"
}

resource "aws_eip" "kpa-eip2-dg" {
  instance = aws_instance.kpa-instance2-dg.id
  domain   = "vpc"

  tags = {
    Name = "kpa-eip-dg"
  }
}

resource "aws_eip_association" "kpa-eip2-asso-dg" {
  instance_id   = aws_instance.kpa-instance2-dg.id
  allocation_id = aws_eip.kpa-eip2-dg.id
}