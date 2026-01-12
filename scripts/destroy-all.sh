#!/usr/bin/env bash
set -euo pipefail

echo "🔥 Starting full infrastructure teardown..."

MODULES=(
  "03-eks"
  "02-bastion"
  "01-vpc"
)

for module in "${MODULES[@]}"; do
  echo "⬅️ Destroying $module"
  cd "$module"

  terraform init -reconfigure
  terraform destroy -auto-approve

  cd ..
done

echo "🧼 All infrastructure destroyed cleanly!"
