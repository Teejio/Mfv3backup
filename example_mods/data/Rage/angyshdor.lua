local shaderName = "retro"
function onCreate()
    shaderCoordFix() -- initialize a fix for textureCoord when resizing game window
    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";

        game.initLuaShader(shaderName);

        var shader0 = game.createRuntimeShader(shaderName);
        game.camGame.setFilters([new ShaderFilter(shader0)]);
        game.camHUD.setFilters([new ShaderFilter(shader0)]);
        game.camOther.setFilters([new ShaderFilter(shader0)]);
        game.getLuaObject("tempShader0").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
    ]])
end

function shaderCoordFix()
    runHaxeCode([[
        resetCamCache = function(?spr) {
            if (spr == null || spr.filters == null) return;
            spr.__cacheBitmap = null;
            spr.__cacheBitmapData3 = spr.__cacheBitmapData2 = spr.__cacheBitmapData = null;
            spr.__cacheBitmapColorTransform = null;
        }

        fixShaderCoordFix = function(?_) {
            resetCamCache(game.camGame.flashSprite);
            resetCamCache(game.camHUD.flashSprite);
            resetCamCache(game.camOther.flashSprite);
        }

        FlxG.signals.gameResized.add(fixShaderCoordFix);
        fixShaderCoordFix();
    ]])

    local temp = onDestroy
    function onDestroy()
        runHaxeCode([[
            FlxG.signals.gameResized.remove(fixShaderCoordFix);
        ]])
        temp()
    end
end

function onCreatePost()
    if shadersEnabled then
    luaDebugMode = false
    initLuaShader(shaderName)

    makeLuaSprite("shaderImage")
    makeGraphic("shaderImage", 1, 1)

    setSpriteShader("shaderImage", shaderName)

    addHaxeLibrary("ShaderFilter", "openfl.filters")
    runHaxeCode([[
    trace(ShaderFilter);
    game.camGame.setFilters([new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
    game.camOther.setFilters([new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
    game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
    ]])
    end
end
