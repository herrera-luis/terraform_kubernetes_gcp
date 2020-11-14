# Terraform with Kubernetes multienvironment support

This repository have a basic setup to support multienv with terraform in order to provisione kubernetes cluster

## Environment setup

Before run the scripts you need to create the terraform workspaces:

* dev
* prod

```shell
$ terraform workspace new dev
```

Then you need set values to the next environment variables on the `.env` file:

* TF_VAR_gke_username=the-gke-username
* TF_VAR_gke_password=the-gke-password
* TF_VAR_project_id=the-project-id

```shell
$ export TF_VAR_gke_username=admin
```
You can specify this on the .env file or as a prefix to the command.

## Install and configure GCloud

First, install the [Google Cloud CLI](https://cloud.google.com/sdk/docs/quickstarts) 
and initialize it.

```shell
$ gcloud init
```

Once you've initialized gcloud (signed in, selected project), add your account 
to the Application Default Credentials (ADC). This will allow Terraform to access
these credentials to provision resources on GCloud.

```shell
$ gcloud auth application-default login
```