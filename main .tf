erraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
 access_key = "AKIA5VRILTOXCR2WCASR"
 secret_key = "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"
}
#terraform EC2
resource "aws_instance" "ec2demo"{
 ami = "ami-00b8917ae86a424c9"
 instance_type ="t2.micro"
 tags = {
 Name = "ec2demo"
 }
}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
