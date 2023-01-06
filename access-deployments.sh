kubectl apply -f dev/regular-apps/busybox/deployment.yaml
kubectl apply -f dev/regular-apps/rbac-misconfig/deployment.yaml
kubectl apply -f dev/regular-apps/reverseshell-app/deployment.yaml
kubectl apply -f dev/regular-apps/ssrf-app/deployment.yaml

export POD_NAME=$(kubectl get pods --namespace default -l "app=imagetragick" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $POD_NAME--address 0.0.0.0 1232:8080 > /dev/null 2>&1 &

export POD_NAME=$(kubectl get pods --namespace default -l "app=internal-proxy" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $POD_NAME --address 0.0.0.0 1233:3000 > /dev/null 2>&1 &

export POD_NAME=$(kubectl get pods --namespace default -l "app=hunger-check" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $POD_NAME --address 0.0.0.0 1234:8080 > /dev/null 2>&1 &