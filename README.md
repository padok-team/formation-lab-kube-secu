# How to deploy the lab

1. Create a nginx 

```bash
helm install nginx-ingress nginx-stable/nginx-ingress
```

2. Apply kubectl resources (external-dns, hack-apps)

```bash
kubectl apply -f .
```

Todo

delet external-dns.back
delete ingress-nginx
delete rbac-misconfig
