--script by sirFerzy
local json = require("mods/scripts/dkjson")
local bfColor = {}
local dadColor = {}
local anyColor = {}
local rColor = {
    { "C24B99", "00FFFF", "12FA05", "F9393F" },
    { "FFFFFF", "FFFFFF", "FFFFFF", "FFFFFF" },
    { "3C1F56", "1542B7", "0A4447", "651038" }
}
local bfLoaded, dadLoaded = false, false
local function readJson(filePath, info)
    local file = io.open(filePath, "r")
    if not file then return nil end

    local jsonData = file:read("*a")
    file:close()

    local decodedData = json.decode(jsonData)
    return decodedData and decodedData[info]
end

function fileExists(filename)
    local file = io.open(filename, "r")
    if file then
        io.close(file)
        return true
    end
    return false
end

function onCreate()
    setVar('colorEnabled', true)
end

function onCreatePost()
    if not getPropertyFromClass('ClientPrefs', 'customNoteColors') then
        bfSkin()
        dadSkin()
    end
end

function noteMiss()
    for i = 0, getProperty('notes.length') - 1 do
        if getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'rgbShader.enabled') then
            setPropertyFromGroup('notes', i, 'rgbShader.b',
                getColorFromHex(rColor[1][getPropertyFromGroup('notes', i, 'noteData') + 1]))
            setPropertyFromGroup('notes', i, 'rgbShader.g',
                getColorFromHex(rColor[1][getPropertyFromGroup('notes', i, 'noteData') + 1]))
            setPropertyFromGroup('notes', i, 'rgbShader.r', -0.6)
        end
    end
    runTimer('backToNorm', 0.2)
end

function goodNoteHit()
    returnColorBF()
end

function dadSkin()
    local stage = readJson('mods/stages/' .. curStage .. '.json', 'dadColor')
    if stage == nil or stage == 'bf' then return end
    for i = 1, 4 do
        local color = readJson('mods/data/color/' .. stage .. '.json', 'color' .. i)
        dadColor[i] = color
        dadLoaded = true
    end
    for i = 0, getProperty('unspawnNotes.length') do
        if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') and getPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled') then
            local data = getPropertyFromGroup('unspawnNotes', i, 'noteData')
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.r', getColorFromHex(dadColor[data + 1].r))
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.g', getColorFromHex(dadColor[data + 1].g))
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.b', getColorFromHex(dadColor[data + 1].b))
        end
    end
end

function onUpdatePost()
    if getProperty('colorEnabled') then
        for i = 0, 3 do
            if bfLoaded then
                if not getPropertyFromGroup('playerStrums', i, 'animation.name'):find('static') then
                    setPropertyFromGroup('playerStrums', i, 'rgbShader.r', getColorFromHex(bfColor[i + 1].r))
                    setPropertyFromGroup('playerStrums', i, 'rgbShader.g', getColorFromHex(bfColor[i + 1].g))
                    setPropertyFromGroup('playerStrums', i, 'rgbShader.b', getColorFromHex(bfColor[i + 1].b))
                end
            end
            if dadLoaded then
                if not getPropertyFromGroup('opponentStrums', i, 'animation.name'):find('static') then
                    setPropertyFromGroup('opponentStrums', i, 'rgbShader.r', getColorFromHex(dadColor[i + 1].r))
                    setPropertyFromGroup('opponentStrums', i, 'rgbShader.g', getColorFromHex(dadColor[i + 1].g))
                    setPropertyFromGroup('opponentStrums', i, 'rgbShader.b', getColorFromHex(dadColor[i + 1].b))
                end
            end
        end
    end
end

