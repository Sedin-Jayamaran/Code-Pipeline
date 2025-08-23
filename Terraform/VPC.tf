resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr 
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc-jai"
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_1
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-public-subnet-jai"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_2
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true



  tags = {
    Name = "my-public-subnet-jai_1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw-jai"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-rt-jai"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}