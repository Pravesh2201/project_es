output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_instance_id" {
  value = module.ec2.public_instance_id
}

output "private_instance_id" {
  value = module.ec2.private_instance_id
}

output "IP_Public_Bastion" {
  value = module.ec2.bastion_instance
  
}
output "IP_elasticsearch" {
  value = module.ec2.elasticsearch
  
}


