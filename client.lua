local ESX = exports['es_extended']:getSharedObject()

-- Create the exports interface
exports('GetCoreObject', function()
    return QBCore
end)

-- Register QB events with ESX equivalents
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    -- Forward to any scripts listening for this event
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    -- Forward to any scripts listening for this event
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    -- Forward job update
end)

-- Handle ESX events and convert to QB events
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    TriggerEvent('QBCore:Client:OnPlayerUnload')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    -- Convert job data to QB format
    local jobInfo = {
        name = job.name,
        label = job.label,
        grade = {
            name = job.grade_name,
            level = job.grade
        },
        onduty = true,
        payment = job.salary
    }
    TriggerEvent('QBCore:Client:OnJobUpdate', jobInfo)
end)
