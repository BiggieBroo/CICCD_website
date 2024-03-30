provider "aws" {
	region = var.region
}

resource "aws_vpc" "dev_vpc" {
	tags = {
		Name: "${var.env}-vpc"
	}
	cidr_block = var.vpc_cidr
}

resource "aws_subnet" "dev_subnet" {
	tags = {
		Name: "${var.env}-subnet"
	}
	vpc_id = aws_vpc.dev_vpc.id
	cidr_block = var.subnet_cidr
	availability_zone = var.zone
}

resource "aws_internet_gateway" "dev_igw" {
	tags = {
		Name: "${var.env}-igw"
	}
	vpc_id = aws_vpc.dev_vpc.id
}

resource "aws_default_route_table" "dev_route_table" {
	tags = {
		Name: "${var.env}-route-table"
	}
	default_route_table_id = aws_vpc.dev_vpc.default_route_table_id
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.dev_igw.id
	}
}

resource "aws_default_security_group" "dev_sg" {
	tags = {
		Name: "${var.env}-sg"
	}
	vpc_id = aws_vpc.dev_vpc.id
	ingress {
		from_port = 22
		to_port = 22
		protocol = "TCP"
		cidr_blocks = var.ip_acl
	}
	/*
	ingress {
		from_port = 8080
		to_port = 8080
		protocol = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
	}
	*/
	egress {
		from_port = 0
		to_port = 0
		protocol = "TCP"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

data "aws_ami" "dev_ami" {
	most_recent = true
	owners = ["amazon"]
	filter {
		name = "name"
		values = ["al2023-ami-2023.4.20240319.1-kernel-6.1-x86_64"]
	}
}

resource "aws_instance" "dev_instance" {
	ami = data.aws_ami.dev_ami.id
	availability_zone = var.zone
	instance_type = var.instance
	vpc_security_group_ids = [aws_default_security_group.dev_sg.id]
	key_name = "dev-key-pair"
	associate_public_ip_address = true
	subnet_id = aws_subnet.dev_subnet.id
	tags = {
		Name: "${var.env}-instance"
	}
}

output "ec2_public_ip" {
	value = aws_instance.dev_instance.public_ip
}