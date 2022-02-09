# Oracle Cloud-Native DevOps + Kubernetes DB Operator
CI/CD for microservices using Jenkins on Oracle Cloud Infrastructure (OCI)

## Requirements
This lab will create the following resources:
1. Oracle Cloud Infrastructure Registry (OCIR)
2. Oracle Kubernetes Engine (OKE) cluster
3. Networking resources (VCN, Subnets, LoadBalancer)
4. Bastion Service
5. Access to the OCI console and policies to manage resources used above

## Getting Started

1. [Provision through Terraform](documentation/1.terraform.md)
2. [Setup Jenkins Pipeline and GitHub webhook](documentation/4.pipeline.md)
