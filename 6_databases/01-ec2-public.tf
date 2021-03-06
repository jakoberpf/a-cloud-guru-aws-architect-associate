locals {
  instance_userdata = <<EOF
#!/bin/bash
sudo apt install httpd php php-mysql -y
cd /var/www/html
wget https://wordpress.org/wordpress-5.1.1.tar.gz
tar -xzf wordpress-5.1.1.tar.gz
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm -rf wordpress-5.1.1.tar.gz
chmod -R 755 wp-content
chown -R apache:apache wp-content
service httpd start
chkconfig httpd on
EOF
}

resource "aws_instance" "wordpress" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_subnet.0.id

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  key_name = aws_key_pair.myself.key_name

  user_data_base64 = "${base64encode(local.instance_userdata)}"

  tags = {
    Name        = "wordpress"
    Environment = var.environment
  }
}

output "wordpress_public_dns" {
  value = aws_instance.wordpress.public_dns
}

output "wordpress_public_ip" {
  value = aws_instance.wordpress.public_ip
}