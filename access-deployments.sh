export POD_NAME=$(kubectl get pods --namespace default -l "app=imagetragick" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward imagetragick-66fbb6b558-69hwd --address 0.0.0.0 1235:8080 > /dev/null 2>&1 &

export POD_NAME=$(kubectl get pods --namespace default -l "app=internal-proxy" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $POD_NAME --address 0.0.0.0 1232:3000 > /dev/null 2>&1 &