<div align="center" id="top"> 
  <img src="./.github/app.gif" alt="Gke Example" />

  &#xa0;

  <!-- <a href="https://gkeexample.netlify.app">Demo</a> -->
</div>

<h1 align="center">Gke Example</h1>

<p align="center">
  <img alt="Github top language" src="https://img.shields.io/github/languages/top/{{YOUR_GITHUB_USERNAME}}/gke-example?color=56BEB8">

  <img alt="Github language count" src="https://img.shields.io/github/languages/count/{{YOUR_GITHUB_USERNAME}}/gke-example?color=56BEB8">

  <img alt="Repository size" src="https://img.shields.io/github/repo-size/{{YOUR_GITHUB_USERNAME}}/gke-example?color=56BEB8">

  <img alt="License" src="https://img.shields.io/github/license/{{YOUR_GITHUB_USERNAME}}/gke-example?color=56BEB8">

  <!-- <img alt="Github issues" src="https://img.shields.io/github/issues/{{YOUR_GITHUB_USERNAME}}/gke-example?color=56BEB8" /> -->

  <!-- <img alt="Github forks" src="https://img.shields.io/github/forks/{{YOUR_GITHUB_USERNAME}}/gke-example?color=56BEB8" /> -->

  <!-- <img alt="Github stars" src="https://img.shields.io/github/stars/{{YOUR_GITHUB_USERNAME}}/gke-example?color=56BEB8" /> -->
</p>

<!-- Status -->

<!-- <h4 align="center"> 
	🚧  Gke Example 🚀 Under construction...  🚧
</h4> 

<hr> -->

<p align="center">
  <a href="#dart-about">About</a> &#xa0; | &#xa0; 
  <a href="#sparkles-features">Features</a> &#xa0; | &#xa0;
  <a href="#rocket-technologies">Technologies</a> &#xa0; | &#xa0;
  <a href="#white_check_mark-requirements">Requirements</a> &#xa0; | &#xa0;
  <a href="#checkered_flag-starting">Starting</a> &#xa0; | &#xa0;
  <a href="#memo-license">License</a> &#xa0; | &#xa0;
  <a href="https://github.com/{{YOUR_GITHUB_USERNAME}}" target="_blank">Author</a>
</p>

<br>

## :dart: About ##

This project explain how to create a private GKE cluster with bastion host. 

## :sparkles: Features ##

:heavy_check_mark: Using gcloud;

## :rocket: Technologies ##

The following tools were used in this project:

- [Terraform](https://cloud.google.com/kubernetes-engine/docs/archive/creating-kubernetes-engine-private-clusters-with-net-proxies)

## :white_check_mark: Requirements ##

:heavy_check_mark: Before starting :checkered_flag:, you need to have [gcloud cli](https://cloud.google.com/sdk/docs/install?hl=es-419) and [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed.;\
:heavy_check_mark: These APIs have to be installed in your GCP project:;
- Compute Engine API
- Kubernetes Engine API
- Network Connectivity API

## :checkered_flag: Starting ##

```bash
# Clone this project
$ git clone https://github.com/{{adolfoale}}/gke-example

# Access
$ cd gke-example/private_regional_cluster

# Deploy GKE ckuster and bastion host
$ sh cluster.sh

# Get into bastion host
$ gcloud compute ssh proxy-temp

# Install kubectl
sudo apt-get install kubectl

# Install gke-gcloud-auth-plugin
sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin

# Connect to cluster
gcloud container clusters get-credentials frobnitz --region [REGION] --project [project_id]

# Text your kubectl commands
kubectl get nodes
```

## :memo: License ##

This project is under license from MIT. For more details, see the [LICENSE](LICENSE.md) file.


Made with :heart: by <a href="https://www.linkedin.com/in/adolfoalejandroacevedo/" target="_blank">{{Adolfo Acevedo}}</a>

&#xa0;

<a href="#top">Back to top</a>
