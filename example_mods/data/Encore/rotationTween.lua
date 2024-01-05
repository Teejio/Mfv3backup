--script by Ferzy
local vars = {
    "x", "y", "angle", "zoom"
}
function onCreate()
    if not shadersEnabled then
        close()
    end
end

function onCreatePost()
    shadname = "rotate"
    initLuaShader(shadname)

    makeLuaSprite("funnyShader")
    makeGraphic("funnyShader", 1, 1)
    setSpriteShader("funnyShader", shadname)
    makeLuaSprite("funnyShader2")
    makeGraphic("funnyShader2", 1, 1)
    setSpriteShader("funnyShader2", shadname)
    runHaxeCode([[
        trace(ShaderFilter);
        FlxG.cameras.remove(game.camHUD, false);
        FlxG.cameras.remove(game.camOther, false);
        var camFake:FlxCamera = new FlxCamera();
        var camFakeTwo:FlxCamera = new FlxCamera();
        FlxG.cameras.add(camFake);
        FlxG.cameras.add(camFakeTwo);
        FlxG.cameras.add(game.camHUD, false);
        FlxG.cameras.add(game.camOther, false);
        camFake.visible = false;
        camFakeTwo.visible = false;
        setVar('camFake', camFake);
        setVar('camFakeTwo', camFakeTwo);
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("funnyShader2").shader)]);
    game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("funnyShader").shader)]);
    ]])
    setProperty('camFake.zoom', 0.01)
    setProperty('camFakeTwo.zoom', 0.01)
end

function onBeatHit(elapsed)
    if curBeat == 192 then
        triggerEvent("Camera Follow Pos", tostring(getProperty('boyfriend.x') + getProperty('boyfriend.frameWidth') / 2),
            tostring(getProperty('boyfriend.y') + getProperty('boyfriend.frameHeight') / 2))

        startTween('lmao', 'camFake', { zoom = -75 }, 4, { ease = 'expoOut' })
        startTween('lmao2', 'camFake', { angle = -150 }, 6, { ease = 'quartOut' })
    end
    if curBeat == 200 then
        triggerEvent("Camera Follow Pos", "", "")
    end
end

function onStepHit()
    if curStep == 796 then
        cancelTween('lmao2')
        cancelTween('lmao')
        startTween('lmao2', 'camFake', { angle = -300, zoom = 10 }, 0.5, { ease = 'cubeIn', onComplete = "ResetCam" })
    end
    if curStep == 888 or curStep == 890 then
        startTween('sex', 'camFake', { zoom = getProperty('camFake.zoom') - 10 }, stepCrochet / 1000 / playbackRate,
            { ease = 'backOut' })
    end
    if curStep == 892 or curStep == 894 then
        startTween('sex', 'camFake', { zoom = getProperty('camFake.zoom') + 10 }, stepCrochet / 1000 / playbackRate,
            { ease = 'backOut' })
    end
    if curStep == 1308 or curStep == 1310 then
        startTween('sex', 'camFake', { zoom = getProperty('camFake.zoom') + 2.5 }, stepCrochet / 1000 / playbackRate,
            { ease = 'backOut' })
    end
    if curStep == 1309 or curStep == 1311 then
        startTween('sex', 'camFake', { zoom = getProperty('camFake.zoom') - 10 }, stepCrochet / 1000 / playbackRate,
            { ease = 'cubeOut' })
    end
    if curStep == 1312 then
        startTween('sex', 'camFake', { zoom = 0.01 }, stepCrochet / 1000 / playbackRate, { ease = 'backOut' })
    end
    if curStep == 1630 then

    end
end

function ResetCam()
    for _, var in ipairs(vars) do
        setProperty('camFake.' .. var, 0.1)
        setProperty('camFakeTwo.' .. var, 0.1)
    end
end

function onUpdatePost()
    setShaderFloat('funnyShader2', 'x', getProperty('camFake.x'))
    setShaderFloat('funnyShader2', 'y', getProperty('camFake.y'))
    setShaderFloat('funnyShader2', 'zoom', getProperty('camFake.zoom'))
    setShaderFloat('funnyShader2', 'angle', getProperty('camFake.angle'))
    setShaderFloat('funnyShader', 'x', getProperty('camFakeTwo.x'))
    setShaderFloat('funnyShader', 'y', getProperty('camFakeTwo.y'))
    setShaderFloat('funnyShader', 'zoom', getProperty('camFakeTwo.zoom'))
    setShaderFloat('funnyShader', 'angle', getProperty('camFakeTwo.angle'))
end

function test()
    setProp2erty('camGame.pixelPerfectRender', true)
    setProp2erty('camHUD.pixelPerfectRender', true)
end

function lerp(from, to, i)
    if from == nil then
        return to
    end
    return from + (to - from) * i
end
