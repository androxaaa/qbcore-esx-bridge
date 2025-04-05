-- Initialize core objects
ESX = exports['es_extended']:getSharedObject()
QBCore = {}

-- Core functions
QBCore.Functions = {}
QBCore.PlayerData = {}
QBCore.Config = {}
QBCore.Shared = {}

-- Common mapping functions
QBCore.Functions.GetPlayerData = function()
    if ESX.PlayerData then
        -- Map ESX player data structure to QB structure
        local playerData = {
            citizenid = ESX.PlayerData.identifier,
            source = GetPlayerServerId(PlayerId()),
            name = ESX.PlayerData.firstName .. ' ' .. ESX.PlayerData.lastName,
            money = {
                cash = ESX.PlayerData.money,
                bank = ESX.PlayerData.accounts.bank,
                crypto = 0 -- ESX doesn't have crypto by default
            },
            metadata = ESX.PlayerData.metadata or {},
            charinfo = {
                firstname = ESX.PlayerData.firstName,
                lastname = ESX.PlayerData.lastName,
                account = ESX.PlayerData.accounts.bank,
                phone = ESX.PlayerData.phone
            },
            job = {
                name = ESX.PlayerData.job.name,
                label = ESX.PlayerData.job.label,
                grade = {
                    name = ESX.PlayerData.job.grade_name,
                    level = ESX.PlayerData.job.grade
                },
                onduty = true -- ESX doesn't have duty system by default
            },
            gang = {
                name = "none",
                label = "No Gang",
                grade = {
                    name = "none",
                    level = 0
                }
            },
            position = ESX.PlayerData.coords
        }
        return playerData
    end
    return {}
end

QBCore.Functions.GetCoords = function(entity)
    local coords = GetEntityCoords(entity)
    return vector4(coords.x, coords.y, coords.z, GetEntityHeading(entity))
end

QBCore.Functions.DrawText3D = function(x, y, z, text)
    ESX.Game.Utils.DrawText3D({x = x, y = y, z = z}, text, 0.5)
end

QBCore.Functions.Notify = function(text, type, length)
    -- Map notification types
    local notifType = "info"
    if type == "success" then notifType = "success"
    elseif type == "error" then notifType = "error" end
    
    ESX.ShowNotification(text, notifType, length or 3000)
end

QBCore.Functions.TriggerCallback = function(name, cb, ...)
    ESX.TriggerServerCallback(name, cb, ...)
end

QBCore.Functions.GetPlayers = function()
    return ESX.Game.GetPlayers()
end

QBCore.Shared.Items = {}
QBCore.Shared.Vehicles = {}
QBCore.Shared.Weapons = {}
QBCore.Shared.Jobs = {}
QBCore.Shared.Gangs = {}

-- Load ESX items into QB format
CreateThread(function()
    Wait(1000) -- Wait for ESX to fully initialize
    
    -- Map ESX items to QB format
    if ESX.Items then
        for k, v in pairs(ESX.Items) do
            QBCore.Shared.Items[k] = {
                name = k,
                label = v.label,
                weight = v.weight or 0,
                type = v.type or "item",
                image = v.name .. ".png",
                unique = v.unique or false,
                useable = v.useable or false,
                description = v.description or ""
            }
        end
    end
    
    -- Map ESX jobs to QB format
    if ESX.Jobs then
        for k, v in pairs(ESX.Jobs) do
            QBCore.Shared.Jobs[k] = {
                label = v.label,
                defaultDuty = true,
                grades = {}
            }
            
            if v.grades then
                for grade, gradeData in pairs(v.grades) do
                    QBCore.Shared.Jobs[k].grades[tostring(grade)] = {
                        name = gradeData.name,
                        payment = gradeData.salary or 0
                    }
                end
            end
        end
    end
end)
