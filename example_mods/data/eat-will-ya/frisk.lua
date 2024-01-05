local hotdogSize, hotdogCount, hotdogPos = 0, 0, 0
local seen = false

function onCreatePost()
    makeLuaSprite('frisk', 'Frisk', -475,400)
    addLuaSprite('frisk')
    addHaxeLibrary('ColorSwap', 'shaders')
    runHaxeCode([[
    var frisksap = new ColorSwap();
    setVar('frisksap', frisksap);
    game.getLuaObject('frisk').shader = frisksap.shader; 
    game.boyfriend.shader = frisksap.shader; 
    ]])
end
function onSectionHit()
    if not mustHitSection and seen then
        makeDog()
    end
    if mustHitSection then
        seen = true
    else seen = false
    end
end
function makeDog()
    local var = math.floor(getSongPosition()*10*getRandomFloat(0.1,20))
        makeLuaSprite('hot'..var, 'hot_dog', getProperty('frisk.x')+50+getRandomFloat(-20,20), getProperty('frisk.y')+hotdogSize-25)
        addLuaSprite('hot'..var)
        hotdogSize = hotdogSize - getProperty('hot'..var..'.height')/1.5
end