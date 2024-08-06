#!/bin/sh
# Private cluster with bastion host
# Fuente: https://cloud.google.com/kubernetes-engine/docs/archive/creating-kubernetes-engine-private-clusters-with-net-proxies

#Enable APIs
gcloud services enable compute.googleapis.com 
gcloud services enable container.googleapis.com
gcloud services enable networkconnectivity.googleapis.com

# set you project
export YOUR_PROJECT_ID="semiotic-anvil-430502-e7"
gcloud config set project $YOUR_PROJECT_ID

# set default compute zone
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-c
export REGION=us-central1
export ZONE=us-central1-c

# Create a VPC network
gcloud compute networks create k8s-proxy --subnet-mode=custom

# Create a custom subnet in the newly created VPC network
gcloud compute networks subnets create subnet-cluster \
    --network=k8s-proxy --range=10.50.0.0/16

# Create a client VM which you will use to deploy resources in the Kubernetes cluster
gcloud compute instances create --subnet=subnet-cluster \
    --scopes cloud-platform proxy-temp

# Save the internal IP address of the newly created instance in an environment variable
export CLIENT_IP=`gcloud compute instances describe proxy-temp \
    --format="value(networkInterfaces[0].networkIP)"`

# Create a firewall rule to allow SSH access to the VPC network
gcloud compute firewall-rules create k8s-proxy-ssh --network k8s-proxy \
    --allow tcp:22

# Creating a private cluster
gcloud container clusters create frobnitz  \
    --master-ipv4-cidr=172.16.0.64/28 \
    --network k8s-proxy \
    --subnetwork=subnet-cluster \
    --enable-ip-alias \
    --enable-private-nodes \
    --enable-private-endpoint \
    --master-authorized-networks $CLIENT_IP/32 \
    --enable-master-authorized-networks