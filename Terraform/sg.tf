
resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg-jai"
  description = "Allow ECS traffic"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "ecs-sg-jai"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_app" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3000
  to_port           = 3000
  ip_protocol       = "tcp"
  description       = "Allow app traffic (port 3000 from ALB)"
}


resource "aws_vpc_security_group_ingress_rule" "ecs_ssh" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  description       = "Allow SSH"
}


resource "aws_vpc_security_group_ingress_rule" "ecs_mysql" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4         = "0.0.0.0/0"   # or restrict to ECS tasks CIDR for security
  from_port         = 3306
  to_port           = 3306
  ip_protocol       = "tcp"
  description       = "Allow MySQL traffic"
}



resource "aws_vpc_security_group_ingress_rule" "ecs_http" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  description       = "Allow app traffic (HTTP)"
}

resource "aws_vpc_security_group_egress_rule" "ecs_all_ipv4" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # all traffic
}


resource "aws_vpc_security_group_egress_rule" "ecs_all_ipv6" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # all traffic
}
