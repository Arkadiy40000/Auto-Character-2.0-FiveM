-- Define the player's client data
PlayerClientData = {
    id = GetPlayerServerId(PlayerId()),
    name = "",
    surname = "",        -- To be filled by player or other means
    socialgroup = "",    -- To be filled as needed
    division = "",    -- To be filled as needed
    address = "",        -- To be filled as needed
    unit = "",        -- To be filled as needed
    role = "",           -- "civ" or "cop"
    status = "free",   -- Default status
    car = "",            -- To be filled as needed
    carcol = "",         -- To be filled as needed
    carplate = "",        -- To be filled as needed
    coords = "",
    notes = ""
}
hudVisible = true -- Tracks HUD visibility
local previousHudData = {}





local colorNames = {
    [0] = "Metallic Black",
    [1] = "Metallic Graphite Black",
    [2] = "Metallic Black Steal",
    [3] = "Metallic Dark Silver",
    [4] = "Metallic Silver",
    [5] = "Metallic Blue Silver",
    [6] = "Metallic Steel Gray",
    [7] = "Metallic Shadow Silver",
    [8] = "Metallic Stone Silver",
    [9] = "Metallic Midnight Silver",
    [10] = "Metallic Gun Metal",
    [11] = "Metallic Anthracite Grey",
    [12] = "Matte Black",
    [13] = "Matte Gray",
    [14] = "Matte Light Grey",
    [15] = "Util Black",
    [16] = "Util Black Poly",
    [17] = "Util Dark silver",
    [18] = "Util Silver",
    [19] = "Util Gun Metal",
    [20] = "Util Shadow Silver",
    [21] = "Worn Black",
    [22] = "Worn Graphite",
    [23] = "Worn Silver Grey",
    [24] = "Worn Silver",
    [25] = "Worn Blue Silver",
    [26] = "Worn Shadow Silver",
    [27] = "Metallic Red",
    [28] = "Metallic Torino Red",
    [29] = "Metallic Formula Red",
    [30] = "Metallic Blaze Red",
    [31] = "Metallic Graceful Red",
    [32] = "Metallic Garnet Red",
    [33] = "Metallic Desert Red",
    [34] = "Metallic Cabernet Red",
    [35] = "Metallic Candy Red",
    [36] = "Metallic Sunrise Orange",
    [37] = "Metallic Classic Gold",
    [38] = "Metallic Orange",
    [39] = "Matte Red",
    [40] = "Matte Dark Red",
    [41] = "Matte Orange",
    [42] = "Matte Yellow",
    [43] = "Util Red",
    [44] = "Util Bright Red",
    [45] = "Util Garnet Red",
    [46] = "Worn Red",
    [47] = "Worn Golden Red",
    [48] = "Worn Dark Red",
    [49] = "Metallic Dark Green",
    [50] = "Metallic Racing Green",
    [51] = "Metallic Sea Green",
    [52] = "Metallic Olive Green",
    [53] = "Metallic Green",
    [54] = "Metallic Gasoline Blue Green",
    [55] = "Matte Lime Green",
    [56] = "Util Dark Green",
    [57] = "Util Green",
    [58] = "Worn Dark Green",
    [59] = "Worn Green",
    [60] = "Worn Sea Wash",
    [61] = "Metallic Midnight Blue",
    [62] = "Metallic Dark Blue",
    [63] = "Metallic Saxony Blue",
    [64] = "Metallic Blue",
    [65] = "Metallic Mariner Blue",
    [66] = "Metallic Harbor Blue",
    [67] = "Metallic Diamond Blue",
    [68] = "Metallic Surf Blue",
    [69] = "Metallic Nautical Blue",
    [70] = "Metallic Bright Blue",
    [71] = "Metallic Purple Blue",
    [72] = "Metallic Spinnaker Blue",
    [73] = "Metallic Ultra Blue",
    [74] = "Metallic Bright Blue",
    [75] = "Util Dark Blue",
    [76] = "Util Midnight Blue",
    [77] = "Util Blue",
    [78] = "Util Sea Foam Blue",
    [79] = "Uil Lightning blue",
    [80] = "Util Maui Blue Poly",
    [81] = "Util Bright Blue",
    [82] = "Matte Dark Blue",
    [83] = "Matte Blue",
    [84] = "Matte Midnight Blue",
    [85] = "Worn Dark blue",
    [86] = "Worn Blue",
    [87] = "Worn Light blue",
    [88] = "Metallic Taxi Yellow",
    [89] = "Metallic Race Yellow",
    [90] = "Metallic Bronze",
    [91] = "Metallic Yellow Bird",
    [92] = "Metallic Lime",
    [93] = "Metallic Champagne",
    [94] = "Metallic Pueblo Beige",
    [95] = "Metallic Dark Ivory",
    [96] = "Metallic Choco Brown",
    [97] = "Metallic Golden Brown",
    [98] = "Metallic Light Brown",
    [99] = "Metallic Straw Beige",
    [100] = "Metallic Moss Brown",
    [101] = "Metallic Biston Brown",
    [102] = "Metallic Beechwood",
    [103] = "Metallic Dark Beechwood",
    [104] = "Metallic Choco Orange",
    [105] = "Metallic Beach Sand",
    [106] = "Metallic Sun Bleeched Sand",
    [107] = "Metallic Cream",
    [108] = "Util Brown",
    [109] = "Util Medium Brown",
    [110] = "Util Light Brown",
    [111] = "Metallic White",
    [112] = "Metallic Frost White",
    [113] = "Worn Honey Beige",
    [114] = "Worn Brown",
    [115] = "Worn Dark Brown",
    [116] = "Worn straw beige",
    [117] = "Brushed Steel",
    [118] = "Brushed Black steel",
    [119] = "Brushed Aluminium",
    [120] = "Chrome",
    [121] = "Worn Off White",
    [122] = "Util Off White",
    [123] = "Worn Orange",
    [124] = "Worn Light Orange",
    [125] = "Metallic Securicor Green",
    [126] = "Worn Taxi Yellow",
    [127] = "police car blue",
    [128] = "Matte Green",
    [129] = "Matte Brown",
    [130] = "Worn Orange",
    [131] = "Matte White",
    [132] = "Worn White",
    [133] = "Worn Olive Army Green",
    [134] = "Pure White",
    [135] = "Hot Pink",
    [136] = "Salmon pink",
    [137] = "Metallic Vermillion Pink",
    [138] = "Orange",
    [139] = "Green",
    [140] = "Blue",
    [141] = "Mettalic Black Blue",
    [142] = "Metallic Black Purple",
    [143] = "Metallic Black Red",
    [144] = "hunter green",
    [145] = "Metallic Purple",
    [146] = "Metaillic V Dark Blue",
    [147] = "MODSHOP BLACK1",
    [148] = "Matte Purple",
    [149] = "Matte Dark Purple",
    [150] = "Metallic Lava Red",
    [151] = "Matte Forest Green",
    [152] = "Matte Olive Drab",
    [153] = "Matte Desert Brown",
    [154] = "Matte Desert Tan",
    [155] = "Matte Foilage Green",
    [156] = "DEFAULT ALLOY COLOR",
    [157] = "Epsilon Blue",
}


