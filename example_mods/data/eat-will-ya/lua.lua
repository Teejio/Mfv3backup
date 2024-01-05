function onCreate()
    setVar('darkOut', false)
    makeLuaSprite('light', 'falsh', 0, 0)
    setBlendMode('light', 'subtract')
    setObjectCamera('light', 'camHUD')
    setProperty('light.alpha', 0.95)
    setProperty('light.origin.x', getProperty('light.width') / 2)
    setProperty('light.origin.y', getProperty('light.height') / 2)
    debugPrint(screenWidth .. screenHeight)
end
function onCreatePost()
    makeLuaSprite('nessH', 'heart', 0,0)
    setProperty('nessH.x', getProperty('boyfriend.x') + (getProperty('boyfriend.width') / 2))
    setProperty('nessH.y', 400)
    setProperty('nessH.origin.x', 37.5)
    setProperty('nessH.origin.y', 37.5)

    makeLuaSprite('friskH', 'heart', 0,0)
    setProperty('friskH.x', getProperty('frisk.x') + (getProperty('frisk.width') / 2))
    setProperty('friskH.y', 650)
    setProperty('friskH.origin.x', 37.5)
    setProperty('friskH.origin.y', 37.5)
end
function onBeatHit()
    if curBeat == 128 then
        for i = 0, getProperty('unspawnNotes.length') - 1 do
            setPropertyFromGroup('unspawnNotes', i, 'copyAlpha',  false)
            setPropertyFromGroup('unspawnNotes', i, 'alpha', getPropertyFromGroup('unspawnNotes', i, 'alpha')*0.5)
        end
        playAnim('dad', 'flicker', true)
        setProperty('dad.idleSuffix', '-alt')
    end
    if curBeat % 2 == 0 then
        setProperty('friskH.scale.x', 1.2)
        setProperty('friskH.scale.y', 1.2)
        startTween('beat2', 'friskH.scale', {x = 1, y = 1}, crochet/2000/playbackRate, {ease = 'sinIn'})
    end
    setProperty('nessH.scale.x', 1.2)
    setProperty('nessH.scale.y', 1.2)
    startTween('beat', 'nessH.scale', {x = 1, y = 1}, crochet/2000/playbackRate, {ease = 'sinIn'})
end

function onUpdate(elapsed)
    if curStep >= 513 and curStep < 515 then
        setProperty('camGame.alpha', getRandomFloat(-0.3, 1))
        setProperty('camHUD.alpha', getRandomFloat(0.3, 1))
    end
    setProperty('light.scale.x', 1.5 + 0.15 * math.sin(getSongPosition() / 750))
    setProperty('light.scale.y', 1.5 + 0.15 * math.cos(getSongPosition() / 750))
    setProperty('nessH.y', 425 + 10 * math.cos(getSongPosition() / 500))
    setProperty('friskH.y', 660 + 10 * math.cos(getSongPosition() / 500))
end

function onStepHit()
    if curStep == 515 then
        for i = 0, getProperty('notes.length') - 1 do
            setPropertyFromGroup('notes', i, 'copyAlpha',  false)
            setPropertyFromGroup('notes', i, 'alpha', getPropertyFromGroup('notes', i, 'alpha')*0.5)
        end
        startTween('frisk', 'frisk.colorTransform', {blueOffset = -255, greenOffset = -255, redOffset = 255, redMultiplier = -2}, 0.5, {ease = 'linear'})
        startTween('bf', 'boyfriend.colorTransform', {blueOffset = -255, greenOffset = -255, redOffset = 255, redMultiplier = -2}, 0.5, {ease = 'linear'})
        addLuaSprite('friskH', true)
        addLuaSprite('nessH', true)
        setProperty('frisksap.saturation', -1)
        setProperty('camGame.visible', false)
        setProperty('camHUD.alpha', 0.8)
        doTweenAlpha('alpha', 'camHUD', 0.1, 0.6, 'cubeOut')
        setVar('darkOut', true)
    end
    if curStep == 540 then
        setProperty('drainMult', 3)
        addLuaSprite('light')
        setProperty('camGame.visible', true)
        setProperty('camGame.alpha', 1)
        setProperty('camHUD.alpha', 0.9)
    end
    if curStep == 668 then
        setProperty('dad.idleSuffix', '')
        setProperty('drainMult', 1)

        startTween('frisk', 'frisk.colorTransform', {blueOffset = 0, greenOffset = 0, redOffset = 0, redMultiplier = 1}, 0.01, {ease = 'linear'})
        startTween('bf', 'boyfriend.colorTransform', {blueOffset = 0, greenOffset = 0, redOffset = 0, redMultiplier = 1}, 0.01, {ease = 'linear'})
        doTweenAlpha('alpha1', 'nessH', 0,0.15) doTweenAlpha('alpha2', 'friskH', 0,0.15)
        setProperty('frisksap.brightness', 0)
        setProperty('frisksap.saturation', 0)
        playAnim('dad', 'funny', true)
        removeLuaSprite('light', true)
        setVar('darkOut', false)

        setProperty('camHUD.alpha', 1)
        for i = 0, getProperty('notes.length') - 1 do
            setPropertyFromGroup('notes', i, 'copyAlpha',  true)
        end
        for i = 0, getProperty('unspawnNotes.length') - 1 do
            setPropertyFromGroup('unspawnNotes', i, 'copyAlpha',  true)
        end
        for i = 0, getProperty('notes.length') - 1 do
            if getPropertyFromGroup('notes', i, 'noteType') == 'lmao' then
                setProperty('notes.members[' .. i .. '].ignoreNote', true)
                setProperty('notes.members[' .. i .. '].tooLate', true)
                setProperty('notes.members[' .. i .. '].visible', false)
            end
        end
    end
end
