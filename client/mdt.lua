local mdtOpen = false
local isShowingMugshot = false
local mugshotTexture = nil
local mugshotHandle = nil

function isInMDTVehicle()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle ~= 0 then
        local vehicleModel = GetEntityModel(vehicle)
        local vehicleName = GetDisplayNameFromVehicleModel(vehicleModel)
        for _, vName in ipairs(Config.mdtcars) do
            if vehicleName == string.upper(vName) then
                return true
            end
        end
    end
    return false
end

function openMDT()
    if not mdtOpen and PlayerClientData.role == 'cop' and isInMDTVehicle() then
        mdtOpen = true
        SetNuiFocus(true, true)
        SendNUIMessage({ action = 'openMDT' })
    else
        TriggerEvent('chat:addMessage', { args = { '^1You must be a police officer in a police vehicle to access the MDT.' } })
    end
end

RegisterNUICallback('closeMDT', function(data, cb)
    if isShowingMugshot then
        isShowingMugshot = false
        UnregisterPedheadshot(mugshotHandle)
        mugshotTexture = nil
        mugshotHandle = nil
    end
    mdtOpen = false
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterCommand('openMDT', function()
    openMDT()
end, false)
RegisterKeyMapping('openMDT', 'Open Mobile Data Terminal', 'keyboard', 'F5')

-- NUI Callback for Address Search
RegisterNUICallback('searchAddress', function(data, cb)
    -- Remove mugshot if displayed
    if isShowingMugshot then
        isShowingMugshot = false
        UnregisterPedheadshot(mugshotHandle)
        mugshotTexture = nil
        mugshotHandle = nil
    end
    TriggerServerEvent('mdt:searchAddress', data.address)
    cb('ok')
end)

-- NUI Callback for Person Search
RegisterNUICallback('searchPerson', function(data, cb)
    -- Remove mugshot if displayed (optional, if you want to remove previous mugshot before showing new one)
    if isShowingMugshot then
        isShowingMugshot = false
        UnregisterPedheadshot(mugshotHandle)
        mugshotTexture = nil
        mugshotHandle = nil
    end
    TriggerServerEvent('mdt:searchPerson', data.firstname, data.lastname)
    cb('ok')
end)

-- NUI Callback for Vehicle Search
RegisterNUICallback('searchVehicle', function(data, cb)
    -- Remove mugshot if displayed
    if isShowingMugshot then
        isShowingMugshot = false
        UnregisterPedheadshot(mugshotHandle)
        mugshotTexture = nil
        mugshotHandle = nil
    end
    TriggerServerEvent('mdt:searchVehicle', data.plate)
    cb('ok')
end)
-- Existing code...

-- NUI Callback to add a note
RegisterNUICallback('addNote', function(data, cb)
    local targetId = data.targetId
    local note = data.note
    TriggerServerEvent('mdt:addNote', targetId, note)
    cb('ok')
end)

-- NUI Callback to clear notes
RegisterNUICallback('clearNotes', function(data, cb)
    local targetId = data.targetId
    TriggerServerEvent('mdt:clearNotes', targetId)
    cb('ok')
end)

-- Existing code...


RegisterNetEvent('mdt:showResults')
AddEventHandler('mdt:showResults', function(data)
    if data.type == 'person' and data.results then
        local targetPlayerId = GetPlayerFromServerId(data.results.id)
        if targetPlayerId ~= -1 then
            local ped = GetPlayerPed(targetPlayerId)
            if DoesEntityExist(ped) then
                mugshotHandle = RegisterPedheadshot(ped)
                while not IsPedheadshotReady(mugshotHandle) or not IsPedheadshotValid(mugshotHandle) do
                    Wait(10)
                end
                mugshotTexture = GetPedheadshotTxdString(mugshotHandle)
                isShowingMugshot = true
                SendNUIMessage({
                    action = 'showResults',
                    data = data
                })
            else
                SendNUIMessage({
                    action = 'showResults',
                    data = data
                })
                TriggerEvent('chat:addMessage', { args = { '^1Mugshot unavailable: target player is too far away.' } })
            end
        else
            SendNUIMessage({
                action = 'showResults',
                data = data
            })
            TriggerEvent('chat:addMessage', { args = { '^1Player not found.' } })
        end
    else
        SendNUIMessage({
            action = 'showResults',
            data = data
        })
    end
end)

-- Render the mugshot on the screen
CreateThread(function()
    while true do
        Wait(0)
        if isShowingMugshot and mugshotTexture then
            -- Adjust the position and size as needed
            DrawSprite(mugshotTexture, mugshotTexture, 0.7, 0.52, 0.04, 0.08, 0.0, 255, 255, 255, 255)
        end
    end
end)
