## Getting start

## Docker build

```shell
docker build . -f app/Dockerfile -t app-server:latest
docker build . -f userservice/Dockerfile -t user-service:latest
docker build . -f nginx/Dockerfile -t app-nginx:latest
```

## Minikube
* minikube start --driver=docker
* eval $(minikube docker-env)

## Helm
* helm install minikube --dry-run --generate-name
* helm install minikube --generate-name

## Browse Application
* kubectl get services
* minikube service xxx

## Helm Upgrade
* helm list
* helm upgrade k8s-1645973291 minikube

## Docker
* docker rmi $(docker images | grep 'imagename')
