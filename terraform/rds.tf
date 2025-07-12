resource "aws_db_subnet_group" "db_subnet" {
  name       = "medusa-db-subnet-group"
  subnet_ids = aws_subnet.public[*].id

  tags = {
    Name = "Medusa DB Subnet Group"
  }
}

resource "aws_db_instance" "medusadb" {
  identifier             = "medusadb"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  username               = "postgres"
  password               = "Postgres123"
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  skip_final_snapshot    = true
  publicly_accessible    = true

  tags = {
    Name = "medusadb"
  }
}
