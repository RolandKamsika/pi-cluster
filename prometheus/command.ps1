kubectl create namespace prometheus
helm install prometheus oci://ghcr.io/prometheus-community/charts/kube-prometheus-stack -n prometheus

helm uninstall prometheus -n prometheus  

kubectl apply -f ingress.yaml -n prometheus  

kubectl apply -f grafana-secrets.yaml -n prometheus  