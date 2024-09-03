# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "~> 3.6.2"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.57.0"
    }
  }
}

# Data source used to grab the org and project under which a stack will be created.
#
# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/project
data "tfe_project" "stacks-proj" {
  name         = var.tfe_project_name
  organization = var.tfe_organization
}

data "tfe_organization" "stacks-org" {
  name = var.tfe_organization
}

data "tfe_oauth_client" "github" {
  organization = var.tfe_organization
  name = var.oauth_client_name
}

# Generates a random suffix for the Stack's name for easier usage in parallel
#

resource "random_string" "demo" {
  length = 4
  special = false
  upper = false
}

# Runs in this stack will be automatically authenticated
# to AWS with the permissions set in the AWS policy.
#
# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/stack

resource "tfe_stack" "demo" {
  name = "commit-gate-demo-${random_string.demo.result}"
  project_id = data.tfe_project.stacks-proj.id

  vcs_repo {
    branch         = "main"
    identifier     = var.repo_name
    oauth_token_id = data.tfe_oauth_client.github.oauth_token_id
  }
}
