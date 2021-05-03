data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
} # refere to by 'chomp(data.http.myip.body)'

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

output "rds_password" {
  value = random_password.password.result
}