docker build -t corb450/multi-client:latest -t corb450/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t corb450/multi-server:latest -t corb450/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t corb450/multi-worker:latest -t corb450/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push corb450/multi-client:latest
docker push corb450/multi-server:latest
docker push corb450/multi-worker:latest

docker push corb450/multi-client:latest:$SHA
docker push corb450/multi-server:latest:$SHA
docker push corb450/multi-worker:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=corb450/multi-server:$SHA
kubectl set image deployments/client-deployment client=corb450/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=corb450/multi-worker:$SHA