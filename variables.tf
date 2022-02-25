variable "instance_name" {
  description = "value of the name tag for the EC2 instance"
  type        = string
  default     = "ubuntu-instance"
}

variable "centos_name" {
  description = "value of the name tag for the EC2 instance"
  type        = string
  default     = "centos-instance"
}

variable "region" {
  description = "region of Instance"
  type        = string
  default     = "eu-central-1"
}

