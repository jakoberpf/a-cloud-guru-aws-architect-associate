resource "aws_security_group" "ec2" {
  name = "${var.environment}-ec2-sg"

  description = "EC2 security group (terraform-managed)"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Telnet"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "HTTPS"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_mysql_public" {
  name = "${var.environment}-rds-mysql-public-sg"

  description = "Public Mysql RDS security group (terraform-managed)"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = "5432"
    to_port     = "5432"
    protocol    = "tcp"
    description = "Mysql"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_mysql_private" {
  name = "${var.environment}-rds-mysql-private-sg"

  description = "Private Mysql RDS security group (terraform-managed)"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = "5432"
    to_port     = "5432"
    protocol    = "tcp"
    description = "Mysql"
    cidr_blocks = tolist(aws_subnet.private_subnet.*.cidr_block)
  }

  # Allow outbound traffic to private subnets.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = tolist(aws_subnet.private_subnet.*.cidr_block)
  }
}