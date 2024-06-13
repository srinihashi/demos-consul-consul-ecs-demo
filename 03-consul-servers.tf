locals {
  consul_dns = aws_instance.consul[0].public_dns
}

resource "aws_instance" "consul" {
  count         = var.consul_server_count
  ami           = var.ami # Amazon Linux 2 AMI (change as needed)
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnets[0]
  #iam_instance_profile = iam_instance_profile.consul.name

  tags = {
    Name        = "ConsulServer"
    consul-join = "yes"
  }
  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y yum-utils shadow-utils
                sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
                sudo yum -y install consul-enterprise
                EOF

  # Security group to allow Consul communication
  vpc_security_group_ids = [aws_security_group.consul_sg.id]

  # Key pair for SSH access
  key_name = var.key_name # Change to your key pair name
}


resource "aws_security_group" "consul_sg" {
  name        = "consul_sg"
  description = "Allow Consul traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8502
    to_port     = 8502
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8300
    to_port     = 8302
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8600
    to_port     = 8600
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  /*****
  ingress {
    from_port   = 32502 # Connecting dataplane to Consul server
    to_port     = 32502
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 32500 # Connection dataplane to Consul server /agent/self
    to_port     = 32500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  


  
*******/
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/*******
resource "aws_iam_instance_profile" "consul" {
  name = "consul_instance_profile"
  role = aws_iam_role.role.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


resource "aws_iam_role" "role" {
  name = "consul_role"
  path = "/"
}
********/


/****
// Configure Proxy defaults
// The following example sets the default protocol for all proxies to http.
resource "consul_config_entry" "proxy_default_protocol_http" {
  #depends_on = [module.dc1]

  kind     = "proxy-defaults"
  name     = "global"
  Namespace = "default" # Can only be set to "default"
  provider = consul.dc1-cluster

  config_json = jsonencode({
    Sources = [
      {
        protocol = "http"
      }
    ]
  })
}
*****/