--by Ferzy
local dir = 'stages/paula/'
local bgs = {'bgBuild', 'theater', 'squad', 'fences', 'NPC', 'cat', 'house', 'road'}
setVar('bgs', bgs)
function onCreate()
    makeLuaSprite('sky', dir.."Sky", -screenWidth/1.5,-screenHeight/2.5)
    setScrollFactor('sky', 0,0)
    addLuaSprite('sky')
    makeLuaSprite('bgBuild', dir.."BGBuildings", -screenWidth/2.5,-screenHeight/3)
    setScrollFactor('bgBuild', 0.095,0.095)
    addLuaSprite('bgBuild')
    makeLuaSprite('theater', dir.."Chaos", -650,-40)
    setScrollFactor('theater', 0.404,0.503)
    addLuaSprite('theater')
    makeLuaSprite('road', dir.."Road", -1500,350)
    setScrollFactor('road', 1,1)
    addLuaSprite('road')
    makeLuaSprite('house', dir.."garden", -550,-325)
    setScrollFactor('house', 0.95,0.95)
    addLuaSprite('house')
    makeAnimatedLuaSprite('cat', dir.."CAT", 1400,-200)
    addAnimationByPrefix('cat', 'idle', 'vibe', 24, false)
    setScrollFactor('cat', 0.95,0.95)
    addLuaSprite('cat')

    makeAnimatedLuaSprite('squad', dir.."Squad", 750,250)
    addAnimationByPrefix('squad', 'idle', 'cheering', 24, false)
    setScrollFactor('squad', 0.95,0.95)
    addLuaSprite('squad')

    makeLuaSprite('fences', dir.."Fence", -850,450)
    setScrollFactor('fences', 1,1)
    addLuaSprite('fences')

    makeAnimatedLuaSprite('NPC', dir.."NPC", 1400,375)
    scaleObject("NPC", 1.1,1.1)
    addAnimationByPrefix('NPC', 'idle', 'being_weird', 24, false)
    addLuaSprite('NPC')
end
function onCreatePost()
    stageIdle()  
end
function onSongStart()
    stageIdle()  
end

function onCountdownTick(tick)
    if tick == 2 then
        stageIdle()  
    end
end
function onBeatHit()
    if curBeat % 2 == 0 then
        stageIdle()  
    end
end
function stageIdle()
    playAnim('cat', 'idle')
    playAnim('squad', 'idle')
    playAnim('NPC', 'idle')
end
