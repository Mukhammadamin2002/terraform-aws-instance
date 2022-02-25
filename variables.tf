variable "instance_name" {
  description = "value of the name tag for the EC2 instance"
  type        = string
  default     = "UbuntuIntance"
}

variable "region" {
  description = "region of Instance"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  type = string
  description = "The IP range to use VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_numbers" {
  type = map(number)

  description = "Map of Availability Zone to a number that should be used for public subnets"

  default = {
    "eu-central-1a" = 1
    "eu-central-1b" = 2
    "eu-central-1c" = 3
  }
}

variable "private_subnet_numbers" {
  type = map(number)

  description = "Map of Availability Zone to a number that should be used for private subnets"

  default = {
    "eu-central-1a" = 4
    "eu-central-1b" = 5
    "eu-central-1c" = 6
  }
}