function returnColorBF()
    if getProperty('colorEnabled') then
        if bfLoaded == true then
            for i = 0, getProperty('notes.length') do
                if getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'rgbShader.enabled') then
                    local data = getPropertyFromGroup('notes', i, 'noteData')
                    setPropertyFromGroup('notes', i, 'rgbShader.r', getColorFromHex(bfColor[data + 1].r))
                    setPropertyFromGroup('notes', i, 'rgbShader.g', getColorFromHex(bfColor[data + 1].g))
                    setPropertyFromGroup('notes', i, 'rgbShader.b', getColorFromHex(bfColor[data + 1].b))
                end
            end
        else
            for i = 0, getProperty('notes.length') do
                if getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'rgbShader.enabled') then
                    local data = getPropertyFromGroup('notes', i, 'noteData')
                    setPropertyFromGroup('notes', i, 'rgbShader.r', getColorFromHex(rColor[1][data + 1]))
                    setPropertyFromGroup('notes', i, 'rgbShader.g', getColorFromHex(rColor[2][data + 1]))
                    setPropertyFromGroup('notes', i, 'rgbShader.b', getColorFromHex(rColor[3][data + 1]))
                end
            end
        end
    end
end

function customLoad(char, data)
    local type, check
    if data == nil then return end
    for i = 1, 4 do
        local color = readJson('mods/data/color/' .. data .. '.json', 'color' .. i)
        anyColor[i] = color
        if char == 'dad' then
            dadColor[i] = color
            dadLoaded = true
        elseif char == 'bf' then
            bfColor[i] = color
            rColor[1][i] = bfColor[i].r
            bfLoaded = true
        end
    end
    if char == 'dad' then
        type = 'opponent'
        check = false
    elseif char == 'bf' then
        type = 'player'
        check = true
    end
    for i = 0, getProperty('unspawnNotes.length') do
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == check and getPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled') then
            local data = getPropertyFromGroup('unspawnNotes', i, 'noteData')
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.r', getColorFromHex(anyColor[data + 1].r))
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.g', getColorFromHex(anyColor[data + 1].g))
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.b', getColorFromHex(anyColor[data + 1].b))
        end
    end
    for i = 0, getProperty('notes.length') do
        if getPropertyFromGroup('notes', i, 'mustPress') == check and getPropertyFromGroup('notes', i, 'rgbShader.enabled') then
            local data = getPropertyFromGroup('notes', i, 'noteData')
            setPropertyFromGroup('notes', i, 'rgbShader.r', getColorFromHex(anyColor[data + 1].r))
            setPropertyFromGroup('notes', i, 'rgbShader.g', getColorFromHex(anyColor[data + 1].g))
            setPropertyFromGroup('notes', i, 'rgbShader.b', getColorFromHex(anyColor[data + 1].b))
        end
    end
end

function bfSkin()
    local stage = readJson('mods/stages/' .. curStage .. '.json', 'bfColor')
    if stage == nil or stage == 'bf' then return end
    for i = 1, 4 do
        local color = readJson('mods/data/color/' .. stage .. '.json', 'color' .. i)
        bfColor[i] = color
        bfLoaded = true
        rColor[1][i] = bfColor[i].r
    end
    for i = 0, getProperty('unspawnNotes.length') do
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') and getPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled') then
            local data = getPropertyFromGroup('unspawnNotes', i, 'noteData')
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.r', getColorFromHex(bfColor[data + 1].r))
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.g', getColorFromHex(bfColor[data + 1].g))
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.b', getColorFromHex(bfColor[data + 1].b))
        end
    end
    for i = 0, getProperty('notes.length') do
        if getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'rgbShader.enabled') then
            local data = getPropertyFromGroup('notes', i, 'noteData')
            setPropertyFromGroup('notes', i, 'rgbShader.r', getColorFromHex(bfColor[data + 1].r))
            setPropertyFromGroup('notes', i, 'rgbShader.g', getColorFromHex(bfColor[data + 1].g))
            setPropertyFromGroup('notes', i, 'rgbShader.b', getColorFromHex(bfColor[data + 1].b))
        end
    end
end

function onTimerCompleted(tag)
    if tag == 'backToNorm' then
        returnColorBF()
    end
end
