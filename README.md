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
and terraform files
and we need to initialize it

terraform init
terraform apply

in another terminal we can run:

helm status argocd -n argocd

or if it is failed, we run helm without terraform first clean up with this command:

helm list --pending -A
helm uninstall argocd -n argocd


verify argocd is installed:

helm list -A
kubectl get pods -n argocd

by default, this helm chart will generate an admin password and store it in kubernetes secret
which is called initial admin secret and is used only once, you can change it if you wish

kubectl get secrets -n argocd 

to get a password , let's get this secret in yaml format
it will be encoded in base64
  kubectl get secrets argocd-initial-admin-secret -o yaml -n argocd

to decode the secret, we can use echo and pipe it to the base64 utility.

echo "RWs1WElqRTVLdFIxVDRGTw==" | base64 --decode
echo "RWs1WElqRTVLdFIxVDRGTw==" | base64 -d

Ek5XIjE5KtR1T4FO% 
the percent sign indicates the end of the string; don't copy it.

to access argocd, we can use post-forward command:
  kubectl port-forward svc/argocd-server -n argocd 8080:80

the username is admin
go to site argoCD

## Create first CD pipeline with public repo & images using GitOps

- first of all, we create a public github repository 
- in dockerhub account we find nginx images
we log in to dockerhub account with docker login --username <rhosrow>
later we need to push the images
pull the nginx image

- docker pull nginx:1.27.0

to simulate CD pipeline, we would need to incerment image tags to deploy new versions
- docker tag nginx:1.27.0 rhosrow/nginx:v0.1.0
 docker push rhosrow/nginx:v0.1.0 


 now we deploy kubernetes for this new docker image


