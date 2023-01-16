variable "tenant" {
  type = string
}

variable "namespace" {
  type = string
}

variable "api_cert" {
  type = string
  default = "~/.f5xc/volterra.cert"
}
        
variable "api_key" {
  type = string
  default = "~/.f5xc/volterra.key"
}
        
variable "api_url" {
  type = string
  default = "https://f5-emea-ent.console.ves.volterra.io/api"
  #default = "https://YOUR_TENANT.console.ves.volterra.io/api"
}


