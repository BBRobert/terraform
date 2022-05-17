
/*====
VPC's Default Security Group
======*/
resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Default security group to allow HTTP & HTTPS & SSH inbound / ALL outbound from the VPC"
  vpc_id      = "${aws_vpc.vpc.id}"
  
  ingress = [
    {
      description = "HTTPS"
      from_port = 443
      to_port = 443
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false
    },
    {
      description = "HTTP"
      from_port = 80
      to_port = 80
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false
    },
    {
      description = "SSH"
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]

  egress {
    description      = "ALL outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids = []
    security_groups = []
    self = false
  }

  tags = {
    Name = "${var.environment}-default-sg"
    Environment = "${var.environment}"
  }
  
  depends_on  = [aws_vpc.vpc]
}

resource "aws_security_group" "outbound_all" {
  name        = "${var.environment}-outbound-all-sg"
  description = "Security group to allow ALL outbound from the VPC"
  vpc_id      = "${aws_vpc.vpc.id}"
  
  egress {
    description      = "ALL outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids = []
    security_groups = []
    self = false
  }

  tags = {
    Name = "${var.environment}-outbound-all-sg"
    Environment = "${var.environment}"
  }
  
  depends_on  = [aws_vpc.vpc]
}

resource "aws_security_group" "inbound_https" {
  name        = "${var.environment}-inbound-https-sg"
  description = "Security group to allow HTTPS inbound from the VPC"
  vpc_id      = "${aws_vpc.vpc.id}"
  
  ingress = [
    {
      description = "HTTPS"
      from_port = 443
      to_port = 443
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]

  tags = {
    Name = "${var.environment}-inbound-https-sg"
    Environment = "${var.environment}"
  }
  
  depends_on  = [aws_vpc.vpc]
}

resource "aws_security_group" "inbound_http" {
  name        = "${var.environment}-inbound-http-sg"
  description = "Security group to allow HTTP inbound from the VPC"
  vpc_id      = "${aws_vpc.vpc.id}"
  
  ingress = [
    {
      description = "HTTP"
      from_port = 80
      to_port = 80
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]

  tags = {
    Name = "${var.environment}-inbound-http-sg"
    Environment = "${var.environment}"
  }
  
  depends_on  = [aws_vpc.vpc]
}

resource "aws_security_group" "inbound_ssh" {
  name        = "${var.environment}-inbound-ssh-sg"
  description = "Security group to allow SSH inbound from the VPC"
  vpc_id      = "${aws_vpc.vpc.id}"
  
  ingress = [
    {
      description = "SSH"
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]

  tags = {
    Name = "${var.environment}-inbound-ssh-sg"
    Environment = "${var.environment}"
  }
  
  depends_on  = [aws_vpc.vpc]
}