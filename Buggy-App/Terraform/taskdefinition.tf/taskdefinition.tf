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

      environment = [
        {
          name  = "MYSQL_DATABASE"
          value = "database-1-jai"
        },
        {
          name  = "MYSQL_PASSWORD"
          value = "Jayamaran1011"
        },
        {
          name  = "MYSQL_PORT"
          value = "3306"
        },
        {
          name  = "RAILS_ENV"
          value = "production"
        },
        {
          name  = "MYSQL_USER"
          value = "jai"
        },
        {
          name  = "MYSQL_HOST"
          value = "database-1-jai.clea0kqwgsnt.ap-south-1.rds.amazonaws.com"
        },
        {
          name  = "SECRET_KEY_BASE"
          value = "327c5f2bda2e0518b89a125809a01af808c7e006e4c500d7c3ca09f804646de79bdf67be394c195f85f311ce24efc34b063ed4ddf5ab90f99151a4e6036b639b"
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