variable "region" {
  description = "AWS Region"
  default = "sa-east-1"
}

variable "key_path" {
  description = "Public key path"
  default = "terraform-aws.pub"
}

variable "ami" {
  description = "AMI"
  default = "ami-054a31f1b3bf90920"
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}