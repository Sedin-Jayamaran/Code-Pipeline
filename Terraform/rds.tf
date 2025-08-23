resource "aws_db_instance" "mysql" {
  identifier        = "jai-mysql-db"
  engine            = "mysql"
  engine_version    = "8.0.39"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "database_jai"
  username = "jai"
  password = "Jayamaran1011"

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.ecs_sg.id]

  skip_final_snapshot = true
}
