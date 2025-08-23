
resource "aws_lb" "jai_alb" {
  name               = "jai-terraform-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_sg.id]
  subnets            = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_1.id] # needs at least 2 AZs

  enable_deletion_protection = false

  tags = {
    Name = "Jai-terraform-alb"
  }
}


resource "aws_lb_target_group" "jai_terra_TG" {
  name        = "jai-terra-TG"
  port        =  3000                 # port your ECS tasks/app listens on
  protocol    = "HTTP"
  target_type = "ip"                  # for ECS tasks
  vpc_id      = aws_vpc.my_vpc.id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    path                = "/"         # use path instead of target in ALB
    interval            = 30
  }
}


resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.jai_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jai_terra_TG.arn
  }
}
