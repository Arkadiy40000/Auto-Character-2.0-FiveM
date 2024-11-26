-- Global table to store player data
PlayerData = {}
cooldowns = {} -- Table to track cooldowns

-- Register the /reg command
RegisterCommand('reg', function(source, args, rawCommand)
    local player = source
    if cooldowns[player] and cooldowns[player] > os.time() then
        local timeRemaining = cooldowns[player] - os.time()
        TriggerClientEvent('chat:addMessage', player, {args = {"System", "You must wait " .. timeRemaining .. " seconds to register again."}})
        return
    end
    if #args < 1 then
        TriggerClientEvent('chat:addMessage', source, {
            args = {"^6[^5Registration^6]^r", "Usage: /reg [civ/cop]"}
        })
        return
    end

    local roleArg = args[1]:lower()

    if roleArg == 'civ' then
        local role = 'civ'
        local playerId = source

        -- Use helper function to find available address
        local chosenAddress = findAvailableAddress()

        if not chosenAddress then
            TriggerClientEvent('chat:addMessage', playerId, { args = { '^1No available addresses in the current AoP. Please try again later or choose a different role.' }})
            return
        end

        -- Proceed with spawning the player at the chosen address
        TriggerClientEvent('spawnPlayer', playerId, role, chosenAddress)
        if Config.ChangeBucket then
            local player = source
            local bucket = Config.BucketNumber
            SetPlayerRoutingBucket(player, bucket)
        end
        TriggerClientEvent('chat:addMessage', source, {
            args = {"^6[^5Registration^6]^r", "You have been registered as a Civilian."}
        })
        cooldowns[player] = os.time() + Config.RegCooldown -- Set cooldown for 60 seconds
    elseif roleArg == 'cop' then
        local role = 'cop'
        local playerId = source

        -- Use helper function to find available unit
        local chosenUnit = findAvailableUnit()

        if not chosenUnit then
            TriggerClientEvent('chat:addMessage', playerId, { args = { '^1No available units in the current AoP. Please try again later or choose a different role.' }})
            return
        end

        -- Proceed with spawning the player as a cop at the chosen unit
        TriggerClientEvent('spawnCop', playerId, role, chosenUnit)
        if Config.ChangeBucket then
            local player = source
            local bucket = Config.BucketNumber
            SetPlayerRoutingBucket(player, bucket)
        end
        TriggerClientEvent('chat:addMessage', source, {
            args = {"^6[^5Registration^6]^r", "You have been registered as a Police Officer."}
        })
        cooldowns[player] = os.time() + Config.RegCooldown -- Set cooldown for 60 seconds
    else
        TriggerClientEvent('chat:addMessage', source, {
            args = {"^6[^5Registration^6]^r", "Invalid role. Use /reg [civ/cop]"}
        })
    end
end, false)

RegisterNetEvent('freeUnit')
AddEventHandler('freeUnit', function(unitName)
    local playerId = source

    -- Find and free the address
    for _, aop in pairs(Config.AoPs) do
        for _, unit in ipairs(aop.Units) do
            if unit.name == unitName then
                unit.isBusy = false -- Free up the address
                break
            end
        end
    end
end)

RegisterNetEvent('freeAddress')
AddEventHandler('freeAddress', function(addressName)
    local playerId = source

    -- Find and free the address
    for _, aop in pairs(Config.AoPs) do
        for _, address in ipairs(aop.Addresses) do
            if address.name == addressName then
                address.isBusy = false -- Free up the address
                break
            end
        end
    end
end)

RegisterCommand('addresses', function(source)
    local playerId = source

    -- Loop through all addresses and send their status to the player
    for _, aop in pairs(Config.AoPs) do
        for _, address in ipairs(aop.Addresses) do
            local status = address.isBusy and "Busy" or "Available"
            TriggerClientEvent('chat:addMessage', playerId, {
                args = { string.format("Address: %s, Status: %s", address.name, status) }
            })
        end
    end
end)

RegisterCommand('units', function(source)
    local playerId = source

    -- Loop through all addresses and send their status to the player
    for _, aop in pairs(Config.AoPs) do
        for _, unit in ipairs(aop.Units) do
            local status = unit.isBusy and "Busy" or "Available"
            TriggerClientEvent('chat:addMessage', playerId, {
                args = { string.format("Unit: %s, Status: %s", unit.name, status) }
            })
        end
    end
end)


RegisterCommand('printplayers', function(source, args, rawCommand)
    for id, data in pairs(PlayerData) do
        local info = string.format("ID: %d, Name: %s, Surname: %s, SocialGroup: %s, Address: %s, Role: %s, Status: %s, Car: %s, CarColor: %s, CarPlate: %s, Coords: %s",
            id, data.name, data.surname, data.socialgroup, data.address, data.role, data.status, data.car, data.carcol, data.carplate, tostring(data.coords))
        TriggerClientEvent('chat:addMessage', source, {
            args = {info}
        })
    end
end, false)

-- Handle incoming player data from clients
RegisterNetEvent('sendPlayerData')
AddEventHandler('sendPlayerData', function(data)
    if data.id then
        PlayerData[data.id] = data
    end
end)

RegisterNetEvent('changePlayerBucket') -- Register the event
AddEventHandler('changePlayerBucket', function()
    local player = source
    local bucket = 0
    SetPlayerRoutingBucket(player, bucket)
end)

AddEventHandler('playerDropped', function()
    local playerId = source
    -- Remove player's cooldown entry when they leave the server
    if cooldowns[playerId] then
        cooldowns[playerId] = nil
    end
end)

function findAvailableAddress()
    if not Config.AoPs[CurrentAoP] then
        print("Invalid CurrentAoP: " .. tostring(CurrentAoP))
        return nil
    end

    for _, address in ipairs(Config.AoPs[CurrentAoP].Addresses) do
        if not address.isBusy then
            address.isBusy = true
            return address
        end
    end
    return nil
end

-- Helper function to find an available unit
function findAvailableUnit()
    if not Config.AoPs[CurrentAoP] then
        print("Invalid CurrentAoP: " .. tostring(CurrentAoP))
        return nil
    end

    for _, unit in ipairs(Config.AoPs[CurrentAoP].Units) do
        if not unit.isBusy then
            unit.isBusy = true
            return unit
        end
    end
    return nil
end