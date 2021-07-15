provider "aws" {    
    region = "sa-east-1"
}

resource "aws_instance" "dev" {
    ami = "ami-054a31f1b3bf90920"
    instance_type = "t2.micro"
    key_name = "terraform-aws"    
    tags = {
        Name = "dev environment"
    }

    provisioner "local-exec" {
      command = "echo '[sandboxterraform]' > ./ansible/hosts"
    }
    
    vpc_security_group_ids = [
      "${aws_security_group.acesso-ssh.id}", 
      "${aws_security_group.allow_http.id}",
      "${aws_security_group.allow_php.id}",
      "${aws_security_group.allow_python.id}",
    ]
}

resource "null_resource" "insert-host-ansible" {  
  provisioner "local-exec" {
    command = "echo '${aws_instance.dev.public_ip}' >> ./ansible/hosts"
  }
}

resource "aws_security_group" "acesso-ssh" {
  ingress {    
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["191.193.101.215/32"]
  }

  tags = {
      name = "ssh"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

resource "aws_security_group" "allow_php" {
  name        = "allow_php"
  description = "Allow HTTP inbound traffic"

  ingress {
    description      = "HTTP from VPC"
    from_port        = 8000
    to_port          = 8000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_php"
  }
}

resource "aws_security_group" "allow_python" {
  name        = "allow_python"
  description = "Allow HTTP inbound traffic"

  ingress {
    description      = "HTTP from VPC"
    from_port        = 5000
    to_port          = 5000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_python"
  }
}

output "op1"{  
  value = aws_instance.dev.public_ip
}
