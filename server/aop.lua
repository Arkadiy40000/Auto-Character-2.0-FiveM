CurrentAoP = Config.DefaultAoP
local voteInProgress = false
local playerVotes = {}  -- Stores player votes: [playerId] = optionIndex
local voteOptions = {}  -- Stores AoP options for the current vote
local voteNames = {}    -- Stores the names of the AoP options

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        -- Set the initial AoP to the default
        CurrentAoP = Config.DefaultAoP
        TriggerClientEvent('updateAoP', -1, CurrentAoP) -- Send to all clients
    end
end)

-- Trigger a new vote
function initiateVote()
    if voteInProgress then
        return
    end

    voteInProgress = true
    playerVotes = {}
    voteOptions = {}
    voteNames = {}

    -- Collect available AoPs for voting
    for aopName, _ in pairs(Config.AoPs) do
        if aopName ~= CurrentAoP then
            table.insert(voteNames, aopName)
        end
    end

    if Config.AllowKeepCurrentAoP then
        table.insert(voteNames, "Keep Current AoP")
    end

    -- Inform clients about the start of the vote
    TriggerClientEvent('startVote', -1, Config.VoteDuration, voteNames)
    TriggerClientEvent('updateVoteState', -1, true)

    -- Schedule the conclusion of the vote
    SetTimeout(Config.VoteDuration * 1000, concludeVote)
end

-- Conclude the vote and determine the winning AoP
function concludeVote()
    if not voteInProgress then return end
    voteInProgress = false

    -- Tally the votes
    local voteCounts = {}  -- [optionIndex] = count
    local maxVotes = 0
    local potentialWinners = {}

    -- Initialize vote counts
    for i = 1, #voteNames do
        voteCounts[i] = 0
    end

    -- Count votes
    for _, choice in pairs(playerVotes) do
        voteCounts[choice] = voteCounts[choice] + 1
    end

    -- Determine the maximum number of votes
    for i, count in pairs(voteCounts) do
        if count > maxVotes then
            maxVotes = count
        end
    end

    -- Collect all options with the maximum votes
    for i, count in pairs(voteCounts) do
        if count == maxVotes then
            table.insert(potentialWinners, i)
        end
    end

    -- Randomly select a winner from potential winners
    local winningIndex = potentialWinners[math.random(#potentialWinners)]
    local winningAoP = voteNames[winningIndex]

    -- If winning AoP differs, update and inform clients
    if winningAoP ~= "Keep Current AoP" then
        CurrentAoP = winningAoP
        TriggerClientEvent('displayAoPResult', -1, CurrentAoP)
        TriggerClientEvent('updateAoP', -1, CurrentAoP)
    else
        TriggerClientEvent('displayAoPResult', -1, "Keep Current AoP")
    end

    TriggerClientEvent('updateVoteState', -1, false)

    -- Prepare for the next vote cycle
    SetTimeout(Config.VoteCooldown * 1000, initiateVote)
end

-- Handle incoming votes
RegisterServerEvent('vote')
AddEventHandler('vote', function(choice)
    local playerId = source

    if not voteInProgress then
        TriggerClientEvent('chat:addMessage', playerId, { args = { '^1ERROR: No vote in progress.' } })
        return
    end

    if not voteNames[choice] then
        TriggerClientEvent('chat:addMessage', playerId, { args = { '^1ERROR: Invalid vote option.' } })
        return
    end

    -- Register or update the player's vote
    playerVotes[playerId] = choice
    TriggerClientEvent('chat:addMessage', playerId, { args = { '^3Your vote has been recorded for ^1' .. voteNames[choice] .. '^3.' } })
end)

-- Forcefully start a vote, even if one is in progress or cooldown
RegisterCommand('forcevote', function(source, args, rawCommand)
    local playerId = source

    if voteInProgress then
        TriggerClientEvent('chat:addMessage', playerId, { args = { '^1ERROR: A vote is already in progress.' } })
        return
    end

    -- Bypass cooldown and initiate vote immediately
    initiateVote()
    TriggerClientEvent('chat:addMessage', playerId, { args = { '^3A new AoP vote has been forcefully initiated.' } })
end, true)

-- Forcefully set an AoP without a vote
RegisterCommand('setaop', function(source, args, rawCommand)
    local playerId = source
    local newAoP = table.concat(args, " ")

    -- Validate AoP name
    if newAoP == "" then
        TriggerClientEvent('chat:addMessage', playerId, { args = { '^1ERROR: Please specify an Area of Play to set.' } })
        return
    end

    local isValidAoP = false
    for aopName, _ in pairs(Config.AoPs) do
        if aopName:lower() == newAoP:lower() then
            newAoP = aopName
            isValidAoP = true
            break
        end
    end

    if not isValidAoP then
        TriggerClientEvent('chat:addMessage', playerId, { args = { '^1ERROR: Invalid AoP name. Please choose a valid Area of Play.' } })
        return
    end

    -- Set AoP and inform clients
    CurrentAoP = newAoP
    TriggerClientEvent('displayAoPResult', -1, CurrentAoP)
    TriggerClientEvent('updateAoP', -1, CurrentAoP)
    TriggerClientEvent('chat:addMessage', playerId, { args = { '^3The Area of Play has been forcefully set to ^1' .. CurrentAoP .. '^3.' } })
end, true)

RegisterNetEvent('requestAoP')
AddEventHandler('requestAoP', function()
    local src = source
    TriggerClientEvent('updateAoP', src, CurrentAoP)
end)