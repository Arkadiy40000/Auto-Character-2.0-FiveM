local function isCop(playerId)
    local data = PlayerData[playerId]
    return data and data.role == 'cop'
end

RegisterNetEvent('mdt:searchAddress')
AddEventHandler('mdt:searchAddress', function(address)
    local src = source
    if not isCop(src) then
        return
    end
    local results = {}
    for _, data in pairs(PlayerData) do
        if data.address:lower() == address:lower() then
            table.insert(results, {
                name = data.name,
                surname = data.surname,
                address = data.address
            })
        end
    end
    TriggerClientEvent('mdt:showResults', src, { type = 'address', results = results })
end)

RegisterNetEvent('mdt:searchPerson')
AddEventHandler('mdt:searchPerson', function(firstname, lastname)
    local src = source
    if not isCop(src) then
        return
    end
    local results = nil
    for id, data in pairs(PlayerData) do
        if data.name:lower() == firstname:lower() and data.surname:lower() == lastname:lower() then
            results = {
                id = id,
                name = data.name,
                surname = data.surname,
                address = data.address,
                car = data.car,
                color = data.carcol,
                plate = data.carplate,
                notes = data.notes  -- Include notes here
            }
            break
        end
    end
    TriggerClientEvent('mdt:showResults', src, { type = 'person', results = results })
end)

RegisterNetEvent('mdt:searchVehicle')
AddEventHandler('mdt:searchVehicle', function(plate)
    local src = source
    if not isCop(src) then
        return
    end
    local results = nil
    for _, data in pairs(PlayerData) do
        if data.carplate:lower() == plate:lower() then
            results = {
                name = data.name,
                surname = data.surname,
                car = data.car,
                color = data.carcol,
                plate = data.carplate
            }
            break
        end
    end
    TriggerClientEvent('mdt:showResults', src, { type = 'vehicle', results = results })
end)
-- Existing code...

-- Event to add a note to a character
RegisterNetEvent('mdt:addNote')
AddEventHandler('mdt:addNote', function(targetId, note)
    local src = source
    if not isCop(src) then
        return
    end
    if PlayerData[targetId] then
        -- Sanitize the note to prevent injection
        note = tostring(note)
        note = note:gsub("[<>\"'%%;%^%*%[%]%(%)%$]", "")
        -- Append the new note to existing notes
        local existingNotes = PlayerData[targetId].notes
        local newNotes = existingNotes .. "\n" .. note
        PlayerData[targetId].notes = newNotes
        -- Confirm to the officer
        TriggerClientEvent('chat:addMessage', src, { args = { '^2Note added successfully.' } })
        -- Send updated data to the officer
        TriggerClientEvent('mdt:showResults', src, { type = 'person', results = {
            id = targetId,
            name = PlayerData[targetId].name,
            surname = PlayerData[targetId].surname,
            address = PlayerData[targetId].address,
            car = PlayerData[targetId].car,
            color = PlayerData[targetId].carcol,
            plate = PlayerData[targetId].carplate,
            notes = PlayerData[targetId].notes
        }})
    else
        TriggerClientEvent('chat:addMessage', src, { args = { '^1Player not found.' } })
    end
end)

-- Event to clear notes for a character
RegisterNetEvent('mdt:clearNotes')
AddEventHandler('mdt:clearNotes', function(targetId)
    local src = source
    if not isCop(src) then
        return
    end
    if PlayerData[targetId] then
        PlayerData[targetId].notes = ""
        -- Confirm to the officer
        TriggerClientEvent('chat:addMessage', src, { args = { '^2Notes cleared successfully.' } })
        -- Send updated data to the officer
        TriggerClientEvent('mdt:showResults', src, { type = 'person', results = {
            id = targetId,
            name = PlayerData[targetId].name,
            surname = PlayerData[targetId].surname,
            address = PlayerData[targetId].address,
            car = PlayerData[targetId].car,
            color = PlayerData[targetId].carcol,
            plate = PlayerData[targetId].carplate,
            notes = PlayerData[targetId].notes
        }})
    else
        TriggerClientEvent('chat:addMessage', src, { args = { '^1Player not found.' } })
    end
end)

-- Search person by player ID
RegisterNetEvent('mdt:searchPersonById')
AddEventHandler('mdt:searchPersonById', function(targetId)
    local src = source
    if not isCop(src) then
        return
    end
    local data = PlayerData[targetId]
    if data then
        local results = {
            id = targetId,
            name = data.name,
            surname = data.surname,
            address = data.address,
            car = data.car,
            color = data.carcol,
            plate = data.carplate,
            notes = data.notes
        }
        TriggerClientEvent('mdt:showResults', src, { type = 'person', results = results })
    else
        TriggerClientEvent('chat:addMessage', src, { args = { '^1Player not found.' } })
    end
end)

RegisterServerEvent('sendPlayerData')
AddEventHandler('sendPlayerData', function(data)
    local src = source
    -- Check if PlayerData[src] already exists
    if PlayerData[src] then
        -- Preserve existing notes and merge with new data
        local existingData = PlayerData[src]
        local existingNotes = existingData.notes or ""
        data.notes = existingNotes
        -- Merge the data tables
        for key, value in pairs(data) do
            existingData[key] = value
        end
        PlayerData[src] = existingData
    else
        -- Initialize notes if not already present
        if not data.notes then
            data.notes = ""
        end
        PlayerData[src] = data
    end
end)

-- Existing code...
