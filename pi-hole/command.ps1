helm repo add mojo2600 https://mojo2600.github.io/pihole-kubernetes/
helm repo update

 kubectl create namespace pihole

 helm install pihole mojo2600/pihole -n pihole

helm uninstall pihole -n pihole

 kubectl apply -f ingress.yaml -n pihole  