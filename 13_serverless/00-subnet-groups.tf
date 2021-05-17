resource "aws_db_subnet_group" "public" {
  name       = "public_subnets"
  subnet_ids = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[1].id, aws_subnet.public_subnet[2].id]

  tags = {
    Name = "Public DB subnets"
  }
}

resource "aws_db_subnet_group" "private" {
  name       = "private_subnets"
  subnet_ids = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id, aws_subnet.private_subnet[2].id]

  tags = {
    Name = "Private DB subnets"
  }
}