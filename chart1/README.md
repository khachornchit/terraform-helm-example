# Helm Chart

## Initial

```shell
export DO_TOKEN=09fa688be6e376e329fdbb83c71778a96d321d4c3c6be42b31db981ebeb45ac9
export AWS_ACCESS_KEY_ID=34PULJD67BR5VHI7HVDS
export AWS_SECRET_ACCESS_KEY=JKO5oJczWNmmGKAl58aEmeZ1gYn4t/hrEQXmuzF/bx4

doctl auth init
terraform init  --backend-config="access_key=$AWS_ACCESS_KEY_ID" --backend-config="secret_key=$AWS_SECRET_ACCESS_KEY"
terraform init -migrate-state
aws configure --profile testing-digitalocean
doctl kubernetes cluster kubeconfig save testing-cluster-1
```

## Getting Started
```shell
cd chat1
helm create mychart
helm lint ./mychart/
helm install --dry-run --debug ./mychart/ --generate-name
helm install example ./mychart/ --set service.type=NodePort
```

## Install Bitnami

```shell
** Please be patient while the chart is being deployed **

Redis&trade; can be accessed on the following DNS names from within your cluster:

    redis-master.default.svc.cluster.local for read/write operations (port 6379)
    redis-replicas.default.svc.cluster.local for read-only operations (port 6379)

To get your password run:

    export REDIS_PASSWORD=$(kubectl get secret --namespace default redis -o jsonpath="{.data.redis-password}" | base64 --decode)
->  Password: H5g4IbMyvR

To connect to your Redis&trade; server:

1. Run a Redis&trade; pod that you can use as a client:

   kubectl run --namespace default redis-client --restart='Never'  --env REDIS_PASSWORD=$REDIS_PASSWORD  --image docker.io/bitnami/redis:6.2.6-debian-10-r120 --command -- sleep infinity

   Use the following command to attach to the pod:

   kubectl exec --tty -i redis-client --namespace default -- bash

2. Connect using the Redis&trade; CLI:
   REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-master
   REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-replicas

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace default svc/redis-master : &
    REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h 127.0.0.1 -p
```

## Helm Chart

### Generate chart

* helm create mychart
* helm install --dry-run --debug ./mychart/ --generate-name

```shell
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=mychart,app.kubernetes.io/instance=mychart-1644736168" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
```

### Deploy chart

* helm install example ./mychart --set service.type=NodePort

```shell
NOTES:
1. Get the application URL by running these commands:
  export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services example-mychart)
  export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
  echo http://$NODE_IP:$NODE_PORT
```

