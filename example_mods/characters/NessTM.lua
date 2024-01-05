local shit = {
    {0,0},
    {-50, -90, 0.5,0.29},
    {-80, -210, 0, 0.37},
    {-325, -210, 0.2, 0.45}
}
function onCreatePost()
    boyfriendthing = getProperty('boyfriend.healthColorArray')
end
function onCreatePost()
    makeAnimatedLuaSprite('light', 'pkLIGHT', getProperty('boyfriend.x')-110, getProperty('boyfriend.y')-210)
    scaleObject('light', 0.35,0.32)
    setBlendMode('light', 'add')
    addAnimationByPrefix('light', 'ooo', 'rgrrr instance 1', 24, true)
    addLuaSprite('light', true)
    setProperty('light.alpha', 0)
    bfx, bfy = getProperty('boyfriend.x'), getProperty('boyfriend.y')
    addHaxeLibrary('ColorSwap', 'shaders')
    runHaxeCode([[
    var clorsap = new ColorSwap();
    setVar('clorsap', clorsap);
    game.getLuaObject('light').shader = clorsap.shader; 
    clorsap.saturation = 0.75;
    clorsap.brightness = 0.2;
    ]])
end
function goodNoteHit(a,s,f,g)
    if f == 'Alt Animation' then
        setProperty('light.x',bfx + shit[s+1][1])
        setProperty('light.y',bfy + shit[s+1][2])
        setProperty('light.alpha', 1)
        doTweenAlpha('a', 'light', 0, 0.25/playbackRate, 'sinIn')
        setProperty('clorsap.hue', shit[s+1][3])
        scaleObject('light',shit[s+1][4], shit[s+1][4]*0.90)
    end
end