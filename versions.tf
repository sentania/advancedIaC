
terraform {
  required_version = ">= 0.14"
  required_providers {
    vra = {
        source = "vmware/vra"
        version = ">= 0.3.4"
    }
  }

}
