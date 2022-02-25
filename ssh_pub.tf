resource "aws_key_pair" "accesser" {
  key_name   = "accesser"
  public_key = var.pub_key
}