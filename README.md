# How to deploy the lab

1. Create a nginx 

```bash
helm repo add nginx-stable https://helm.nginx.com/stable
helm install nginx-ingress nginx-stable/nginx-ingress
```

2. Apply kubectl resources (external-dns, hack-apps)
Replace the configuration in external-dns.yaml to specify the right role arn for external dns.
Also specify the right domain in domain-filter
Lastly configure a host for the imagetragick app

```bash
kubectl apply -f hack-apps --recursive
kubectl create namespace external-dns
kubectl apply -f external-dns --recursive
```