local playerMarkers = {}
local displayInfo = {}
local currentAddress = nil -- Track the current assigned address for the player
local currentUnit = nil
local currentVehicle = nil -- Track the player's current vehicle

-- Function to display text on screen
function DrawTextOnScreen(text, x, y, scale, center)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 200)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(center)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x, y)
end

-- Event triggered by the server to spawn the player at the assigned address
RegisterNetEvent('spawnPlayer')
AddEventHandler('spawnPlayer', function(role, chosenAddress)
    PlayerClientData.role = role
    local player = PlayerPedId()

    -- If the player already has an address and vehicle, remove the vehicle and free the previous address
    if currentAddress then
        if currentVehicle and DoesEntityExist(currentVehicle) then
            DeleteVehicle(currentVehicle)
            currentVehicle = nil
        end
        TriggerServerEvent('freeAddress', currentAddress.name)
        currentAddress = nil
    end
    if currentUnit then
        if currentVehicle and DoesEntityExist(currentVehicle) then
            DeleteVehicle(currentVehicle)
            currentVehicle = nil
        end
        TriggerServerEvent('freeUnit', currentUnit.name)
        currentUnit = nil
    end

    currentAddress = chosenAddress
    PlayerClientData.address = currentAddress.name

    -- Nationality-based logic for player name, ped model, and vehicle
    local socialgroup = currentAddress.socialgroups[math.random(#currentAddress.socialgroups)]
    local nameConfig = Config.SocialGroups[socialgroup]
    PlayerClientData.socialgroup = socialgroup

    if nameConfig then
        -- Assign name and ped model
        local firstName = nameConfig.firstNames[math.random(#nameConfig.firstNames)]
        local lastName = nameConfig.lastNames[math.random(#nameConfig.lastNames)]
        local pedModel = nameConfig.pedModels[math.random(#nameConfig.pedModels)]
        PlayerClientData.name = firstName
        PlayerClientData.surname = lastName

        -- Load and apply the ped model
        RequestModel(pedModel)
        while not HasModelLoaded(pedModel) do
            Wait(100)
        end
        SetPlayerModel(PlayerId(), pedModel)
        SetModelAsNoLongerNeeded(pedModel)

        -- Teleport the player to the chosen position
        SetEntityCoordsNoOffset(player, chosenAddress.playerPos.x, chosenAddress.playerPos.y, chosenAddress.playerPos.z, false, false, false)
        SetEntityHeading(player, chosenAddress.playerPos.w)
        NetworkResurrectLocalPlayer(chosenAddress.playerPos.x, chosenAddress.playerPos.y, chosenAddress.playerPos.z, chosenAddress.playerPos.w, true, false)
        SetPedRandomComponentVariation(PlayerPedId(), false)


        -- Spawn a random vehicle at the car position
        local chosenVehicleModel = nameConfig.vehicles[math.random(#nameConfig.vehicles)]
        local vehicleHash = GetHashKey(chosenVehicleModel)
        PlayerClientData.car = chosenVehicleModel

        RequestModel(vehicleHash)
        while not HasModelLoaded(vehicleHash) do
            Wait(100)
        end

        currentVehicle = CreateVehicle(vehicleHash, chosenAddress.carPos.x, chosenAddress.carPos.y, chosenAddress.carPos.z, chosenAddress.carPos.w, true, false)

        -- Get vehicle color and plate
        local primaryColor, _ = GetVehicleColours(currentVehicle)
        local colorName = colorNames[primaryColor] or "Unknown Color"
        local plate = GetVehicleNumberPlateText(currentVehicle)
        PlayerClientData.carcol = colorName
        PlayerClientData.carplate = plate

        -- Store the information to be displayed
        displayInfo = {
            name = firstName .. " " .. lastName,
            socialgroup = socialgroup,
            address = chosenAddress.name,
            vehicleModel = chosenVehicleModel,
            color = colorName,
            plate = plate
        }

        -- Add markers (blips) for house and car
        if playerMarkers[PlayerId()] then
            RemoveBlip(playerMarkers[PlayerId()].house)
            RemoveBlip(playerMarkers[PlayerId()].car)
        end

        local houseBlip = AddBlipForCoord(chosenAddress.playerPos.x, chosenAddress.playerPos.y, chosenAddress.playerPos.z)
        SetBlipSprite(houseBlip, 40) -- House icon

        local carBlip = AddBlipForEntity(currentVehicle)
        SetBlipSprite(carBlip, 225) -- Car icon

        playerMarkers[PlayerId()] = { house = houseBlip, car = carBlip }
        updateHUD()
        Wait(2500)
    else
        TriggerEvent('chat:addMessage', { args = { '^1Social group not found in config!' }})
    end
end)

-- Event triggered by the server to spawn the player at the assigned address
RegisterNetEvent('spawnCop')
AddEventHandler('spawnCop', function(role, chosenUnit)
    PlayerClientData.role = role
    local player = PlayerPedId()

    -- If the player already has an address and vehicle, remove the vehicle and free the previous address
    if currentUnit then
        -- Delete the current vehicle
        if currentVehicle and DoesEntityExist(currentVehicle) then
            DeleteVehicle(currentVehicle)
            currentVehicle = nil
        end

        -- Notify the server to free the previous address
        TriggerServerEvent('freeUnit', currentUnit.name)
        currentUnit = nil
    end
    if currentAddress then
        -- Delete the current vehicle
        if currentVehicle and DoesEntityExist(currentVehicle) then
            DeleteVehicle(currentVehicle)
            currentVehicle = nil
        end

        -- Notify the server to free the previous address
        TriggerServerEvent('freeAddress', currentAddress.name)
        currentAddress = nil
    end

    -- Assign the new address and save it
    currentUnit = chosenUnit
    PlayerClientData.unit = currentUnit.name

    -- Nationality-based logic for player name, ped model, and vehicle
    local division = currentUnit.divisions[math.random(#currentUnit.divisions)]
    local nameConfig = Config.Divisions[division]
    PlayerClientData.division = division

    if nameConfig then
        -- Assign name and ped model
        local firstName = nameConfig.firstNames[math.random(#nameConfig.firstNames)]
        local lastName = nameConfig.lastNames[math.random(#nameConfig.lastNames)]
        local pedModel = nameConfig.pedModels[math.random(#nameConfig.pedModels)]
        PlayerClientData.name = firstName
        PlayerClientData.surname = lastName

        -- Load and apply the ped model
        RequestModel(pedModel)
        while not HasModelLoaded(pedModel) do
            Wait(100)
        end
        SetPlayerModel(PlayerId(), pedModel)
        SetModelAsNoLongerNeeded(pedModel)

        -- Teleport the player to the chosen position
        SetEntityCoordsNoOffset(player, chosenUnit.playerPos.x, chosenUnit.playerPos.y, chosenUnit.playerPos.z, false, false, false)
        SetEntityHeading(player, chosenUnit.playerPos.w)
        NetworkResurrectLocalPlayer(chosenUnit.playerPos.x, chosenUnit.playerPos.y, chosenUnit.playerPos.z, chosenUnit.playerPos.w, true, false)
        SetPedRandomComponentVariation(PlayerPedId(), false)


        -- Spawn a random vehicle at the car position
        local chosenVehicleModel = nameConfig.vehicles[math.random(#nameConfig.vehicles)]
        local vehicleHash = GetHashKey(chosenVehicleModel)
        PlayerClientData.car = chosenVehicleModel

        RequestModel(vehicleHash)
        while not HasModelLoaded(vehicleHash) do
            Wait(100)
        end

        currentVehicle = CreateVehicle(vehicleHash, chosenUnit.carPos.x, chosenUnit.carPos.y, chosenUnit.carPos.z, chosenUnit.carPos.w, true, false)

        -- Get vehicle color and plate
        local primaryColor, _ = GetVehicleColours(currentVehicle)
        local colorName = colorNames[primaryColor] or "Unknown Color"
        local plate = GetVehicleNumberPlateText(currentVehicle)
        PlayerClientData.carcol = colorName
        PlayerClientData.carplate = plate

        -- Store the information to be displayed
        displayInfo = {
            name = firstName .. " " .. lastName,
            division = division,
            unit = chosenUnit.name,
            vehicleModel = chosenVehicleModel,
            color = colorName,
            plate = plate
        }

        -- Add markers (blips) for house and car
        if playerMarkers[PlayerId()] then
            RemoveBlip(playerMarkers[PlayerId()].house)
            RemoveBlip(playerMarkers[PlayerId()].car)
        end

        local houseBlip = AddBlipForCoord(chosenUnit.playerPos.x, chosenUnit.playerPos.y, chosenUnit.playerPos.z)
        SetBlipSprite(houseBlip, 60) -- House icon

        local carBlip = AddBlipForEntity(currentVehicle)
        SetBlipSprite(carBlip, 225) -- Car icon

        playerMarkers[PlayerId()] = { house = houseBlip, car = carBlip }
        updateHUD()
        Wait(2500)
        local loadout = Config.Divisions[PlayerClientData.division].loadout
        local item
        for _, item in ipairs(Config.Loadouts[loadout].weapons) do
            local playerIdx = GetPlayerFromServerId(source)
            local ped = GetPlayerPed(playerIdx)
            GiveWeaponToPed(ped, GetHashKey(item.weapon), item.ammo, false, true)
        end
    else
        TriggerEvent('chat:addMessage', { args = { '^1Division not found in config!' }})
    end
end)

function updateHUD()
    local hudData = {
        name = displayInfo.name,
        role = PlayerClientData.role,
        aop = CurrentAoP or "Unknown"
    }

    -- Add role-specific data
    if PlayerClientData.role == 'civ' then
        hudData.address = PlayerClientData.address
        hudData.car = PlayerClientData.car
        hudData.color = PlayerClientData.carcol
        hudData.plate = PlayerClientData.carplate
    elseif PlayerClientData.role == 'cop' then
        hudData.division = PlayerClientData.division
        hudData.unit = PlayerClientData.unit
        hudData.car = PlayerClientData.car
        hudData.color = PlayerClientData.carcol
        hudData.plate = PlayerClientData.carplate
    end

    -- Compare current hudData with previousHudData
    if not isTableEqual(hudData, previousHudData) then
        -- Send NUI message with combined HUD and AoP data
        SendNUIMessage({
            action = 'updateHud',
            data = hudData
        })
        -- Update previousHudData
        previousHudData = hudData
    end
end





-- Notify the server to free the player's address when they leave and remove the vehicle
AddEventHandler('playerDropped', function(reason)
    if currentAddress then
        -- Remove the vehicle
        if currentVehicle and DoesEntityExist(currentVehicle) then
            DeleteVehicle(currentVehicle)
            currentVehicle = nil
        end

        -- Free the address on the server
        TriggerServerEvent('freeAddress', currentAddress.name)
    end
    if currentUnit then
        -- Remove the vehicle
        if currentVehicle and DoesEntityExist(currentVehicle) then
            DeleteVehicle(currentVehicle)
            currentVehicle = nil
        end

        -- Free the address on the server
        TriggerServerEvent('freeUnit', currentUnit.name)
    end
end)

function updateCoords()
    local coords = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())
    PlayerClientData.coords = vector4(coords.x, coords.y, coords.z, heading)
end



-- Add chat suggestions for the /reg command
Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/reg', 'Register as Civilian or Police Officer', {
        { name="role", help="civ or cop" }
    })
    TriggerEvent('chat:addSuggestion', '/reg civ', 'Register as Civilian', {})
    TriggerEvent('chat:addSuggestion', '/reg cop', 'Register as Police Officer', {})
end)

-- Periodically send player data to the server
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.DataSendInterval * 1000)
        updateCoords()

        TriggerServerEvent('sendPlayerData', PlayerClientData)
    end
end)

RegisterNetEvent('sessionkick')
AddEventHandler('sessionkick', function()
    PlayerClientData = {
        id = GetPlayerServerId(PlayerId()),
        name = "",
        surname = "",        -- To be filled by player or other means
        socialgroup = "",    -- To be filled as needed
        division = "",    -- To be filled as needed
        address = "",        -- To be filled as needed
        unit = "",        -- To be filled as needed
        role = "",           -- "civ" or "cop"
        status = "free",   -- Default status
        car = "",            -- To be filled as needed
        carcol = "",         -- To be filled as needed
        carplate = "",        -- To be filled as needed
        coords = ""
    }
    if currentAddress then
        if currentVehicle and DoesEntityExist(currentVehicle) then
            DeleteVehicle(currentVehicle)
            currentVehicle = nil
        end
        TriggerServerEvent('freeAddress', currentAddress.name)
        currentAddress = nil
    end
    if currentUnit then
        if currentVehicle and DoesEntityExist(currentVehicle) then
            DeleteVehicle(currentVehicle)
            currentVehicle = nil
        end
        TriggerServerEvent('freeUnit', currentUnit.name)
        currentUnit = nil
    end
    if currentVehicle and DoesEntityExist(currentVehicle) then
        DeleteVehicle(currentVehicle)
        currentVehicle = nil
    end
    playerMarkers = {}
    if Config.ChangeBucket then
        TriggerServerEvent('changePlayerBucket')
    end
    exports.spawnmanager:spawnPlayer()
    TriggerEvent('chat:addMessage', { args = { '^1You ve been kicked from session. Enter /reg to connect on session.' }})
    updateHUD()
end)



RegisterNetEvent('forcereg')
AddEventHandler('forcereg', function()
    if PlayerClientData.role == 'cop' then
        ExecuteCommand('reg cop')
    end
    if PlayerClientData.role == 'civ' then
        ExecuteCommand('reg civ')
    end
end)
RegisterCommand('coords', function(source)
    print(PlayerClientData.coords)
end)


-- Function to toggle HUD visibility
local function toggleHUD()
    hudVisible = not hudVisible
    SendNUIMessage({
        action = 'toggleHUD',
        show = hudVisible
    })
    if hudVisible then
        updateHUD() -- Update HUD immediately when toggled on
    end
end

-- Register the command to toggle HUD
RegisterCommand('toggleDisplayData', function()
    toggleHUD()
end, false)

-- Map F7 key to toggle HUD
RegisterKeyMapping('toggleDisplayData', 'Toggle HUD Display', 'keyboard', 'F7')

-- Client-Side Registration System

local registerPanelOpen = false

-- Show welcome message on resource start
AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SendNUIMessage({
            action = 'displayNotification',
            message = 'Welcome! Press F1 to register, or F7 to toggle HUD.'
        })
    end
end)

-- Toggle Registration Panel
RegisterCommand('openRegisterPanel', function()
    TriggerEvent('toggleRegisterPanel', true)
end, false)
RegisterKeyMapping('openRegisterPanel', 'Open Registration Panel', 'keyboard', 'F1')

-- Event to open or close the registration panel
RegisterNetEvent('toggleRegisterPanel')
AddEventHandler('toggleRegisterPanel', function(show)
    registerPanelOpen = show
    SendNUIMessage({
        action = 'toggleRegisterPanel',
        show = show
    })
    SetNuiFocus(show, show)
end)

-- Handle NUI callback for registration
RegisterNUICallback('registerAs', function(data)
    if data.role == 'civ' then
        ExecuteCommand('reg civ')
    elseif data.role == 'cop' then
        ExecuteCommand('reg cop')
    end
    TriggerEvent('toggleRegisterPanel', false) -- Close panel after registration
end)

-- Close the registration panel
RegisterNUICallback('closeRegisterPanel', function()
    TriggerEvent('toggleRegisterPanel', false)
end)


function isTableEqual(t1, t2)
    if type(t1) ~= "table" or type(t2) ~= "table" then
        return t1 == t2
    end

    for k, v in pairs(t1) do
        if not isTableEqual(v, t2[k]) then
            return false
        end
    end

    for k, v in pairs(t2) do
        if not isTableEqual(v, t1[k]) then
            return false
        end
    end

    return true
end
