docker build -t mandartelitech/multi-client:latest -t mandartelitech/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mandartelitech/multi-server:latest -t mandartelitech/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mandartelitech/multi-worker:latest -f mandartelitech/multi-worker:$SHA ./worker/Dockerfile ./worker


docker push mandartelitech/multi-client:latest
docker push mandartelitech/multi-server:latest
docker push mandartelitech/multi-worker:latest

docker push mandartelitech/multi-client:$SHA
docker push mandartelitech/multi-server:$SHA
docker push mandartelitech/multi-worker:$SHA

kubectl apply -f /k8s

kubectl set image deployments/server-deployment server=mandartelitech/multi-server:$SHA
kubectl set image deployments/client-deployment client=mandartelitech/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mandartelitech/multi-worker:$SHA

