variable "td_arn"{
    type = string
}

variable "image" {
  description = "Docker image to use for ECS task"
  type        = string
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}
