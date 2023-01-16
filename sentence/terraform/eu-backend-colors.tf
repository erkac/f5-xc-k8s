resource "volterra_origin_pool" "sentence-colors-pool" {
  name                   = "tf-sentence-colors-pool"
  namespace              = var.namespace
 
 
  origin_servers {


    k8s_service {
      // One of the arguments from this list "inside_network outside_network vk8s_networks" must be set
      service_name   = "sentence-colors.r-bruenig"

      site_locator {
        // One of the arguments from this list "site virtual_site" must be set

        virtual_site {
          name      = "r-bruenig-dc"
          namespace = var.namespace
          tenant    = var.tenant
        }
      }
    }

    labels = {
    }
  }

  no_tls = false
  port = "80"
  endpoint_selection     = "LOCAL_PREFERED"
  loadbalancer_algorithm = "LB_OVERRIDE"

}

resource "volterra_http_loadbalancer" "sentence-colors-lb" {
  name      = "tf-sentence-colors-lb"
  namespace = var.namespace

  domains = ["sentence-colors.r-bruenig"]
  http {
    dns_volterra_managed = false
    port                 = 80
  }
  advertise_custom {
    advertise_where { 
      vk8s_service {
        virtual_site {
          name      = "r-bruenig-eu"
          namespace = var.namespace
          tenant    = var.tenant
        }
      }
    }
#    advertise_where {
#      virtual_site {
#        network = "SITE_NETWORK_SERVICE"
#        virtual_site {
#          name      = "r-bruenig-edge"
#          namespace = var.namespace
#          tenant    = var.tenant
#        }
#      }
#    }
  }
  default_route_pools {
    pool {
      name = volterra_origin_pool.sentence-colors-pool.name
      namespace = var.namespace
    }
    weight = 1
  }
  //End of mandatory "VIP configuration"
  //Mandatory "Security configuration"
  no_service_policies = true
  no_challenge = true
  disable_rate_limit = true
  disable_waf = true
  //End of mandatory "Security configuration"
  //Mandatory "Load Balancing Control"
  round_robin = true
  //End of mandatory "Load Balancing Control"
  add_location           = true
}
