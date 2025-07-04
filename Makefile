# Makefile pour projet Terraform + Ansible

.PHONY: init plan apply destroy deploy ansible

init:
	echo "🔧 Initialisation de Terraform"
	terraform init

plan:
	echo "📋 Planification de l'infrastructure"
	terraform plan -var-file="terraform.tfvars"

apply:
	echo "🚀 Déploiement complet avec Terraform"
	terraform apply -var-file="terraform.tfvars"
	echo "✅ Terminé. IP publique :"
	terraform output

ansible:
	echo "🎯 Provisionnement avec Ansible"
	bash provision.sh $$(terraform output -raw instance_public_ip) debian ~/.ssh/mykey.pem

deploy:
	make init && make plan && make apply && make ansible

destroy:
	echo "⚠️ Suppression de l'infrastructure (confirmation requise)"
	terraform destroy -var-file="terraform.tfvars"
