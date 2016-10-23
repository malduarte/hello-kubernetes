./minikube start
./kubectl get pods --all-namespaces
echo eval "$(./minikube docker-env)"
docker build -t devopslx_2016:v1 .
docker run -d -p 6969:6969 --name hello_devops_2016 devopslx_2016:v1
curl http://$(./minikube ip):6969
docker stop hello_devops_2016
./kubectl run hellodevopslx --image=devopslx_2016:v1  --port=6969
./kubectl get deployment
./kubectl get pod
nohup ./kubectl proxy 2>&1 > proxy_log  &
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
for i in `seq 1 10`; do echo $(curl -s http://localhost:8001/api/v1/proxy/namespaces/default/pods/$POD_NAME/$i)  ; done
./kubectl logs $POD_NAME
./kubectl get services
./kubectl expose deployment/hellodevopslx --type="NodePort" --port 6969
./kubectl get services
./kubectl describe services/hellodevopslx
export NODE_PORT=$(kubectl get services/hellodevopslx -o go-template='{{(index .spec.ports 0).nodePort}}')
curl http://$(./minikube ip):$NODE_PORT
./kubectl describe deployment
./kubectl label pod $POD_NAME app=v1
./kubectl get pods -l app=v1
./kubectl scale deployments/hellodevopslx --replicas=4
cp server_with_ip.js simple_server.js
docker build -t devopslx_2016:v2 .
./kubectl set image deployments/hellodevopslx hellodevopslx=devopslx_2016:v2
for i in `seq 1 10`; do echo $(curl -s http://$(./minikube ip):$NODE_PORT); done
freestyle