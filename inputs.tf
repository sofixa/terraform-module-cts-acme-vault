variable "services" {
  description = "Consul services monitored by Consul-Terraform-Sync"
  type = map(
    object({
      id        = string
      name      = string
      kind      = string
      address   = string
      port      = number
      meta      = map(string)
      tags      = list(string)
      namespace = string
      status    = string

      node                  = string
      node_id               = string
      node_address          = string
      node_datacenter       = string
      node_tagged_addresses = map(string)
      node_meta             = map(string)

      cts_user_defined_meta = map(string)
    })
  )
}

variable "consul_tags" {
    default = []
    type = list(string)
    description = "List of Consul tags to filter services on"
}

variable "account_email" {
    type = string
    description = "Email address to use for the ACME account"
}

variable "common_name" {
    type = string
    description = "Common name for the certificate"
}

variable "subject_alternative_names" {
    type = list(string)
    description = "Subject Alternative Names to add to the dynamically generated ones"
    default = []
}

variable "subject_alternative_names_base_domain" {
    type = string
    description = "Base domain to be added to the automatically generated SANs ( e.g. with a service `test` and base domain example.com, the SAN will be test.example.com)"
}

variable "acme_url" {
    description = "ACME server URL"
    default = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

variable "vault_cert_path" {
    type = string
    description = "Vault path where to store the certificate"
}

variable "vault_account_private_key_path" {
    type = string
    description = "Vault path for the generated TLS private key used for the ACME account registration"
}

variable "dns_challenge" {
    description = "The [DNS challenge|https://www.terraform.io/docs/providers/acme/r/certificate.html#using-dns-challenges] to use for fulfilling the request."
    type = object({
        config   = map(string)
        provider = string
    })
}

variable "min_days_remaining" {
    description = "ration of a certificate before a renewal is attempted. A value of less than 0 means that the certificate will never be renewed."
    default     = 30
}

variable "recursive_nameservers" {
    type = list(string)
    description = "The recursive nameservers that will be used to check for propagation of the challenge record. Defaults to your system-configured DNS resolvers."
    default     = []
}
