provider "vra" {
  url           = var.url
  refresh_token = var.refresh_token
  insecure      = var.insecure
}

data "vra_project" "this" {
  name = var.project_name
}

resource "vra_blueprint" "this" {
  name        = var.blueprint_name
  description = "Created by vRA terraform provider"

  project_id = data.vra_project.this.id

  content = <<-EOT
    formatVersion: 1
    inputs: {}
    resources:
      Cloud_SecurityGroup_1:
        type: Cloud.SecurityGroup
        properties:
          constraints:
            - tag: "sg:RiskyBusiness"
          securityGroupType: existing
      Cloud_Machine_1:
        type: Cloud.Machine
        properties:
          image: CentOS7
          flavor: Small
          networks:
             constraints:
            - tag: "dynamicNetwork:Routed"
          customizationSpec: custSpec-CentOS7
          tags:
            - key: protection
              value: bkupnoCred
            - key: operatingSystem
              value: centOS
  EOT
}