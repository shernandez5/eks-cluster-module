# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "tfe_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance you'd like to use with AWS"
}

variable "tfe_organization" {
  type        = string
  description = "The name of your Terraform Cloud organization"
}

variable "tfe_project_name" {
  type        = string
  default     = "Default Project"
  description = "The project under which a stack will be created"
}

variable "github_username" {
  type = string
  description = "The Github username that owns the repositories that will be used"
}

variable "oauth_client_name" {
  type = string
  description = "The name of the oauth client to use for creating the stack"
}

variable "repo_name" {
  type = string
  description = "The name of the repo to connect to the stack"
}