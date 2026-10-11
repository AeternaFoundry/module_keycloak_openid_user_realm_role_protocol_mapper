variable "openid_user_realm_role_protocol_mappers" {
  description = <<EOT
Map of openid_user_realm_role_protocol_mappers, attributes below
Required:
    - claim_name
    - name
    - realm_id
Optional:
    - add_to_access_token
    - add_to_id_token
    - add_to_token_introspection
    - add_to_userinfo
    - claim_value_type
    - client_id
    - client_scope_id
    - multivalued
    - realm_role_prefix
EOT

  type = map(object({
    claim_name                 = string
    name                       = string
    realm_id                   = string
    add_to_access_token        = optional(bool)
    add_to_id_token            = optional(bool)
    add_to_token_introspection = optional(bool)
    add_to_userinfo            = optional(bool)
    claim_value_type           = optional(string)
    client_id                  = optional(string)
    client_scope_id            = optional(string)
    multivalued                = optional(bool)
    realm_role_prefix          = optional(string)
  }))
  validation {
    condition = alltrue([
      for k, v in var.openid_user_realm_role_protocol_mappers : (
        v.claim_value_type == null || (contains([for v in ["JSON", "String", "long", "int", "boolean"] : lower(v)], lower(v.claim_value_type)))
      )
    ])
    error_message = "must be one of: \"JSON\", \"String\", \"long\", \"int\", \"boolean\""
  }
}

