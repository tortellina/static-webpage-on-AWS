
#elastic ip
resource "aws_eip" "nat_1" {
  domain = "vpc"

}

resource "aws_eip" "nat_2" {
  domain = "vpc"

}

#nat gw
resource "aws_nat_gateway" "nat_gw_1" {
  allocation_id = aws_eip.nat_1.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "gw NAT 1"
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat_gw_2" {
  allocation_id = aws_eip.nat_2.id
  subnet_id     = aws_subnet.public_subnet_2.id

  tags = {
    Name = "gw NAT 2"
  }

  depends_on = [aws_internet_gateway.gw]
}

#route tables
resource "aws_route_table" "private_route_table_1" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Private Route Table 1"
  }
}
resource "aws_route_table" "private_route_table_2" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Private Route Table 2"
  }
}

#association of teh route tables
resource "aws_route_table_association" "private_subnet_association_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table_1.id
}

resource "aws_route_table_association" "private_subnet_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table_2.id
}


#direct traffic to the nat gw
resource "aws_route" "private_subnet_route_1" {
  route_table_id         = aws_route_table.private_route_table_1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw_1.id
}

resource "aws_route" "private_subnet_route_2" {
  route_table_id         = aws_route_table.private_route_table_2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw_2.id
}