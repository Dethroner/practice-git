# Памятка по командам

minikube start --vm-driver=virtualbox --cpus 4 --memory 8192/4096
minikube status
cat ~/.kube/config
kubectl get nodes
kubectl get pods --all-namespaces
kubectl config get-contexts

cd /_projects/practice-git/k8s

kubectl config set-context Deployment \
	--namespace=Deployment \
    --cluster=minikube \
    --user=minikube
или
kubectl apply -f create-namespace.yml
kubectl get namespaces

kubectl apply -f ui-deployment.yml
kubectl apply -f ./comment -n dev

kubectl get deployment

kubectl get pods --selector component=ui
kubectl port-forward ui-7dbcc656cf-bqzj9 8080:9292
Проброс порта работает только пока активна команда.
kubectl port-forward <ui-pod> 8080:9292
kubectl port-forward <post-pod> 5000:5000
kubectl port-forward <comment-pod> 9292:9292
http://localhost:8080
http://localhost:5000/healthcheck
http://localhost:9292/healthcheck

kubectl apply -f _projects/practice-git/k8s/post-deployment.yml

kubectl get pods -n dev -o wide
kubectl get services -n dev -o wide

minikube service ui
minikube services list

minikube addons list
minikube addons enable dashboard
minikube dashboard

minikube stop
minikube delete