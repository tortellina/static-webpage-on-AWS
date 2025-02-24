#creating the internet getaway, route table and their accociation for internet connection

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "internet gw"
  }
}


resource "aws_route_table" "public_subnet_route_table_1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "internet gw route table for public subnet 1"
  }

}
resource "aws_route_table" "public_subnet_route_table_2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "internet gw route table for public subnet 2"
  }
}


resource "aws_route_table_association" "rt_p_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_subnet_route_table_1.id
}

resource "aws_route_table_association" "rt_p_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_subnet_route_table_2.id
}
