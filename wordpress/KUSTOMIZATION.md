# KUSTOMIZATION

## Build
```bash
cd kustomization
kustomize build .
# or
kubectl kustomize .
```

## Apply
```bash
cd kustomization
kubectl apply -k .
```