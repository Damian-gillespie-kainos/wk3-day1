resource "aws_vpc" "kpa-vpc-dg" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "kpa-vpc-dg"
  }

}

# resource "aws_subnet" "kpa-pri-sub-dg" {
#   vpc_id                  = aws_vpc.kpa-vpc-dg.id
#   cidr_block              = "10.0.1.0/24"
#   availability_zone       = var.ZONE
# }

resource "aws_subnet" "kpa-pub-sub-dg" {
  vpc_id                  = aws_vpc.kpa-vpc-dg.id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE
}


resource "aws_internet_gateway" "kpa-gw-dg" {
  vpc_id = aws_vpc.kpa-vpc-dg.id

  tags = {
    Name = "kpa-gw-dg"
  }
}

resource "aws_route_table" "kpa-rt-dg" {
  vpc_id = aws_vpc.kpa-vpc-dg.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kpa-gw-dg.id
  }
}

resource "aws_route_table_association" "kpa_rt_acc_dg" {
  subnet_id      = aws_subnet.kpa-pub-sub-dg.id
  route_table_id = aws_route_table.kpa-rt-dg.id
}