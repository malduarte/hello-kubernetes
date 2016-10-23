#!/usr/bin/env bash

export K8S_VERSION=v1.4.1
# linux/darwin
export GOOS=darwin 

# one of 386/amd64/arm/arm64/ppc64le
export GOARCH=amd64

export BASEURL=https://storage.googleapis.com/kubernetes-release/release

curl -Lo kubectl ${BASEURL}/${K8S_VERSION}/bin/${GOOS}/${GOARCH}/kubectl


./minikube config set cpus 4
./minikube config set memory 4096

# Optional - by default it uses virtualbox
./minikube config set vm-driver xhyve
