# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "web" {
  bucket = "${var.environment}-s3-bucket-web.com"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name        = "${var.environment}-s3-bucket-web"
    Environment = var.environment
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
resource "aws_s3_bucket_policy" "web" {
  bucket = aws_s3_bucket.web.id
  policy = <<POLICY
{    
    "Version": "2012-10-17",    
    "Statement": [        
      {            
          "Sid": "PublicReadGetObject",            
          "Effect": "Allow",            
          "Principal": "*",            
          "Action": [                
             "s3:GetObject"            
          ],            
          "Resource": [
             "arn:aws:s3:::${aws_s3_bucket.web.id}/*"            
          ]        
      }    
    ]
}
POLICY
}

locals {
  all_web_files = fileset("web/", "*")
  rel_web_files = toset([
    for file in local.all_web_files :
    file if file != "web/index.html"
  ])
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object
resource "aws_s3_bucket_object" "object-index" {
  bucket       = aws_s3_bucket.web.id
  key          = "index.html"
  source       = "web/index.html"
  content_type = "text/html"
  etag         = filemd5("web/index.html")
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object
resource "aws_s3_bucket_object" "objects-web" {
  for_each = local.rel_web_files
  bucket   = aws_s3_bucket.web.id
  key      = each.value
  source   = "web/${each.value}"
  etag     = filemd5("web/${each.value}")
}
