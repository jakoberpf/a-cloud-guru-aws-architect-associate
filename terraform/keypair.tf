resource "aws_key_pair" "jakoberpf" {
  key_name   = "jakoberpf"
  public_key = file("~/.ssh/id_rsa.pub")
}