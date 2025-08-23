resource "aws_ecs_cluster" "JAI-TERRA-CLUSTER" {
  name = "JAI-TERRA-CLUSTER"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}