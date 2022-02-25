resource "aws_vpc" "exadel-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc"
  }
}

# Gateway
resource "aws_internet_gateway" "int-gateway" {
  vpc_id = aws_vpc.exadel-vpc.id
  tags = {
    Name = "Internet Gateway"
  }
}

// Routes Table

resource "aws_default_route_table" "route-tables" {
  default_route_table_id = aws_vpc.exadel-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.int-gateway.id
  }

  tags = {
    Name = "route-table"
  }
}

// Public Subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.exadel-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet"
  }
}

// Private Subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.exadel-vpc.id
  cidr_block = "10.0.10.0/24"
  tags = {
    Name = "Public Subnet"
  }
}