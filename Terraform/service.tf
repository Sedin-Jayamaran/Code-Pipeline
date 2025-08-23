resource "aws_ecs_service" "jai_service" {
  name            = "jai-ecs-service"
  cluster         = "JAI-TERRA-CLUSTER"   
  task_definition = aws_ecs_task_definition.JAI-TERRA-TD-web.arn          
  desired_count   = 1
  launch_type     = "EC2"

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  
  network_configuration {
    subnets         = [aws_subnet.public_subnet.id,aws_subnet.public_subnet_1.id]  
    security_groups = [aws_security_group.ecs_sg.id]                         
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.jai_terra_TG.arn
    container_name   = "buggy-web-terra"      
    container_port   = 3000       
  }
}


