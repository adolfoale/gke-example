#!/bin/sh
# Public GKE Cluster

#Enable APIs
gcloud services enable compute.googleapis.com 
gcloud services enable container.googleapis.com
gcloud services networkconnectivity.googleapis.com

# Create GKE cluster
gcloud beta container \
--project "optical-caldron-421816" clusters create "standard-public-cluster-1" \
--location=us-central1 \
--no-enable-basic-auth \
--cluster-version "1.30.0-gke.1167000" \
--release-channel "rapid" \
--machine-type "e2-small" \
--image-type "COS_CONTAINERD" \
--disk-type "pd-balanced" \
--disk-size "20" \
--metadata disable-legacy-endpoints=true \
--scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
--spot --num-nodes "1" \
--logging=SYSTEM,WORKLOAD \
--monitoring=SYSTEM -\
-enable-ip-alias \
--network "projects/optical-caldron-421816/global/networks/default" \
--subnetwork "projects/optical-caldron-421816/regions/us-central1/subnetworks/default" \
--no-enable-intra-node-visibility \
--default-max-pods-per-node "110" \
--security-posture=standard \
--workload-vulnerability-scanning=disabled \
--no-enable-master-authorized-networks \
--addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver \
--enable-autoupgrade \
--enable-autorepair \
--max-surge-upgrade 1 \
--max-unavailable-upgrade 0 \
--binauthz-evaluation-mode=DISABLED \
--enable-managed-prometheus \
--workload-pool "optical-caldron-421816.svc.id.goog" \
--enable-shielded-nodes \
--node-locations "us-central1-a","us-central1-b","us-central1-c"
