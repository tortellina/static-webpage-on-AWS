resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_1
  availability_zone = var.az_private_subnet_1

  tags = {
    Name = "Private Subnet 1"
  }
}


resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_2
  availability_zone = var.az_private_subnet_2

  tags = {
    Name = "Private Subnet 2"
  }
}