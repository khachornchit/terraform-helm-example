#!/usr/bin/env sh

set -e

terraform apply -auto-approve

printf "\nWaiting for the echo web server service... \n"
kubectl apply -f manifests/usage.yaml
sleep 10

printf "\nYou should see 'foo' as a reponse below (if you do the ingress is working):\n"
curl foo.chiangmars.com/foo
