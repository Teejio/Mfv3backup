
local shakeMult = 1

function onCreatePost()
    setProperty('drainMult', 1.2)
    setProperty('gainMult', 0.85)
    setProperty('speedie', 15)
    luaDebugMode = true
end


function onUpdatePost(elapsed)
    currentHealth = getHealth()
    setProperty('iconP1.x', getProperty('healthBar.x') + (getProperty('healthBar.width') * (currentHealth / 2)) - 105 - 26)
    setProperty('iconP2.x', getProperty('healthBar.x') + (getProperty('healthBar.width') * (currentHealth / 2)) + 40 - 26 * 2)
    scaleObject('iconP2', 1.075,1.075)
    if getProperty('iconP2.animation.curAnim.curFrame') == 1 then
        setProperty('iconP2.offset.x', getRandomFloat(-2.5,2.5)*shakeMult)
        setProperty('iconP2.offset.y', getRandomFloat(-2.5,2.5)*shakeMult)
    else
        setProperty('iconP2.offset.x', getRandomFloat(-1.25,1.25)*shakeMult)
        setProperty('iconP2.offset.y', getRandomFloat(-1.25,1.25)*shakeMult)
    end  
end

function onBeatHit()
    if curBeat == 328 then
        shakeMult = 2.5
    end
end
