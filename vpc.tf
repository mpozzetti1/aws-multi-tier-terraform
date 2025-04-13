resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Public subnets
resource "aws_subnet" "webPublic1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"  # Explicit AZ assignment
}

resource "aws_subnet" "webPublic2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-1b"  # Different AZ
}

# Application subnets
resource "aws_subnet" "appPrivate1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "appPrivate2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-1b"
}

# Database subnets
resource "aws_subnet" "dbPrivate1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "dbPrivate2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "eu-west-1b"
}