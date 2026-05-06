# main.tf
# Minimal Terraform configuration for the Ravens 2026 Draft Blog.
#
# This file describes the cloud infrastructure that *would* host the
# static site if it were deployed to AWS S3 instead of GitHub Pages.
# It is intentionally not applied — the validate-only CI workflow
# (.github/workflows/terraform.yml) demonstrates Infrastructure as Code
# practice (formatting, syntax validation, version pinning) without
# requiring real cloud credentials for the BPP coursework demonstration.

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS region into which the static-site bucket would be provisioned."
  type        = string
  default     = "eu-west-2"
}

variable "site_name" {
  description = "Logical name used as a prefix for AWS resources for this site."
  type        = string
  default     = "ravens-2026-draft-blog"
}

variable "environment" {
  description = "Deployment environment — used for tagging only."
  type        = string
  default     = "coursework"
}

# An S3 bucket configured to host the built Jekyll site as a static website.
resource "aws_s3_bucket" "site" {
  bucket = "${var.site_name}-${var.environment}"

  tags = {
    Project     = var.site_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "BPP-DevOps-L5"
  }
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

resource "aws_s3_bucket_public_access_block" "site" {
  bucket = aws_s3_bucket.site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

output "bucket_name" {
  description = "Name of the S3 bucket that would host the static site."
  value       = aws_s3_bucket.site.bucket
}

output "website_endpoint" {
  description = "S3 website endpoint URL once the bucket is provisioned."
  value       = aws_s3_bucket_website_configuration.site.website_endpoint
}
