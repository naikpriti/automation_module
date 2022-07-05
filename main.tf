locals {
  current_time           = timestamp()
  current_wallclock_time = formatdate("h.mm", local.current_time)
  #schedule_tomorrow      = (local.current_wallclock_time >= local.start_wallclock_time)
  today                  = formatdate("YYYY-MM-DD", local.current_time)
  tomorrow               = formatdate("YYYY-MM-DD", timeadd(local.current_time, "24h"))
  #starttime             = "${local.today}13:20:15+05:30"
}

module "automation_account" {
  source = "git::https://github.com/naikpriti/automation_account.git?ref=main"


  name                = local.automation_account.account.name
  resource_group_name = local.automation_account.account.resource_group_name
  location            = local.automation_account.account.location
  subscription_id= var.subscription_id
  timezone=local.automation_account.account.timezone
  starttime             = local.automation_account.account.starttime
  stoptime             = local.automation_account.account.stoptime
  clustername = local.automation_account.account.clustername
}





