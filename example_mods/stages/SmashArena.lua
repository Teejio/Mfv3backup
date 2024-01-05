--custom stage by sirFerzy
local dir = 'stages/smashmybros/'
local charDir = 'stages/smashmybros/bgCharacters/'
local json = require("mods/scripts/dkjson")
local leftGroup, middleGroup, rightGroup = { 'yielder', 'BOWCER', 'Gender', 'TheGOAT', 'Flaco', 'HYAAAH' }, { 'Gurlfrien','Boner', 'PickMen', 'GiegueTwo', 'Do' , 'SuperFuckingMario' }, { 'iuuuu','Kirbo', 'LaBella', 'Pito', 'Inki', 'Bofren'}
local positions = {

    {-200,250},
    {450,200},
    {1000,250}

}
local clouds = {}
function readJson(filePath, info)
    local file = io.open(filePath, "r")
    if not file then return nil end

    local decodedData = json.decode(file:read("*a"))
    file:close()

    for key in info:gmatch("[^.]+") do
        decodedData = decodedData[key]
        if not decodedData then return nil end
    end

    return decodedData
end
debugPrint(readJson('mods/data/fire-at-will/killme.json', 'Middle.Gurlfrien').idleName)

local died, flying, wf = false, false, false


function onCreate()
    addHaxeLibrary('ColorSwap', 'shaders')
    luaDebugMode = true
    makeLuaSprite('sky', dir .. 'sky', 0, 0)
    scaleObject('sky', 1.2, 1.2)
    screenCenter('sky')
    setScrollFactor('sky', 0, 0)
    addLuaSprite('sky')
for i = 0, 5 do
    local var = 'cloud'..getRandomInt(1, 100)
    local scale = getRandomFloat(0.75, 2)
    makeLuaSprite(var, dir..'clouds/cloud'..getRandomInt(1,5), getRandomInt(-1400, 1000), getRandomFloat(-500, 500))
    setScrollFactor(var)
    setProperty(var..'.velocity.x', getRandomFloat(100,200) * scale)
    scaleObject(var, scale, scale)
    setProperty(var..'.alpha', getRandomFloat(0.8,1))
    addLuaSprite(var)
    table.insert(clouds, var)
