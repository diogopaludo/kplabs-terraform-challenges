resource "aws_security_group" "payment_app" {
  name        = "payment_app"
  description = "Application Security Group"
  depends_on  = [aws_eip.example]
  tags = {
    Name = "Payment App"
  }
}

# Below ingress allows HTTPS  from DEV VPC
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.payment_app.id
  from_port         = var.port_https
  to_port           = var.port_https
  ip_protocol       = "tcp"
  cidr_ipv4         = var.dev_vpc
  description       = "Allows HTTPS from DEV VPC"
  tags = {
    Name = "HTTPS"
  }
}

# Below ingress allows APIs access from DEV VPC
resource "aws_vpc_security_group_ingress_rule" "allow_apis_dev" {
  security_group_id = aws_security_group.payment_app.id
  from_port         = var.port_apis_dev
  to_port           = var.port_apis_dev
  ip_protocol       = "tcp"
  cidr_ipv4         = var.dev_vpc
  description       = "Allows APIs access from DEV VPC"
  tags = {
    Name = "Dev API"
  }
}

# Below ingress allows APIs access from Prod App Public IP.
resource "aws_vpc_security_group_ingress_rule" "allow_apis_prod" {
  security_group_id = aws_security_group.payment_app.id
  from_port         = var.port_apis_prod
  to_port           = var.port_apis_prod
  ip_protocol       = "tcp"
  cidr_ipv4         = "${aws_eip.example.public_ip}/32"
  description       = "Allows APIs access from Prod App Public IP"
  tags = {
    Name = "Prod API"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.payment_app.id
  from_port         = var.splunk
  to_port           = var.splunk
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  description       = "Allow all"
  tags = {
    Name = "Egress"
  }
}