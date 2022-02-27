# UAT1

## Step #1

* DigitalOcean Variable

```shell
export DO_TOKEN=09fa688be6e376e329fdbb83c71778a96d321d4c3c6be42b31db981ebeb45ac9
export AWS_ACCESS_KEY_ID=34PULJD67BR5VHI7HVDS
export AWS_SECRET_ACCESS_KEY=JKO5oJczWNmmGKAl58aEmeZ1gYn4t/hrEQXmuzF/bx4

doctl auth init --access-token $DO_TOKEN
terraform init  --backend-config="access_key=$AWS_ACCESS_KEY_ID" --backend-config="secret_key=$AWS_SECRET_ACCESS_KEY"
aws configure --profile testing-digitalocean
```

* Connecting Cluster

```shell
doctl kubernetes cluster kubeconfig save testing-cluster-1
```

* Add 'Helm' repo

```shell
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update ingress-nginx
    helm search repo ingress-nginx
```

* Install Ingress Nginx Controller

```shell
helm install ingress-nginx ingress-nginx/ingress-nginx --version "4.0.13" \
  --namespace ingress-nginx \
  --create-namespace \
  -f "1-nginx-ingress-controller/nginx-values-v4.0.13.yaml"
```

* Verify Nginx

```shell
helm ls -n ingress-nginx
```

* Check kubernetes resource for the Nginx Check the `LoadBalancer` resource having an `external IP` assigned

```shell
kubectl get all -n ingress-nginx
```

* Check the list of all load balancer

```shell
doctl compute load-balancer list --format IP,ID,Name,Status
```

## Step 2 - Configuring DNS for Nginx Ingress Controller
* doctl compute domain create testing-v1.chiangmars.com
* kubectl get svc -n ingress-nginx   // to identify External IP of load-balancer
* Add the records
```shell
doctl compute domain records create chiangmars.com --record-type "A" --record-name "testing-v1" --record-data "138.197.225.46" --record-ttl "3600"
```
* List available domain
```shell
doctl compute domain records list chiangmars.com
```

## Step 3 - Creating the Nginx Backend Services
* kubectl create ns backend-test-v1
* kubectl apply -f 2-backend-deployment/test-v1-deployment.yaml
* kubectl apply -f 3-backend-service/test-v1-service.yaml
* kubectl get deployments -n backend-test-v1
* kubectl get services -n backend-test-v1

## Step 4 - Configuring Nginx Ingress Rules for Backend Services
* kubectl apply -f 4-nginx-ingress-rule/test-v1-host-nginx.yaml
* kubectl get ingress -n backend-test-v1

## Step 5 - Install Certificate Manager
* kubectl get issuer -n backend-test-v1
* kubectl apply -f 5-certificate-manager/cert-manager-nginx-issuer.yaml

## Step 6 -  Configure each Nginx ingress resource to use TLS
* kubectl apply -f 6-tls/test-v1-host-nginx.yaml

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
