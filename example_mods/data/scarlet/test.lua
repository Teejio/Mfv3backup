--intro by Ferzy
local hud = { "iconP1", "iconP2", "healthBar", 'healthBarBG', 'timeBarBG', 'timeBar', 'scoreTxt', 'timeTxt' }
function onCreatePost()
    makeLuaSprite('black', nil, 0, 0)
    makeGraphic('black', 1, 1, '000000')
    scaleObject('black', screenWidth, screenHeight)
    setObjectCamera('black', 'camHUD')
    for _, a in ipairs(getProperty('bgs')) do
        setProperty(a .. '.y', getProperty(a .. '.y') + 1400)
    end
    setProperty('dad.y', getProperty('dad.y') + 1400)
    setProperty('boyfriend.y', getProperty('boyfriend.y') + 1400)
    makeLuaSprite('night', nil, 0, 0)
    setObjectCamera('night', 'camHUD')
    makeGraphic('night', 1, 1, 'FFFFFF')
    scaleObject('black', screenWidth, screenHeight)
    setProperty('night.color', getColorFromHex('0000BB'))
    setProperty('night.alpha', 0.5)
    setBlendMode('night', 'multiply')
    addLuaSprite('night')
    makeLuaSprite('sun', 'sun', 0, 700)
    screenCenter('sun', 'x')
    setScrollFactor('sun', 0, 0)
    setObjectCamera('sun', 'camHUD')
    addLuaSprite('sun')
    addLuaSprite('black')
    setProperty('sun.color', getColorFromHex('FF5A44'))
    for i = 0, 7 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
    end
    for _, var in ipairs(hud) do
        setProperty(var .. '.alpha', 0)
    end
end

function onStartCountdown()
    setProperty('skipArrowStartTween', true)
end

function onSongStart()
    doTweenAlpha('as2', 'black', 0, 2.5, 'quartOut')
    doTweenY('as4', 'sun', -700, (crochet / 1000) * 48, 'quadIn')
    doTweenColor('as', 'night', '0xFFFE844C', (crochet / 1000) * 16)
    doTweenColor('as3', 'sun', 'FFAA49', (crochet / 1000) * 16)
    setProperty('cameraSpeed', 0)
    setProperty('timeBarBG.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)
end

function onBeatHit()
    if curBeat == 20 then
        doTweenColor('as', 'night', 'FFFFFF', (crochet / 1000) * 48)
        doTweenColor('as3', 'sun', 'FFFFFF', (crochet / 1000) * 40)
    end
    if curBeat == 38 then
        move()
    end
    if curBeat == 64 then
        setProperty('cameraSpeed', 1.25)
        for _, var in ipairs(hud) do
            setProperty(var .. '.alpha', 0)
            setProperty(var .. '.visible', true)
        end
        for _, var in ipairs(hud) do
            doTweenAlpha(var, var, 1, (crochet / 1000) * 4, { ease = 'sinOut' })
        end
        for i = 0, 7 do
            noteTweenAlpha('Note' .. i, i, 1, (crochet / 1000) * 4, { ease = 'sinOut' })
        end
    end
end

function move()
    for _, a in ipairs(getProperty('bgs')) do
        startTween(getRandomInt(0, 200), a, { y = getProperty(a .. '.y') - 1400 }, (crochet / 1000) * 32,
            { ease = 'quartOut' })
    end
    startTween('dad', 'dad', { y = getProperty('dad.y') - 1400 }, (crochet / 1000) * 32, { ease = 'quartOut' })
    startTween('boyfriend', 'boyfriend', { y = getProperty('boyfriend.y') - 1400 }, (crochet / 1000) * 32,
        { ease = 'quartOut' })
end
