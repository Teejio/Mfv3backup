--Script by sirFerzy

function boundTo(value, min, max)
    return math.max(min, math.min(max, value))
end

function math.lerp(from, to, i)
    return from + (to - from) * i
end

local shadname = 'ferzy'
local setTo, zoomult = 0, 1

function onCreatePost()
    setVar('force', 0)
    setVar('strength', 0)
    setVar('bloom', 0)
    if not lowQuality then
        loadShader()
    end
end

function loadShader()
    initLuaShader(shadname)

    makeLuaSprite("silly")
    makeGraphic("silly", 1, 1)
    setSpriteShader("silly", shadname)

    addHaxeLibrary("ShaderFilter", "openfl.filters")
    addHaxeLibrary('ColorSwap','shaders')
    runHaxeCode([[
        var clorsap = new ColorSwap();
        trace(ShaderFilter);
        game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("silly").shader),new ShaderFilter(clorsap.shader)]);
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("silly").shader),new ShaderFilter(clorsap.shader)]);
    ]])
end

function onUpdate(elapsed)
    if not lowQuality then
        local shaderSpeed = 7 * playbackRate
        setProperty('force', math.lerp(getProperty('force'), setTo, boundTo(elapsed * shaderSpeed, 0, 1)))
        setShaderFloat('silly', 'force', getProperty('force') * 1.1)

        setProperty('bloom', math.lerp(getProperty('bloom'), setTo, boundTo(elapsed * shaderSpeed*1.2, 0, 1)))
        setShaderFloat('silly', 'lighting', getProperty('bloom')*0.9)
        
        
        local shakeSpeed = 6.5 * playbackRate
        if getProperty('strength') > 0.01 then
            cameraShake('game', getProperty('strength') / 30, 0.04)
            cameraShake('hud', getProperty('strength') / 75, 0.04)
            setProperty('strength', math.lerp(getProperty('strength'), 0, boundTo(elapsed * shakeSpeed, 0, 1)))
        end
    end
end