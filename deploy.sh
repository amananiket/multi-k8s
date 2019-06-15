docker build -t aaniket/multi-client:latest -t aaniket/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aaniket/multi-worker:latest -t aaniket/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t aaniket/multi-server:latest -t aaniket/multi-server:$SHA -f ./server/Dockerfile ./server

docker push aaniket/multi-client:latest
docker push aaniket/multi-server:latest
docker push aaniket/multi-worker:latest

docker push aaniket/multi-client:$SHA
docker push aaniket/multi-server:$SHA
docker push aaniket/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aaniket/multi-server:$SHA
kubectl set image deployments/client-deployment client=aaniket/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aaniket/multi-worker:$SHA

