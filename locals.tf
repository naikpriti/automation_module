locals {
  environment_variables = yamldecode(file("${path.module}/vars/${var.github_branch}.yml"))
  automation_account    = local.environment_variables.automation_account
  #file = jsondecode(file("../scripts/runbooks.json"))

}

