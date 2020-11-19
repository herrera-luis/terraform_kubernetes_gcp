# Terraform with Kubernetes on GCP

This repository has an example of terraform setup with the following features:

* Workspace support (dev/prod)
* Modules: app (k8s metadata), kubernetes, network and pipeline 
* Basic app on python

After you deploy this infrastructure you will have a public ip that provides access to the basic app deployed on GKE and a pipeline configuration that will update the app every time that you do a push on the main branch.

## GCP setup

### Install and configure GCloud

First, install the [Google Cloud CLI](https://cloud.google.com/sdk/docs/quickstarts)  and initialize it.

```shell
$ gcloud init
```

Once you've initialized gcloud (signed in, selected project), add your account  to the Application Default Credentials (ADC). This will allow Terraform to access these credentials to provision resources on GCloud.

```shell
$ gcloud auth application-default login
```

### Enable GCP APIs

If this is your first time running terraform with GCP you need to enable the following APIs.

* containerregistry.googleapis.com
* container.googleapis.com
* cloudbuild.googleapis.com

You can do it on your terminal with the following command:

```shell
$ gcloud services enable containerregistry.googleapis.com
```

### Connect with your Github/Bitbucket repository

Before create the pipelines (triggers on GCP) you need to connect your repository to your project.

* [Connect Repository](https://console.cloud.google.com/cloud-build/triggers/connect)


## Local Environment setup

### Step 1

First, create terraform workspaces:

* dev
* stg
* prod

```shell
$ terraform workspace new dev
```

**NOTE:** To make this example easier, only dev, stg and prod environments are implemented through the use of `terraform workspace`. You can extend this behavior to implement it in more environments and create projects under an organization hierarchy if it's necessary.

### Step 2

Then you need to set the environment value of your gcp project id

```shell
$ export TF_VAR_gcp_project_id=devops-lab-583419
```

### Step 3

Init your terraform workspace

```shell
$ terraform init
```

### Step 4

Now you can terraform plan and apply commands to deploy your infrastructure to GCP

```shell
$ terraform plan
```

```shell
$ terraform apply
```


### Changes that you need to make to use this repository

In order to use this repository with your personal GCP account and repository you need to change the values on:

**infrastructure/kubernetes/variable.tf**  (Optional, these properties have a default value for demo purposes)

* gke_username
* gke_password


**infrastructure/app/deployment.yaml**

* image

**local.tf**

* repository_owner
* repository_name

