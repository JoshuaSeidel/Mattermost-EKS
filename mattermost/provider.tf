terraform {
  required_version = "1.10.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.89.0"
    }
  }
}

provider "aws" {
  alias   = "govcloud"
  profile = local.vars.gcprofile
  region  = local.vars.aws_region

  use_fips_endpoint = true
  default_tags {
    tags = merge(local.vars.tags, {
      Environment = "dev",
      Project     = local.vars.project_name
    })
  }
}

provider "aws" {
  alias   = "triafed"
  profile = local.vars.profile
  region  = "us-east-1"

  default_tags {
    tags = merge(local.vars.tags, {
      Environment = "dev",
      Project     = local.vars.project_name
    })
  }
}

provider "kubernetes" {
    config_path = "~/.kube/config" #change user as needed to match the user within the instance being used to deploy the DBZ production cluster
  }

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
