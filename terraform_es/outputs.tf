output "bastion_public_ip" {
  value = module.ec2.bastion_public_ip
}

output "private_ec2_private_ip" {
  value = module.ec2.private_ec2_private_ip
}

output "vpc_peering_connection_id" {
  value = module.vpc_peering.vpc_peering_connection_id
}

output "IP_Public_Bastion" {
  value = module.ec2.bastion_public_ip
  
}

output "IP_elasticsearch" {
  value = module.ec2.private_ec2_private_ip
  
}
