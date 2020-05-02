docker build -t ganiths/multi-client:latest -t ganiths/multi-client:$GIT_SHA ./client/Dockerfile ./client
docker build -t ganiths/multi-server:latest -t ganiths/multi-server:$GIT_SHA ./server/Dockerfile ./server
docker build -t ganiths/multi-worker:latest -t ganiths/multi-worker:$GIT_SHA ./worker/Dockerfile ./worker


docker push ganiths/multi-client:latest
docker push ganiths/multi-server:latest
docker push ganiths/multi-worker:latest

docker push ganiths/multi-client:$GIT_SHA
docker push ganiths/multi-server:$GIT_SHA
docker push ganiths/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=ganiths/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=ganiths/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=ganiths/multi-worker:$GIT_SHA