local ESX = exports['es_extended']:getSharedObject()

-- Create the exports interface
exports('GetCoreObject', function()
    return QBCore
end)

-- Player object conversion
QBCore.Functions.GetPlayer = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return nil end
    
    -- Create a QB-style player object that wraps ESX functions
    local player = {}
    
    player.Functions = {}
    player.PlayerData = QBCore.Functions.GetPlayerData()
    
    player.Functions.AddMoney = function(moneytype, amount, reason)
        if moneytype == "cash" then
            xPlayer.addMoney(amount)
        elseif moneytype == "bank" then
            xPlayer.addAccountMoney('bank', amount)
        end
    end
    
    player.Functions.RemoveMoney = function(moneytype, amount, reason)
        if moneytype == "cash" then
            xPlayer.removeMoney(amount)
        elseif moneytype == "bank" then
            xPlayer.removeAccountMoney('bank', amount)
        end
    end
    
    player.Functions.SetJob = function(job, grade)
        xPlayer.setJob(job, grade)
    end
    
    player.Functions.AddItem = function(item, amount, slot, info)
        return xPlayer.addInventoryItem(item, amount)
    end
    
    player.Functions.RemoveItem = function(item, amount, slot)
        return xPlayer.removeInventoryItem(item, amount)
    end
    
    player.Functions.GetItemByName = function(item)
        local esxItem = xPlayer.getInventoryItem(item)
        if esxItem then
            return {
                name = esxItem.name,
                amount = esxItem.count,
                info = {},
                label = esxItem.label,
                description = esxItem.description or "",
                weight = esxItem.weight or 0,
                type = esxItem.type or "item",
                unique = esxItem.unique or false,
                useable = esxItem.useable or false,
                slot = esxItem.slot or 1
            }
        end
        return nil
    end
    
    return player
end

-- QB-Core callbacks system (maps to ESX callbacks)
QBCore.Functions.CreateCallback = function(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

QBCore.Functions.TriggerCallback = function(name, source, cb, ...)
    ESX.TriggerServerCallback(name, source, cb, ...)
end

-- Handle ESX events and convert to QB events
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    TriggerClientEvent('QBCore:Client:OnPlayerLoaded', playerId)
end)

-- Register QB command handler
QBCore.Commands = {}
QBCore.Commands.Add = function(name, help, arguments, argsrequired, callback, permission)
    RegisterCommand(name, function(source, args, rawCommand)
        -- Permission check logic would go here
        callback(source, args, rawCommand)
    end, false)
end
