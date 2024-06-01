# Argo CD

first of all we need a kubernetes cluster
we will use a minikube in my mac with docker daemon  desktop application

docker images
minikube start --kubernetes-version=v1.30.0 --driver=docker 

it wil allow minikube to create kubernetes nodes as docker container
if you choose virtualbox , minikube will create a virtual machine as kubernetes
when you run it, it will pull a docker images and bootstrap the kubernetes cluster locally
and configure kubectl to talk to the cluster.

kubectl get nodes
we have one node that is control plane too
kubectl get pods
kubectl get services
kubectl describe node minikube | less

Taints: <none>
minikube removes the taints from control plane, which prevents the scheduling of new pods


we use helm charts beacause now is the most common way 
if you dont want to use helm, you can run helm template command to generate the yaml file

add argocd helm chart:
 helm repo add argo https://argoproj.github.io/argo-helm

everytime you add a new repo, you must uodate the index 
 helm repo update

 helm search repo argocd
 argo/argo-cd                    3.35.4          v2.2.5          A Helm chart for ArgoCD, a declarative, GitOps ...

most of the time, we want to override at least a few defaults variables
  to get defaults, we can run:
    helm show values argo/argo-cd --version 3.35.4 > argo-cd-defaults.yaml


now we want to install helm directly and with terraform

first we create a terraform folder


  

