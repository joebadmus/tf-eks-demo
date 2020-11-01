# provider "aws" {
#   region = "eu-west-2"
# }

# resource "aws_s3_bucket" "infra-dev-backend" {
#   bucket = "joe-cap-demo-proj"

#   versioning {
#     enabled = true
#   }

#   lifecycle {
#     prevent_destroy = true
#   }

#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }