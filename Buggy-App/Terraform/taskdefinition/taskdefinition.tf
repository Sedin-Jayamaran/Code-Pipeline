resource "aws_ecs_task_definition" "JAI-TERRA-TD-web" {
  family                   = "JAI-TERRA-TD-web"
  network_mode             = "awsvpc"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "256"

  execution_role_arn = "arn:aws:iam::156916773321:role/ecsTaskexecution-Jai"
  task_role_arn      = "arn:aws:iam::156916773321:role/ecsTaskexecution-Jai"

  container_definitions = jsonencode([
    {
      name      = "buggy-web-terra"
      image     = var.image
      cpu       = 0
      essential = true

      portMappings = [
        {
          name          = "buggy-web-80-tcp"
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
          appProtocol   = "http"
        },
        {
          name          = "buggy-web-3000-tcp"
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]

      secrets = [
                  {
                     name      = "MYSQL_DATABASE"
                     valueFrom = "arn:aws:secretsmanager:ap-south-1:156916773321:secret:Jai-Terraform-Secret-oMv1pE:MYSQL_DATABASE::"
                  },
                  {
                     name      = "MYSQL_PASSWORD"
                     valueFrom = "arn:aws:secretsmanager:ap-south-1:156916773321:secret:Jai-Terraform-Secret-oMv1pE:MYSQL_PASSWORD::"
                  },
                  {
                    name = "MYSQL_PORT"
                    valueFrom = "arn:aws:secretsmanager:ap-south-1:156916773321:secret:Jai-Terraform-Secret-oMv1pE:MYSQL_PORT::"
                  },
                  {
                    name = "RAILS_ENV"
                    valueFrom = "arn:aws:secretsmanager:ap-south-1:156916773321:secret:Jai-Terraform-Secret-oMv1pE:RAILS_ENV::"
                  },
                  {
                    name = "MYSQL_USER"
                    valueFrom = "arn:aws:secretsmanager:ap-south-1:156916773321:secret:Jai-Terraform-Secret-oMv1pE:MYSQL_USER::"
                  },
                  {
                    name = "MYSQL_HOST"
                    valueFrom = "arn:aws:secretsmanager:ap-south-1:156916773321:secret:Jai-Terraform-Secret-oMv1pE:MYSQL_HOST::"
                  },
                  {
                    name = "SECRET_KEY_BASE"
                    valueFrom = "arn:aws:secretsmanager:ap-south-1:156916773321:secret:Jai-Terraform-Secret-oMv1pE:SECRET_KEY_BASE::"
                  }
                ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/JAI-TERRA-TD-web"
          awslogs-create-group  = "true"
          awslogs-region        = "ap-south-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
}