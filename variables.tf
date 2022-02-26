variable "instance_name" {
  description = "value of the name tag for the EC2 instance"
  type        = string
  default     = "ubuntu-instance"
}

variable "rhel_name" {
  description = "value of the name tag for the EC2 instance"
  type        = string
  default     = "rhel-instance"
}

variable "region" {
  description = "region of Instance"
  type        = string
  default     = "eu-central-1"
}

variable "pub_key" {
  description = "Public Key"
  type        = string
  sensitive   = true
}
