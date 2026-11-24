helm install backstage oci://ghcr.io/backstage/charts/backstage --version 2.6.3 -n backstage -f values.yaml

helm upgrade backstage oci://ghcr.io/backstage/charts/backstage --version 2.6.3 -n backstage -f values.yaml

helm uninstall backstage -n backstage

helm install postgresql bitnami/postgresql --version 18.5.16 -n backstage

helm uninstall postgresql -n backstage

kubectl apply -f postgres/postgres-secrets.yaml -n backstage
kubectl apply -f postgres/postgres-storage.yaml -n backstage
kubectl apply -f postgres/postgres.yaml -n backstage
kubectl apply -f postgres/postgres-service.yaml -n backstage

kubectl apply -f backstage.yaml -n backstage

kubectl delete -f backstage.yaml -n backstage

kubectl delete -f postgres/postgres-secrets.yaml -n backstage
kubectl delete -f postgres/postgres-storage.yaml -n backstage
kubectl delete -f postgres/postgres.yaml -n backstage
kubectl delete -f postgres/postgres-service.yaml -n backstage