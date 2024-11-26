-- Existing CurrentAoP and Event Registration Code
_G.CurrentAoP = ""

RegisterNetEvent('updateAoP')
AddEventHandler('updateAoP', function(aop)
    _G.CurrentAoP = aop
    
    if hudVisible then
        updateHUD()
    end
end)

Citizen.CreateThread(function()
    TriggerServerEvent('requestAoP')
end)

-- Listen for vote start and display notification
RegisterNetEvent('startVote')
AddEventHandler('startVote', function(duration, options)
    SendNUIMessage({
        action = 'startVote',
        duration = duration,
        options = options
    })
end)

-- Listen for vote result display
RegisterNetEvent('displayAoPResult')
AddEventHandler('displayAoPResult', function(result)
    SendNUIMessage({
        action = 'displayAoPResult',
        result = result
    })
end)


local votePanelOpen = false
local voteInProgress = false

-- Update voting state when a vote starts or ends
RegisterNetEvent('updateVoteState')
AddEventHandler('updateVoteState', function(state)
    voteInProgress = state
    if not state and votePanelOpen then
        -- If the vote has ended while the panel is open, close the panel
        TriggerEvent('toggleVotePanel', false)
    end
end)

-- Toggle the voting panel visibility and control state
RegisterNetEvent('toggleVotePanel')
AddEventHandler('toggleVotePanel', function(show)
    if voteInProgress or not show then -- Only show if vote is in progress
        votePanelOpen = show
        SendNUIMessage({
            action = 'toggleVotePanel',
            show = show
        })
        SetNuiFocus(show, show)
    else
        -- Optional: Display a notification that voting is not available
        SendNUIMessage({
            action = 'displayNotification',
            message = 'No vote in progress.'
        })
    end
end)
-- Disable specific controls while the vote panel is open
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if votePanelOpen then
            -- Disable controls while vote panel is open
            DisableControlAction(0, 1, true) -- LookLeftRight
            DisableControlAction(0, 2, true) -- LookUpDown
            DisableControlAction(0, 30, true) -- MoveLeftRight
            DisableControlAction(0, 31, true) -- MoveUpDown
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 37, true) -- Weapon Wheel
            DisableControlAction(0, 44, true) -- Cover
            DisableControlAction(0, 140, true) -- Melee Attack Light
            DisableControlAction(0, 141, true) -- Melee Attack Heavy
            DisableControlAction(0, 142, true) -- Melee Attack Alternate
            DisableControlAction(0, 199, true) -- Pause menu (ESC)
        end
    end
end)

-- Command to open the vote panel
RegisterCommand('openVotePanel', function()
    if voteInProgress then
        TriggerEvent('toggleVotePanel', true)
    else
        -- Optional: Show a notification if trying to open without a vote in progress
        SendNUIMessage({
            action = 'displayWelcomeNotification',
            message = 'No vote in progress.'
        })
    end
end, false)

-- Close the vote panel and restore controls
RegisterNUICallback('closeVotePanel', function()
    votePanelOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'toggleVotePanel',
        show = false
    })
end)
RegisterNUICallback('submitVote', function(data, cb)
    -- Send the vote choice to the server
    TriggerServerEvent('vote', data.choice)
    cb('ok')
end)

RegisterKeyMapping('openVotePanel', 'Open AoP Vote Panel', 'keyboard', 'F3')
