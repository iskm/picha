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
      image-id                = "ami-064519b8c76274859"
      root-device-type    = "ebs"
      virtualization-type = "hvm"

    }
    most_recent = true
    owners      = ["136693071363"]

  }
  ssh_username = "admin"

}

build {
  name = "AMIs for homelab use"
  sources = [
    "source.amazon-ebs.debian",
  ]

  provisioner "shell" {
   script = "scripts/initial.sh"
  }

  provisioner "file" {
    source = "files/id_rsa.pub"
    destination = "/home/admin/"

  }

}

