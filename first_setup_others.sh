#!/bin/sh

minikube kubectl -- get po -A

snap install kubectl --classic

kubectl version --client

curl -sL https://cli.openfaas.com | sudo sh

curl -SLsf https://dl.get-arkade.dev/ | sudo sh

arkade install openfaas

kubectl rollout status -n openfaas deploy/gateway

kubectl port-forward -n openfaas svc/gateway 8080:8080 &

kubectl -n openfaas get deployments -l "release=openfaas, app=openfaas"

kubectl get svc -o wide gateway-external -n openfaas

PASSWORD=$(kubectl get secret -n openfaas basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode; echo)

echo -n $PASSWORD | faas-cli login --username admin -password-stdin

echo $PASSWORD
