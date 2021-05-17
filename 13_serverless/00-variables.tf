variable "region" {
  description = "AWS Defautl Deployment Region"
  default     = "us-east-1"
}

variable "environment" {
  description = "Enviroment Name"
  default     = "aws-architect-associate"
}

variable "vpc_cidr" {
  description = ""
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  description = ""
  default     = ["10.0.11.0/24","10.0.12.0/24","10.0.13.0/24"]
}

variable "private_subnets_cidr" {
  description = ""
  default     = ["10.0.21.0/24","10.0.22.0/24","10.0.23.0/24"]
}

variable "availability_zones" {
  description = ""
  default     = ["us-east-1a","us-east-1b","us-east-1c"]
}
