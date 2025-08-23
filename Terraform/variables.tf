variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_1" {
    description = "CIDR block of public subnet 1"
    type = string
}

variable "public_subnet_2" {
    description = "CIDR block of public subnet 2"
    type = string
}