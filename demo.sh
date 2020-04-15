
set -x

# Deploy helm operator
kustomize build --load_restrictor LoadRestrictionsNone manifests/functions/helm-operator | kubectl apply -f -
# Wait for helm operator
kubectl -n flux rollout status deployment/helm-operator
# Deploy prometheus
kustomize build --load_restrictor LoadRestrictionsNone manifests/functions/prometheus | kubectl apply -f -
# Wait for prometheus
kubectl -n prometheus wait --timeout 600s --for condition=released hr/prometheus
