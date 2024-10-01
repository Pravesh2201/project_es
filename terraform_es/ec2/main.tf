
# Bastion EC2 Instance
resource "aws_instance" "bastion" {
  ami           = "ami-0a0e5d9c7acc336f1"
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = var.public_subnet_id
  security_groups = [var.bastion_sg_id]

root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "Bastion Host"
  }
}

# Private EC2 Instance for elsaticsearch
resource "aws_instance" "private_ec2" {
  ami           = "ami-0a0e5d9c7acc336f1"
  instance_type = "t2.medium"
  key_name      = var.key_name
  subnet_id     = var.private_subnet_id
  security_groups = [var.private_sg_id] # Use security_group_ids here
 root_block_device {
    volume_size = 40
  }

  tags = {
    Name = "ElasticSearch"
  }
}
