terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 2.24"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.1"
    }
    acme = {
      source = "vancluever/acme"
      version = "2.6.0"
    }
  }
}

locals {
}

#provider "acme" {
#  server_url = var.acme_url
#}

#provider "vault" {
#  address = var.vault_address
#}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.account_email
}

resource "acme_certificate" "certificate" {
  lifecycle {
    create_before_destroy = true
  }

  min_days_remaining      = var.min_days_remaining
  recursive_nameservers   = var.recursive_nameservers != [] ? var.recursive_nameservers : null

  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = var.common_name
  subject_alternative_names = concat([
    for _, service in var.services: "${service.name}.${var.subject_alternative_names_base_domain}" if (var.consul_tags == [] ? true : contains(service.tags, var.consul_tags))],
    var.subject_alternative_names)
  /*subject_alternative_names = concat(flatten([
    for _, service in var.services: [
      service.tags
    ]
    "${service.name}.${var.subject_alternative_names_base_domain}"
  
  ]), var.subject_alternative_names)
*/
  dynamic "dns_challenge" {
    for_each = [var.dns_challenge]
    content {
      config   = dns_challenge.value.config
      provider = dns_challenge.value.provider
    }
  }
}

resource "vault_generic_secret" "cert" {
  path = var.vault_cert_path
  data_json = jsonencode({
    crt = acme_certificate.certificate.certificate_pem
    key = acme_certificate.certificate.private_key_pem
  })
}

resource "vault_generic_secret" "account_private_key" {
  path = var.vault_account_private_key_path
  data_json = jsonencode({
    private_key = tls_private_key.private_key.private_key_pem
  })
}
