# UAT1

## DigitalOcean Variable
```shell
export DO_TOKEN=09fa688be6e376e329fdbb83c71778a96d321d4c3c6be42b31db981ebeb45ac9
export AWS_ACCESS_KEY_ID=34PULJD67BR5VHI7HVDS
export AWS_SECRET_ACCESS_KEY=JKO5oJczWNmmGKAl58aEmeZ1gYn4t/hrEQXmuzF/bx4

doctl auth init --access-token $DO_TOKEN
terraform init  --backend-config="access_key=$AWS_ACCESS_KEY_ID" --backend-config="secret_key=$AWS_SECRET_ACCESS_KEY"
aws configure --profile testing-digitalocean
```

## Connecting Cluster 
```shell
doctl kubernetes cluster kubeconfig save testing-cluster-1
doctl kubernetes cluster kubeconfig save 6b78a268-1d32-4369-882c-9132e285adad
```

## Install Ingress Nginx Controller
```shell
NGINX_CHART_VERSION="4.0.17"

helm install ingress-nginx ingress-nginx/ingress-nginx --version "4.0.17" \
  --namespace ingress \
  --create-namespace \
  -f "manifests/nginx-values-v4.0.17.yaml"
```

## Terraform
```shell
terraform init

# Create workspace if it doesn't exist and select
terraform workspace select UAT1 || terraform workspace new UAT1

# Initialize inside workspace
terraform init

# List workspaces and see currently selected workspace
terraform workspace list
  default
* uat1

# Plan and save to file
terraform plan -out plan.out

# Apply above plan
terraform apply plan.out
```
