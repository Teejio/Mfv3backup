--Script by sirFerzy

function math.lerp(from, to, i)
    return from + (to - from) * i
end

local shadname = 'ferzy2'
local setTo, zoomult = 0.05, 1

function onCreatePost()
    setVar('force', 0)
    setVar('strength', 0)
    setVar('bright', 0)
    setVar('bloom', 0)
    setProperty('camZoomingMult', 0)

    if not lowQuality then
        loadShader()
    end
end

function loadShader()
    if not lowQuality then
        initLuaShader(shadname)

        makeLuaSprite("silly")
        makeGraphic("silly", 1, 1)

        setSpriteShader("silly", shadname)

        addHaxeLibrary("ShaderFilter", "openfl.filters")
        if shadersEnabled then
            runHaxeCode([[
            var clorsap = new ColorSwap();
            trace(ShaderFilter);
            game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("silly").shader),new ShaderFilter(clorsap.shader)]);
            game.camGame.setFilters([new ShaderFilter(game.getLuaObject("silly").shader),new ShaderFilter(clorsap.shader)]);
            ]])
        end
    end
end

function onUpdate(elapsed)
    local shaderSpeed = 10 * playbackRate
    setProperty('force', math.lerp(getProperty('force'), setTo, elapsed * shaderSpeed))
    setShaderFloat('silly', 'force', getProperty('force') * 1.15)
    local flashSpeed = 5 * playbackRate
    setProperty('bright', math.lerp(getProperty('bright'), 0.4, elapsed * flashSpeed))
    setShaderFloat('silly', 'brighten', getProperty('bright'))

    local bloomSpeed = 5 * playbackRate
    if curBeat <= 520 or curBeat > 584 then
        setProperty('bloom', math.lerp(getProperty('bloom'), 0, elapsed * bloomSpeed))
        setShaderFloat('silly', 'lighting', getProperty('bloom'))
    end

    local shakeSpeed = 5 * playbackRate
    if getProperty('strength') > 0.01 then
        cameraShake('game', getProperty('strength') / 30, 0.04)
        cameraShake('hud', getProperty('strength') / 75, 0.04)
        setProperty('strength', math.lerp(getProperty('strength'), 0, elapsed * shakeSpeed))
    end
end

function onUpdatePost()
    if curBeat < 647 then
        setProperty('bright', 0.3 + 0.3 * math.sin(getSongPosition() / 1500))
    end
    if curBeat > 711 then
        setProperty('bright', 0.2 + 0.3 * math.sin(getSongPosition() / 500))
    end
    if curBeat >= 520 and curBeat < 584 then
        setShaderFloat('silly', 'lighting', getProperty('bloom') + 0.025 * math.cos(getSongPosition() / 500))
    end
end

function onBeatHit()
    if curBeat >= 128 and curBeat < 188 and curBeat % 2 == 0 then
        setProperty('force', getProperty('force') + 0.4)
        setProperty('strength', getProperty('strength') + 0.25)
        triggerEvent('Add Camera Zoom', 0.05 * zoomult, 0.075)
    end
    if curBeat >= 192 and curBeat < 253 and curBeat % 2 == 0 then
        if curBeat ~= 222 and curBeat ~= 223 then
            setProperty('force', getProperty('force') + 0.5)
            setProperty('strength', getProperty('strength') + 0.3)
            triggerEvent('Add Camera Zoom', 0.075 * zoomult, 0.085)
        end
    end
    if curBeat > 647 and curBeat % 2 == 0 and curBeat < 711 then
        setProperty('force', getProperty('force') + 0.7)
        setProperty('strength', getProperty('strength') + 0.5)
        triggerEvent('Add Camera Zoom', 0.075 * zoomult, 0.085)
        setProperty('bloom', 0.15)
        setProperty('bright', -0.8)
    end

    if curBeat >= 711 and curBeat % 2 == 0 and curBeat < 776 then
        setProperty('force', getProperty('force') + 1)
        setProperty('strength', getProperty('strength') + 0.6)
        triggerEvent('Add Camera Zoom', 0.09 * zoomult, 0.125)
    end


    if curBeat % 2 == 0 and curBeat >= 448 and curBeat < 512 then
        triggerEvent('Add Camera Zoom', 0.03 * zoomult, 0.025)
        setProperty('force', getProperty('force') + 0.15)
        setProperty('strength', getProperty('strength') + 0.1)
    end

    if curBeat == 63 then
        setProperty('camZoomingMult', 2)
    end
    if curBeat == 128 then
        setProperty('camZoomingDecay', 2.5)
        setProperty('camZoomingMult', 0)
    end
    if curBeat == 256 then
        setProperty('camZoomingDecay', 1.75)
        setProperty('camZoomingMult', 1.5)
    end
    if curBeat == 383 then
        setProperty('camZoomingDecay', 1.5)
        setProperty('camZoomingMult', 0)
    end
    if curBeat == 583 then
        setProperty('camZoomingDecay', 1.25)
        setProperty('camZoomingMult', 0)
    end
    if curBeat == 684 then
        setProperty('camZoomingDecay', 2.75)
        setProperty('camZoomingMult', 0)
    end
    if curBeat == 776 then
        setProperty('camZoomingDecay', 0.75)
        setProperty('camZoomingMult', 0)
    end
end

function onStepHit()
    if mustHitSection then
        zoomult = 1.5
    else
        zoomult = 1
    end
    if curBeat == 520 then
        setProperty('bloom', 0.25)
        setTo = 0.2
    end
    if curBeat > 530 and curBeat < 581 then
        setTo = setTo * 1.0005
        setProperty('bloom', getProperty('bloom') * 1.002)
    end
    if curBeat == 582 then
        setTo = setTo + 0.3
    end
    if curBeat == 584 then
        setTo = 0.125
        setShaderFloat('silly', 'lighting', 0)
    end
    if curStep == 2848 or curStep == 2850 or curStep == 2852 then
        setTo = setTo + 0.06
    end
    if curStep == 3104 then
        setTo = 0.2
    end
    if curBeat == 646 or curBeat == 647 or curBeat == 190 or curBeat == 191 or curBeat == 222 or curBeat == 223 or curBeat == 710 or curBeat == 711 then
        if curStep % 2 == 0 then
            triggerEvent('Add Camera Zoom', 0.02 * zoomult, 0.03)
            setProperty('force', getProperty('force') + 0.15)
            setProperty('strength', getProperty('strength') + 0.1)
        end
    end
end

function onSectionHit()
    if curSection >= 96 and curSection < 128 then
        triggerEvent('Add Camera Zoom', 0.07 * zoomult, 0.065)
        setProperty('force', getProperty('force') + 0.25)
        setProperty('strength', getProperty('strength') + 0.15)
    end
    if curSection >= 146 and curSection < 160 then
        setProperty('force', getProperty('force') + 1)
        setProperty('strength', 0.7)
        triggerEvent('Add Camera Zoom', 0.05 * zoomult, 0.075)
    end
    if curSection > 198 then
        setProperty('force', getProperty('force') + 2.5)
        setProperty('strength', 0.9)
        triggerEvent('Add Camera Zoom', 0.1 * zoomult, 0.1)
    end
end
