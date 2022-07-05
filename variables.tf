variable "github_branch" {
  description = "Github PAT"
  type        = string
  default     = "dev"
}

variable "subscription_id" {
    type = string
    description = "Azure region where the resources would be provisioned"
}

variable "starttime"{
    type = string
    description = "resource group name "

}

variable "stoptime"{
    type = string
    description = "resource group name "

}