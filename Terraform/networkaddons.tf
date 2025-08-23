resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"       
  availability_zone = "ap-south-1a"      
  map_public_ip_on_launch = false      

  tags = {
    Name = "my-private-subnet-jai"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.3.0/24"       
  availability_zone = "ap-south-1b"     
  map_public_ip_on_launch = false

  tags = {
    Name = "my-private-subnet-jai-2"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "jai-rds-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  tags = {
    Name = "Jai-rds-subnet-group"
  }
}


