
# Set up your virtural network, along with your subnets (Public and Private if needed), 
# an internet gatway, route table and association

resource "aws_vpc" "kpa-vpc-dg" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = { # TAGS NEEDED FOR VPC
    Name = "kpa-vpc-dg"
  }

}

### INTERNET GATEWAY
resource "aws_internet_gateway" "kpa-gw-dg" {
  vpc_id = aws_vpc.kpa-vpc-dg.id

  tags = { # TAGS NEEDED FOR IGW
    Name = "kpa-gw-dg"
  }
}

## SUBNETS
resource "aws_subnet" "kpa-pub-sub1-dg" {
  vpc_id                  = aws_vpc.kpa-vpc-dg.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1a"
}

resource "aws_subnet" "kpa-pub-sub2-dg" {
  vpc_id                  = aws_vpc.kpa-vpc-dg.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1b"
}

resource "aws_subnet" "kpa-pri-sub1-dg" {
  vpc_id            = aws_vpc.kpa-vpc-dg.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "kpa-pri-sub2-dg" {
  vpc_id            = aws_vpc.kpa-vpc-dg.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-1b"
}

resource "aws_db_subnet_group" "kpa-db-sub-dg" {
  name       = "kpa-db-sub-dg"
  subnet_ids = [aws_subnet.kpa-pri-sub1-dg.id, aws_subnet.kpa-pri-sub2-dg.id]
}


### ROUTE TABLES

resource "aws_route_table" "kpa-pub-rt-dg" {
  vpc_id = aws_vpc.kpa-vpc-dg.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kpa-gw-dg.id
  }
}

resource "aws_route_table" "kpa-pri-rt-dg" {
  vpc_id = aws_vpc.kpa-vpc-dg.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kpa-gw-dg.id
  }
}

### ROUTE TABLE ASSOCIATIONS

resource "aws_route_table_association" "kpa_pub-rt_acc1_dg" {
  subnet_id      = aws_subnet.kpa-pub-sub1-dg.id
  route_table_id = aws_route_table.kpa-pub-rt-dg.id
}

resource "aws_route_table_association" "kpa_pub-rt_acc2_dg" {
  subnet_id      = aws_subnet.kpa-pub-sub2-dg.id
  route_table_id = aws_route_table.kpa-pub-rt-dg.id
}

resource "aws_route_table_association" "kpa_pri-rt_acc1_dg" {
  subnet_id      = aws_subnet.kpa-pri-sub1-dg.id
  route_table_id = aws_route_table.kpa-pri-rt-dg.id
}

resource "aws_route_table_association" "kpa_pri-rt_acc2_dg" {
  subnet_id      = aws_subnet.kpa-pri-sub2-dg.id
  route_table_id = aws_route_table.kpa-pri-rt-dg.id
}