resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow asg ec2 instances to inbound and our traffic of ssh, http and custom port of 3000"
  vpc_id      = aws_vpc.main_vpc.id

  tags = {
    Name = "ec2_sg"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Allow application load balancer access to port 80 for HTTP requests"
  vpc_id      = aws_vpc.main_vpc.id

  tags = {
    Name = "alb_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = aws_vpc.main_vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

  tags = {
    Name = "allow_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_alb" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

  tags = {
    Name = "alb_http_ingress"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allow_port_3000" {
  security_group_id        = aws_security_group.ec2_sg.id
  from_port                = 3000
  to_port                  = 3000
  ip_protocol              = "tcp"
  referenced_security_group_id = aws_security_group.alb_sg.id

  tags = {
    Name = "allow_port_3000"
  }
}


resource "aws_vpc_security_group_egress_rule" "allow_egress" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name = "allow_egress"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_egress_alb" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name = "allow_egress_alb"
  }
}