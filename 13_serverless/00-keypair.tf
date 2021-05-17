resource "aws_key_pair" "myself" {
  key_name   = "myself"
  public_key = file("~/.ssh/id_rsa.pub")
}