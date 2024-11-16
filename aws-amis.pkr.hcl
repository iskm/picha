packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"

    }

  }

}

variable "ami_prefix" {
  type    = string
  default = "homelab-aws"

}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")

}

source "amazon-ebs" "debian" {
  ami_name      = "${var.ami_prefix}-debian-${local.timestamp}"
  instance_type = "t2.medium"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "Debian 12"
      root-device-type    = "ebs"
      virtualization-type = "hvm"

    }
    most_recent = true
    owners      = ["136693071363"]

  }
  ssh_username = "admin"

}

source "amazon-ebs" "amazon" {
  ami_name      = "${var.ami_prefix}-amazon-${local.timestamp}"
  instance_type = "t2.medium"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "Amazon Linux 2023 AMI"
      root-device-type    = "ebs"
      virtualization-type = "hvm"

    }
    most_recent = true
    owners      = ["amazon"]

  }
  ssh_username = "ec2-user"

}

source "amazon-ebs" "redhat" {
  ami_name      = "${var.ami_prefix}-redhat-${local.timestamp}"
  instance_type = "t2.medium"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "Red Hat Enterprise Linux 9 (HVM)"
      root-device-type    = "ebs"
      virtualization-type = "hvm"

    }
    most_recent = true
    owners      = ["309956199498"]

  }
  ssh_username = "ubuntu"

}

build {
  name = "AMIs for homelab use"
  sources = [
    "source.amazon-ebs.debian",
    "source.amazon-ebs.amazon",
    "source.amazon-ebs.redhat"
  ]

  provisioner "shell" {
   script = "scripts/initial.sh"
  }

  provisioner "file" {
    source = "files/id_rsa.pub"
    destination = "/home/"

  }

}

