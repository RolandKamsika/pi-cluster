kubectl create namespace coffee
kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.5.1/examples/advanced-routing/coffee.yaml -n coffee

kubectl apply -f gateway-tls.yaml -n coffee
kubectl delete -f gateway.yaml -n coffee

kubectl apply -f listenerset.yaml -n coffee

kubectl apply -f route-tls.yaml -n coffee

kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.5.1/examples/advanced-routing/tea.yaml -n coffee

kubectl apply -f tea-route.yaml -n coffee
kubectl delete -f tea-route.yaml -n coffee