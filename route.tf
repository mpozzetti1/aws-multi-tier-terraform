resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }
}

resource "aws_route_table_association" "web-1" {
  subnet_id      = aws_subnet.webPublic1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "web-2" {
  subnet_id      = aws_subnet.webPublic1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "app-1" {
  subnet_id      = aws_subnet.appPrivate1.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "app-2" {
  subnet_id      = aws_subnet.appPrivate2.id
  route_table_id = aws_route_table.private-rt.id
}