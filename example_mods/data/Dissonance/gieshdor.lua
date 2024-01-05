local shaderName = "vcrshader"
function onCreate()
    makeLuaText('text', 'Video1', 0, 900, 0)
    setTextSize('text', 72)
    setTextFont('text', 'v5.ttf')
    addLuaText('text')
    setObjectCamera('text', 'other')
end

function onCreatePost()
    if shadersEnabled then
        luaDebugMode = false
        initLuaShader(shaderName)

        makeLuaSprite("shaderImage")
        makeGraphic("shaderImage", 1, 1)

        setSpriteShader("shaderImage", "vcrshader")
        runHaxeCode([[
    trace(ShaderFilter);
    game.camOther.width += 100;
    game.camOther.height += 100;
    game.camGame.setFilters([new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
    game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
    ]])
    end
end

function onUpdate(elapsed)
    setShaderFloat("shaderImage", "iTime", os.clock())
    setProperty('text.alpha', math.abs(math.sin(os.clock())))
end
