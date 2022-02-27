## Deploying a NodeJS & Nginx cluster to K8s via Helm

### Snapshots:

1. [Basic project setup](https://github.com/abinavseelan/helm-nodejs-nginx/tree/25c3e8043246155ae5e61de20ea366f7ba385049);

2. [Dockerization](https://github.com/abinavseelan/helm-nodejs-nginx/tree/8ea94b65627d96590feb15c3878ebac6653e2e27)

3. [Adding resource manifests](https://github.com/abinavseelan/helm-nodejs-nginx/tree/871a06c845ea798a1afa857cb5f822be00b1b3ba)

4. [Moving everything to helm](https://github.com/abinavseelan/helm-nodejs-nginx/tree/1e84eef5acb61422083f13d479cbc64bcd1cc1b1)

## Docker build
* docker build . -f app/Dockerfile -t app-server:latest
* docker build . -f userservice/Dockerfile -t user-service:latest
* docker build . -f nginx/Dockerfile -t app-nginx:latest

## Docker run
* docker run -d -p 6001:3000 app-server:v1
* docker run -d -p 6002:4000 user-service:v1
* docker run -d -p 6003:80 app-nginx:v1

## Minikube
* minikube start --driver=docker
* eval $(minikube docker-env)

## Kubernetes
* kubectl config get-contexts
* kubectl apply -f app/deployment.yaml
* minikube dashboard
* kubectl apply -f app/service.yaml
* minikube dashboard
* kubectl apply -f userservice/deployment.yaml
* kubectl apply -f userservice/service.yaml
* kubectl apply -f nginx/deployment.yaml
* kubectl apply -f nginx/service.yaml

## Config Loadbalancer
* minikube service nginx-loadbalancer-service

## Helm
* helm install ./k8s --dry-run --generate-name
* helm install ./k8s --generate-name

## Helm Upgrade
* helm list
* helm upgrade k8s-1645973291 ./k8s