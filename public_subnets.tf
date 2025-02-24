resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_1
  availability_zone = var.az_public_subnet_1

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_2
  availability_zone = var.az_public_subnet_2

  tags = {
    Name = "Public Subnet 2"
  }
}





