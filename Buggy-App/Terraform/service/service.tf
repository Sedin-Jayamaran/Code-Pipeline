data "aws_ecs_cluster" "cluster" {
  cluster_name = "JAI-TERRA-CLUSTER"
}

data "aws_security_group" "ecs_sg" {
  filter {
    name   = "group-name"
    values = ["ecs-sg-jai"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["Jayamaran-Public1-Buggyapp", "Jayamaran-Public2-Buggyapp"]
  }
}

data "aws_lb_target_group" "app_tg" {
  name = "jai-terra-TG"
}

resource "aws_ecs_service" "jai_service" {
  name            = "jai_service_ecs"
  cluster         = data.aws_ecs_cluster.cluster.id
  task_definition = var.td_arn
  desired_count   = 1
  launch_type     = "EC2"

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  force_new_deployment = true 

  network_configuration {
    subnets          = data.aws_subnets.public.ids
    security_groups  = [data.aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }
  
  lifecycle {
    create_before_destroy = true
  }

  load_balancer {
    target_group_arn = data.aws_lb_target_group.app_tg.arn
    container_name   = "buggy-web-terra"
    container_port   = 3000
  }
}
