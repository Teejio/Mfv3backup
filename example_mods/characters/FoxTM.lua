
function onCreatePost()
    makeAnimatedLuaSprite('fire', 'pkLIGHT', getProperty('dad.x')-425, getProperty('dad.y')-400)
    scaleObject('fire', 0.9,0.8)
    setBlendMode('fire', 'add')
    addAnimationByPrefix('fire', 'ooo', 'rgrrr instance 1', 24, true)
    addLuaSprite('fire', true)
    setProperty('fire.alpha', 0)
    addHaxeLibrary('ColorSwap', 'shaders')
    runHaxeCode([[
    var clorsap = new ColorSwap();
    setVar('clorsap', clorsap);
    game.getLuaObject('fire').shader = clorsap.shader; 
    clorsap.saturation = 0.2;
    clorsap.brightness = 3;
    ]])
end
function onSongStart()
    
end
function opponentNoteHit(a,s,f,g)
    if f == 'Alt Animation' and s == 2 then
        setProperty('fire.alpha', 0.75)
        doTweenAlpha('34', 'fire', 0, 0.25/playbackRate, 'sinInOut')
    end
end