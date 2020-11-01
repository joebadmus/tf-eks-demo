variable "vpc_name" {
  type    = string
  default = "main_vpc"
}


variable "private_subnets" {
  type    = list(string)
  default = ["private_sub_a", "private_sub_b", "private_sub_c"]

}
variable "public_subnets" {
  type    = list(string)
  default = ["public_sub_a", "public_sub_b", "public_sub_c"]
}

variable "author" {
  type    = string
  default = "Joe B"
}

variable "tool" {
  type    = string
  default = "Terraform"
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

output "vpcid" {
  value = aws_vpc.main_vpc.id
}
