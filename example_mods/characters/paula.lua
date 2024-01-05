--by Ferzy
local shit = {
    {-230,80, -0.05, 0.35},
    {-0, -0, 0,0},
    {0, 0, 0, 0},
    {375, 40, 0.5, 0.3}
}
function onCreatePost()
    dadthing = getProperty('dad.healthColorArray')
end
function onCreatePost()
    makeAnimatedLuaSprite('light0', 'pkLIGHT', getProperty('dad.x')-110, getProperty('dad.y')-210)
    makeAnimatedLuaSprite('light3', 'pkLIGHT', getProperty('dad.x')-110, getProperty('dad.y')-210)
    setBlendMode('light0', 'add')
    setBlendMode('light3', 'add')
    addAnimationByPrefix('light0', 'ooo', 'rgrrr instance 1', 24, true)
    addAnimationByPrefix('light3', 'ooo', 'rgrrr instance 1', 24, true)
    addLuaSprite('light0', true)
    addLuaSprite('light3', true)
    setProperty('light0.alpha', 0)
    setProperty('light3.alpha', 0)
    
    dadx, dady = getProperty('dad.x') , getProperty('dad.y')
    addHaxeLibrary('ColorSwap', 'shaders')
    runHaxeCode([[
    var clorsap0 = new ColorSwap();
    var clorsap3 = new ColorSwap();
    setVar('clorsap0', clorsap0);
    setVar('clorsap3', clorsap3);
    game.getLuaObject('light0').shader = clorsap0.shader; 
    game.getLuaObject('light3').shader = clorsap3.shader; 
    clorsap0.saturation = 0.5;
    clorsap0.brightness = 0.1;
    clorsap3.saturation = 0.3;
    clorsap3.brightness = 0.2;
    ]])
end
function opponentNoteHit(a,s,f,g)
    if s == 1 or s == 2 then
    doTweenAlpha('a0', 'light0', 0, 0.1/playbackRate, 'sinIn')
    doTweenAlpha('a3', 'light3', 0, 0.1/playbackRate, 'sinIn')
    end
    if s == 0 or s == 3 then
    if getPropertyFromGroup('notes', a, 'prevNote.animSuffix') ~= "-ender" then
        setProperty('light'..s..'.x',dadx + shit[s+1][1])
        setProperty('light'..s..'.y',dady + shit[s+1][2])
        setProperty('light'..s..'.alpha', 1 - s/10)
        doTweenAlpha('a'..s, 'light'..s, 0, 0.2/playbackRate, 'sinIn')
        setProperty('clorsap'..s..'.hue', shit[s+1][3])
        scaleObject('light'..s,shit[s+1][4], shit[s+1][4]*0.90)
    end
end
end