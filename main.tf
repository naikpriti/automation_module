module "automation_accnt"{
    source = "git@github.com:naikpriti/automation_account.git?ref=main"

    automation_account_name = var.name
    rg_name                 = var.rg_name
    location                = var.location
    identity {
     type = "SystemAssigned"
    }

    automation_runbook{
            #count                   = "${local.rb_count}"
            name                    = local.all_json_data.runbooks.runbookName
            location                = var.location
            log_verbose             = "true"
            log_progress            = "true"
            description             = local.all_json_data.runbooks.description 
            runbook_type            = local.all_json_data.runbooks.runbookType
            content                 = data.local_file.runbook_scripts.content


            runbook_scripts = {
                #count                   = "${local.rb_count}"  
                filename                = "${local.all_json_data.runbooks.runbookScript}"
            }
        }
    
    automation_schedule{
        name                    = local.schedule_data.each.key
        resource_group_name     = var.rg_name
        automation_account_name = automation_accnt.aa_demo.name
        frequency               = local.schedule_data.each.value.scheduleFrequency
        interval                = local.schedule_data.each.value.scheduleInterval
        timezone                = local.schedule_data.each.value.scheduleTZ
        start_time              = local.schedule_data.each.value.scheduleStartTime
        description             = local.schedule_data.each.value.scheduleDescription
        week_days               = local.schedule_data.each.value.scheduleWeekdays
    }

    automation_job_schedule{
        resource_group_name     = var.rg_name
        automation_account_name = automation_accnt.aa_demo.name
        schedule_name           = local.schedule_attach_data.each.value.scheduleName
        runbook_name            = local.schedule_attach_data.each.value.runbookName
        parameters = {
            aksclustername = "${local.schedule_attach_data.each.value.parameter1}"
            resourcegroupname  = "${local.schedule_attach_data.each.value.parameter2}"
            operation = "${local.schedule_attach_data.each.value.parameter3}"
            }
    }

    role_assignment{
        scope              = "/subscriptions/149fdc07-203b-4014-9552-2dab6195289b"
        role_definition_name = "Contributor"
        principal_id       = automation_account.example.identity[0].principal_id
    }
}
    
