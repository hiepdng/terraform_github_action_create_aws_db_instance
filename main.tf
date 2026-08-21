terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" 
}

# 2. Create a Security Group for the MySQL Server
resource "aws_security_group" "mysql_sg" {
  name        = "mysql-rds-security-group"
  description = "Allow inbound traffic to MySQL port"

  # MySQL default port rule
  ingress {
    description = "MySQL access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: Open to all IPs. Restrict to your IP for safety!
  }

  # Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. Provision the AWS RDS MySQL Instance
resource "aws_db_instance" "mysql_server" {
  identifier           = "my-mysql-rds-server"
  allocated_storage    = 20               # Storage size in Gigabytes
  storage_type         = "gp3"            # General Purpose SSD
  engine               = "mysql"          # Database engine type
  engine_version       = "8.0"            # Major MySQL version
  instance_class       = "db.t3.micro"    # Free-tier eligible instance class
  db_name              = "mydatabase"     # Name of the default database created
  username             = "db_admin"       # Master username
  password             = "mySecret123"    # Master password (use variables or Secrets Manager in production)
  
  # Security and Network configurations
  vpc_security_group_ids = [aws_security_group.mysql_sg.id]
  publicly_accessible    = false         # Set to false if you only want internal AWS network traffic
  skip_final_snapshot    = true          # Skips backup snapshot when running 'terraform destroy'
  deletion_protection = false            # Set to false to allow deletion

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}

# 4. Output the Database Endpoint
output "database_endpoint" {
  description = "The connection endpoint for the MySQL server"
  value       = aws_db_instance.mysql_server.endpoint
}
