# tf-eks-test

Task to bootstrap EKS cluster with ArgoCD inside to deploy ingress-nginx.

## Components

- VPC
- EKS
- K8S namespace
- nginx-ingress with private loadbalancer deployed in created namespace

## How to run

```
terraform apply -var github_argocd_token=<token>
```

where **token** is github token with repo scope.

## Results

![result1](./files/result1.png)

![result2](./files/result2.png)

![result3](./files/result3.png)