kubectl create namespace helloworld
kubectl apply -f hello-world1.yaml -n hello-world
kubectl apply -f hello-world2.yaml -n hello-world
kubectl delete -f hello-world1.yaml -n hello-world
kubectl delete -f hello-world2.yaml -n hello-world

kubectl apply -f hello-world1-arm.yaml -n hello-world
kubectl delete -f hello-world1-arm.yaml -n hello-world

kubectl apply -f hello-world2-arm.yaml -n hello-world
kubectl delete -f hello-world2-arm.yaml -n hello-world

kubectl apply -f hello-world-ingress.yaml -n hello-world