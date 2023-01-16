terraform {
          required_version = ">= 0.12.9, != 0.13.0"
        
          required_providers {
            volterra = {
              source = "volterraedge/volterra"
              version = ">=0.0.6"
            }
          }
        }
        provider "volterra" {
          api_cert = pathexpand(var.api_cert)
          api_key = pathexpand(var.api_key)
          #ipv6 = "1234:568:abcd:9100::/64"
          url   = var.api_url
        }
