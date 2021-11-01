# terraform-module-cts-acme-vault
Terraform module for ACME certificates to be stored in Vault, for use by Consul Terraform Sync 

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_acme"></a> [acme](#requirement\_acme) | 2.6.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.1 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 2.24 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_acme"></a> [acme](#provider\_acme) | 2.6.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.1.0 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 2.24.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [acme_certificate.certificate](https://registry.terraform.io/providers/vancluever/acme/2.6.0/docs/resources/certificate) | resource |
| [acme_registration.reg](https://registry.terraform.io/providers/vancluever/acme/2.6.0/docs/resources/registration) | resource |
| [tls_private_key.private_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [vault_generic_secret.account_private_key](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |
| [vault_generic_secret.cert](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_email"></a> [account\_email](#input\_account\_email) | Email address to use for the ACME account | `string` | n/a | yes |
| <a name="input_acme_url"></a> [acme\_url](#input\_acme\_url) | ACME server URL | `string` | `"https://acme-staging-v02.api.letsencrypt.org/directory"` | no |
| <a name="input_common_name"></a> [common\_name](#input\_common\_name) | Common name for the certificate | `string` | n/a | yes |
| <a name="input_consul_tags"></a> [consul\_tags](#input\_consul\_tags) | List of Consul tags to filter services on | `list(string)` | `[]` | no |
| <a name="input_dns_challenge"></a> [dns\_challenge](#input\_dns\_challenge) | The [DNS challenge\|https://www.terraform.io/docs/providers/acme/r/certificate.html#using-dns-challenges] to use for fulfilling the request. | <pre>object({<br>        config   = map(string)<br>        provider = string<br>    })</pre> | n/a | yes |
| <a name="input_min_days_remaining"></a> [min\_days\_remaining](#input\_min\_days\_remaining) | ration of a certificate before a renewal is attempted. A value of less than 0 means that the certificate will never be renewed. | `number` | `30` | no |
| <a name="input_recursive_nameservers"></a> [recursive\_nameservers](#input\_recursive\_nameservers) | The recursive nameservers that will be used to check for propagation of the challenge record. Defaults to your system-configured DNS resolvers. | `list(string)` | `[]` | no |
| <a name="input_services"></a> [services](#input\_services) | Consul services monitored by Consul-Terraform-Sync | <pre>map(<br>    object({<br>      id        = string<br>      name      = string<br>      kind      = string<br>      address   = string<br>      port      = number<br>      meta      = map(string)<br>      tags      = list(string)<br>      namespace = string<br>      status    = string<br><br>      node                  = string<br>      node_id               = string<br>      node_address          = string<br>      node_datacenter       = string<br>      node_tagged_addresses = map(string)<br>      node_meta             = map(string)<br><br>      cts_user_defined_meta = map(string)<br>    })<br>  )</pre> | n/a | yes |
| <a name="input_subject_alternative_names"></a> [subject\_alternative\_names](#input\_subject\_alternative\_names) | Subject Alternative Names to add to the dynamically generated ones | `list(string)` | `[]` | no |
| <a name="input_subject_alternative_names_base_domain"></a> [subject\_alternative\_names\_base\_domain](#input\_subject\_alternative\_names\_base\_domain) | Base domain to be added to the automatically generated SANs ( e.g. with a service `test` and base domain example.com, the SAN will be test.example.com) | `string` | n/a | yes |
| <a name="input_vault_account_private_key_path"></a> [vault\_account\_private\_key\_path](#input\_vault\_account\_private\_key\_path) | Vault path for the generated TLS private key used for the ACME account registration | `string` | n/a | yes |
| <a name="input_vault_cert_path"></a> [vault\_cert\_path](#input\_vault\_cert\_path) | Vault path where to store the certificate | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->