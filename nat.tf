resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.webPublic1.id
  depends_on    = [aws_internet_gateway.internet-gw]
}