#!/bin/bash

set -e

echo "[1/4] Initialisation de Terraform..."
terraform init

echo "[2/4] Vérification du plan..."
terraform plan -var-file="terraform.tfvars"

echo "[3/4] Application du plan..."
terraform apply -var-file="terraform.tfvars" -auto-approve

echo "[4/4] Déploiement terminé. Résultats :"
terraform output