#CONTAINER DEPLOYS
docker build -t jeffersonpino/complex-client:latest -t jeffersonpino/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t jeffersonpino/complex-server:latest -t jeffersonpino/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t jeffersonpino/complex-worker:latest -t jeffersonpino/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jeffersonpino/complex-client:latest
docker push jeffersonpino/complex-server:latest
docker push jeffersonpino/complex-worker:latest

docker push jeffersonpino/complex-client:$SHA
docker push jeffersonpino/complex-server:$SHA
docker push jeffersonpino/complex-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jeffersonpino/complex-server:$SHA
kubectl set image deployments/client-deployment client=jeffersonpino/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=jeffersonpino/complex-worker:$SHA