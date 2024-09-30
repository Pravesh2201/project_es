output "public_instance_id" {
  value = aws_instance.public_instance.id
}

output "private_instance_id" {
  value = aws_instance.private_instance.id
}

output "bastion_instance" {
  description = "public Ip addredd"
  value = aws_instance.public_instance.public_ip
  
}

output "elasticsearch" {
  description = "private ip address"
  value = aws_instance.private_instance.private_ip
  
}