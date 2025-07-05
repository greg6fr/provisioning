output "instance_public_ip" {
  description = "Adresse IP publique de l'instance EC2"
  value       = aws_instance.devops_vm.public_ip
}

output "ssh_connection" {
  description = "Commande SSH pour te connecter à l'instance"
  value       = "ssh -i ~/provisioning/mykeyterraform.pem admin@${aws_instance.devops_vm.public_ip}"
}
