kubectl apply -f https://github.com/rancher/system-upgrade-controller/releases/latest/download/system-upgrade-controller.yaml
kubectl apply -f https://github.com/rancher/system-upgrade-controller/releases/latest/download/crd.yaml


kubectl apply -f server-plan.yaml

#cert-manager
helm repo add jetstack https://charts.jetstack.io
helm install node-exporter prometheus-community/prometheus-node-exporter -n monitoring --create
#install cert manager (for nginx gateway api)
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --set config.apiVersion="controller.config.cert-manager.io/v1alpha1" --set config.kind="ControllerConfiguration" --set config.enableGatewayAPI=true --set crds.enabled=true
#letsencrypt ClusterIssuer (Cloudflare DNS-01) - token secret must be in cert-manager ns
kubectl apply -n cert-manager -f cloudflare-token.yaml
kubectl apply -f ..\hello-world\cluster-issuer-cloudflare.yaml

#for ingress-nginx
helm install cert-manager oci://quay.io/jetstack/charts/cert-manager --namespace cert-manager --create-namespace --set crds.enabled=true
helm uninstall cert-manager --namespace cert-manager 


#nginx ingress controller (classic - use gateway api instead)
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace
#simple one
helm install ingress-nginx oci://registry-1.docker.io/bitnamicharts/nginx-ingress-controller -n ingress-nginx

helm install ingress-nginx bitnami/nginx-ingress-controller -n ingress-nginx
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace --set controller.service.type=NodePort --set controller.service.nodePorts.http=30080 --set controller.service.nodePorts.https=30443
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace --set controller.service.type=NodePort 

helm uninstall ingress-nginx -n ingress-nginx

#this works
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.2/deploy/static/provider/cloud/deploy.yaml -n ingress-nginx
helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace
#nginx gateway api (CRDs first)
kubectl kustomize https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard | kubectl apply -f -
helm install ngf oci://ghcr.io/nginx/charts/nginx-gateway-fabric --create-namespace -n nginx-gateway -f ngf-values.yaml

helm uninstall ngf -n nginx-gateway