end
    makeLuaSprite('bg', dir .. 'bg', -700, -400)
    scaleObject('bg', 0.75, 0.75)
    addLuaSprite('bg')
    makeRight(getRandomInt(1, #rightGroup))
    makeMid(getRandomInt(1, #middleGroup))
    makeLeft(getRandomInt(1, #leftGroup))
end

function makeLeft(num)
    local name = leftGroup[num]
    local char = readJson('mods/data/fire-at-will/killme.json', "Left."..name)
    makeAnimatedLuaSprite('bruh', charDir..'Left/'..name ,positions[1][1]+char.xOffset,positions[1][2]+char.yOffset)
    scaleObject('bruh', char.scale[1],char.scale[2])
    addAnimationByPrefix('bruh', 'idle', char.idleName, 24, false)
    addLuaSprite('bruh')
end

function makeMid(num)
    local name = middleGroup[num]
    local char = readJson('mods/data/fire-at-will/killme.json', "Middle."..name)
    if name == 'GiegueTwo' then
        flying = true
    end
    makeAnimatedLuaSprite('woah', charDir..'Middle/'..name ,positions[2][1]+char.xOffset,positions[2][2]+char.yOffset)
    scaleObject('woah', char.scale[1],char.scale[2])
    addAnimationByPrefix('woah', 'idle', char.idleName, 24, false)
    addLuaSprite('woah')
    
end
function makeRight(num)
    local name = rightGroup[num]
    local char = readJson('mods/data/fire-at-will/killme.json', "Right."..name)
    if name == 'iuuuu' then
    wf = true
    end
    makeAnimatedLuaSprite('nah', charDir..'Right/'..name ,positions[3][1]+char.xOffset,positions[3][2]+char.yOffset)
    scaleObject('nah', char.scale[1],char.scale[2])
    addAnimationByPrefix('nah', 'idle', char.idleName, 24, false)
    addLuaSprite('nah')
    debugPrint('nah')
end

function onSongStart()
    bgIdle()
end

function onCountdownTick(fag)
    if fag == 2 then
        bgIdle()
    end
end

function onBeatHit()
    if curBeat % 2 == 0 then
        bgIdle()
    end
    if curBeat == 328 and wf then
        callOnLuas('customLoad', { 'bf', 'lucas-Dull' })
    end
end
function onCreatePost()
    if wf  then
        runHaxeCode([[
        var wasp = new ColorSwap();
        setVar('wasp', wasp);
        game.getLuaObject('lucas').shader = wasp.shader; 
        wasp.saturation = -0.3;
        ]])
    end
end

function bgIdle()
    playAnim('nah', 'idle')
    playAnim('bruh', 'idle')
    playAnim('woah', 'idle')
end
function onUpdatePost() 
    if flying then
        setProperty('woah.y', positions[2][2] - 200 + 100*math.cos(getSongPosition()/900))
        setProperty('woah.x', positions[2][1] -100 + 150*math.sin(getSongPosition()/1500))
        
    end
    for _,cloud in ipairs(clouds) do
        if getProperty(cloud..'.x') >= 1800 then
            removeLuaSprite(cloud)
            table.remove(clouds, _)
            createCloud()
        end
    end
    if died then
        setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
        callMethod('moveCameraSection')

        setPropertyFromClass('backend.Conductor', 'songPosition', 2)
    end
end
function createCloud()
    local var = 'cloud'..getRandomInt(1, 999000)
    local scale = getRandomFloat(0.75, 2)
    makeLuaSprite(var, dir..'clouds/cloud'..getRandomInt(1,5), -1400, getRandomFloat(-500, 500))
    setScrollFactor(var)
    scaleObject(var, scale, scale)
    setProperty(var..'.velocity.x', getRandomFloat(100,200) * scale)
    setProperty(var..'.alpha', getRandomFloat(0.8,1))
    addLuaSprite(var)
    setObjectOrder(var, getObjectOrder('sky')+1)
    table.insert(clouds, var)
end
function onTimerCompleted(tag)
    if tag == 'speed' then
        startTween('tweenish', 'this', { cameraSpeed = 15 }, 1.5, { ease = 'backOut' })

        doTweenZoom('teheh', 'camGame', 0.9, 1.5, 'sinOut')
    end
    if tag == 'look' then
        startTween('tweenish', 'this', { cameraSpeed = 1 }, 0.75, { ease = 'sinOut' })
        doTweenZoom('teheh', 'camGame', 0.5, 0.75, 'cubeOut')
        setProperty('boyfriend.angularAcceleration', 3000)
    end
    if tag == 'death' then
        restartSong()
    end
end

function onGameOver()
    setProperty('healthy', 0.1)
    die()
    died = true
    return Function_Stop
end

function die()
    setProperty('boyfriend.velocity.y', -7600)
    setProperty('boyfriend.velocity.x', 4000)
    setProperty('boyfriend.acceleration.y', 200)
    setProperty('boyfriend.angularDrag', 1000)
    setProperty('boyfriend.angularVelocity', 3000)
    setProperty('cameraSpeed', 6)
    runTimer('look', 3)
    runTimer('death', 4.5)
    runTimer('speed', 1)
    doTweenZoom('teheh', 'camGame', 0.5, 0.75, 'cubeIn')
    for i = 0, getProperty('notes.length') - 1 do
        setProperty('notes.members[' .. i .. '].ignoreNote', true)
        setProperty('notes.members[' .. i .. '].tooLate', true)
        setProperty('notes.members[' .. i .. '].visible', false)
    end
    for e = 0, getProperty('unspawnNotes.length') - 1 do
        setProperty('unspawnNotes[' .. e .. '].ignoreNote', true)
        setProperty('unspawnNotes[' .. e .. '].tooLate', true)
        setProperty('unspawnNotes[' .. e .. '].visible', false)
    end
end



