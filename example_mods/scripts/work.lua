--script by sirFerzy
---@diagnostic disable: need-check-nil
local opponentNotes = true
local bfNotes = true
local json = require("mods/scripts/dkjson")

setVar('startSpeed', 1.25)
local function readJson(filePath, info)
    local file = io.open(filePath, "r")
    if not file then return nil end

    local jsonData = file:read("*a")
    file:close()

    local decodedData = json.decode(jsonData)
    return decodedData and decodedData[info]
end

function onCreatePost()
    setProperty('isCameraOnForcedPos', false)
    runHaxeCode([[
        setVar('bfCamMove', [40, 40]);
        setVar('dadCamMove', [50, 50]);
    ]])
    if getProperty('skipCountdown') then
        setProperty('cameraSpeed', 100)
    else
        setProperty('cameraSpeed', 2.5)
    end
    callMethod('moveCameraSection')

    setUp()
end

function setUp()
    local cam = readJson('mods/stages/' .. curStage .. '.json', 'camMove')
    for i = 1, 2 do
        setProperty('dadCamMove[' .. (i - 1) .. ']', cam.dad.range[i])
        setProperty('bfCamMove[' .. (i - 1) .. ']', cam.boyfriend.range[i])
    end
    bfNotes = cam.boyfriend.active
    opponentNotes = cam.dad.active
end

function onUpdate()
    local off1 = { getProperty('bfCamMove[0]'), getProperty('bfCamMove[1]') }
    xy = { { -off1[1], 0 }, { 0, off1[2] }, { 0, -off1[2] }, { off1[1], 0 } }
    local off2 = { getProperty('dadCamMove[0]'), getProperty('dadCamMove[1]') }
    sxy = { { -off2[1], 0 }, { 0, off2[2] }, { 0, -off2[2] }, { off2[1], 0 } }
end

function onSongStart()
    setProperty('cameraSpeed', getVar('startSpeed'))
end

function opponentNoteHit(i, d, n, s)
    if opponentNotes and not mustHitSection or opponentNotes and curBeat <= 4 then resetCamDad(d) end
end

function goodNoteHit(i, d, n, s)
    if bfNotes and mustHitSection or bfNotes and curBeat <= 4 then resetCamBF(d) end
end

function resetCamDad(d)
    if not getProperty('isCameraOnForcedPos') then
        callMethod('moveCameraSection')
        setProperty('camFollow.x', getProperty('camFollow.x') + sxy[d + 1][1])
        setProperty('camFollow.y', getProperty('camFollow.y') + sxy[d + 1][2])
    end
end

function resetCamBF(d)
    if not getProperty('isCameraOnForcedPos') then
        callMethod('moveCameraSection')
        setProperty('camFollow.x', getProperty('camFollow.x') + xy[d + 1][1])
        setProperty('camFollow.y', getProperty('camFollow.y') + xy[d + 1][2])
    end
end

function onEvent(n, a)
    if n == 'focusCamera' then
        setProperty('isCameraOnForcedPos', false)
        cameraSetTarget(a)
    end
end
