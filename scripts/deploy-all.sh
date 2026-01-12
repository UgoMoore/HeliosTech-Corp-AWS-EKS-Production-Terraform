#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Starting full infrastructure deployment..."

MODULES=(
  "01-vpc"
  "02-bastion"
  "03-eks"
)

for module in "${MODULES[@]}"; do
  echo "➡️ Deploying $module"
  cd "$module"

  terraform init -reconfigure
  terraform apply -auto-approve

  cd ..
done

echo "✅ All infrastructure deployed successfully!"
