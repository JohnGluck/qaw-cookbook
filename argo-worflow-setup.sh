kubectl create namespace argo
helm install argo argo/argo-workflows --namespace argo     --set server.extraArgs[0]="--auth-mode=server"
kubectl apply -f .argo/infrastructure/rbac.yml 
kubectl apply -f .argo/infrastructure/service_account.yml 
kubectl create serviceaccount argo-client -n argo
kubectl create rolebinding argo-client-admin --clusterrole=admin --serviceaccount=argo:argo-client -n argo
SECRET_NAME=$(kubectl get serviceaccount argo-client -n argo -o jsonpath='{.secrets[0].name}')
TOKEN=$(kubectl get secret $SECRET_NAME -n argo -o jsonpath='{.data.token}' | base64 --decode)
kubectl create -n argo -f .argo/workflows/playwright_workflow.yml
