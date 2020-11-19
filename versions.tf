terraform {
  required_version = ">= 0.13"
  backend "gcs" {
    bucket          = "devops-lab-tf-state" // you have to create this bucket on GCP before run terraform init command
    prefix          = "/terraform.tfstate"
    credentials     = "/opt/devops-lab.json"
  }
}