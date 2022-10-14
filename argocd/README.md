# ArgoCD on F5 XC
> using AppStack (not vK8s!)

## Steps
1. Create `lk-argocd` namespace in **XC**:
2. Apply Cluster Roles:
  - Manage K8s -> K8s Cluster Roles
  - Cluster Role -> Advanced Fields -> K8s YAML
  - paste the ClusterRoles from [roles.yml](./argocd/yml/roles.yml)
3. Apply Cluster Roles Binding:
  - Manage K8s -> K8s Cluster Role Binging
  - Cluster Role -> Service Account -> Namespace `lk-argocd` -> Name (= Cluster Role Name)
4. Apply Manifest:
    ```bash
    # Apply CRDs
    export KUBECONFIG="<localAPI>"
    kubectl apply -k https://github.com/argoproj/argo-cd/manifests/crds\?ref\=stable
    # Apply Manifest
    kubectl apply -f yml/manifest.yml
    ```
5. Get info about the deployment:
    ```bash
    kubectl get svc -n lk-argocd
    kubectl get pod -n lk-argocd
    ```
6. Create HTTP LB and Origin Pool:
  - it has to be in the same namespace in **XC** as it is in **k8s**
    ```bash
    vesctl configuration apply origin_pool -i ./argocd/ves/origin-pool.yml
    vesctl configuration apply http_loadbalancer -i ./argocd/ves/http-lb.ym
    ```
7. Login to ArgoCD:
  - url: [https://argocd.xc.f5demo.app](https://argocd.xc.f5demo.app)
  - login: `admin`
  - password: `paper`