variable "project_id" {
  description = "project id"
  type        = string
}

variable "branch_name" {
  description = "branch name for trigger_template"
  type        = string
}

variable "repository_name" {
  description = "github repository name "
  type        = string
}

variable "repository_owner" {
  description = "github repository owner "
  type        = string
}


variable "cluster_name" {
  description = "kubernetes cluster name"
  type        = string
}

variable "region" {
  description = "region of cluster"
  type        = string
}

variable "environment_id" {
  description = "environment id"
  type        = string
}
