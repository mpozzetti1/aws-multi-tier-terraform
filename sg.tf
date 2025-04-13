# Security Groups
resource "aws_security_group" "sg-web" {
  name        = "web"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group" "sg-app" {
  name        = "app"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group" "sg-db" {
  name        = "db"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group" "sg-lb" {
  name        = "lb"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id
}

# Rules
resource "aws_vpc_security_group_ingress_rule" "allow-https" {
  for_each = {
    web = aws_security_group.sg-web.id
    app = aws_security_group.sg-app.id
  }

  security_group_id = each.value
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow-http" {
  for_each = {
    web = aws_security_group.sg-web.id
    app = aws_security_group.sg-app.id
  }

  security_group_id = each.value
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh" {
  for_each = {
    web = aws_security_group.sg-web.id
    app = aws_security_group.sg-app.id
  }

  security_group_id = each.value
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow-oracledb" {
  security_group_id = aws_security_group.sg-db.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = var.db-port
  ip_protocol       = "tcp"
  to_port           = var.db-port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_out" {
  for_each = {
    web = aws_security_group.sg-web.id
    db  = aws_security_group.sg-db.id
    app = aws_security_group.sg-app.id
  }

  security_group_id = each.value
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "lb-allow_all_in-https" {
  security_group_id = aws_security_group.sg-lb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}