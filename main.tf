provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "mysql_sg" {
  name        = "mysql-sg"
  description = "MySQL access"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # demo only
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "mysql" {
  identifier        = "free-tier-mysql"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "demodb"
  username = "admin"
  password = "Admin#12345"

  vpc_security_group_ids = [aws_security_group.mysql_sg.id]

  skip_final_snapshot = true
  publicly_accessible = true
}
