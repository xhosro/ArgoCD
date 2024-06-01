# If you dont want to use terraform, you can use directly this command:
# helm install argocd -n argocd --create-namespace argo/argo-cd --version 3.35.4 -f terraform/values/argocd.yaml

resource "helm_release" "argocd" {
    name = "argocd"
    namespace = "argocd"
    create_namespace = true
    chart = "argo-cd"
    version = "3.35.4"
    repository = "https://argoproj.github.io/argo-helm"

    values = [file("values/argocd.yaml"))]
  
}
# one way is to use set statements and to target individual values
# When you need to setup toleration and affinity, its a lot of set statements and it becomes not readable.