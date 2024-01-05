
function onCreatePost()
    luaDebugMode = false

    --lucas
    makeLuaSprite('textBox1', 'diaText', 100, -30)
    scaleObject('textBox1', 0.65, 0.65)
    setProperty('textBox1.antialiasing', false)
    makeLuaText('text1', '', 0, 140, -10)
    setTextFont('text1', 'orange kid.ttf')
    setObjectCamera('text1', 'camGame')
    setTextColor('text1', '0x000000')
    setTextBorder('text1', 'OxFFFFFF')
    setProperty('text1.scrollFactor.x', 1)
    setProperty('text1.scrollFactor.y', 1)
    setTextSize('text1', 60)
    setProperty('textBox1.alpha', 0)
    setProperty('text1.alpha', 0)
    --claus

    makeLuaSprite('textBox2', 'diaText', 300, 650)
    scaleObject('textBox2', 1, 1)
    setProperty('textBox2.antialiasing', false)
    makeLuaText('text2', 'ewewoe', 0, 375, 670)
    setTextFont('text2', 'orange kid.ttf')
    setTextColor('text2', '0x000000')
    setTextBorder('text2', '0xFFFFFF')

    setObjectCamera('text2', 'camGame')
    setProperty('text2.scrollFactor.x', 1)
    setProperty('text2.scrollFactor.y', 1)

    setTextSize('text2', 80)
    setObjectOrder('dadGroup', getObjectOrder('dadGroup') + 2)
    setObjectOrder('boyfriendGroup', getObjectOrder('boyfriendGroup') - 0.5)

end

function onCountdownTick(counter)
    if counter == 2 and songPath == 'warforged' then
        local text = 'Kumatora, Duster and Boney collapsed. \nLucas remained standing.'
        setTextAlignment('text1', 'left')
        doTweenX('textMove1', 'text1', 90, 0.2 / playbackRate, 'sinIn')
        doTweenX('textMoveBox1', 'textBox1', 50, 0.2 / playbackRate, 'sinIn')
        doTweenAlpha('Text1', 'text1', 1, 0.25 / playbackRate, 'sinIn')
        doTweenAlpha('TextBox1', 'textBox1', 1, 0.25 / playbackRate, 'sinIn')
        addLuaText('text1')
        addLuaSprite('textBox1')
        text1 = text:gsub("/n", "\n")
        textNum1 = - #text1
        setTextString('text1', '')
        runTimer('type1', 0.04 / playbackRate, #text1)
        runTimer('removeSprite1', (0.8  + (#text1 * 0.075)) / playbackRate)
    end
end

function onEvent(n, a, d)
    if n == 'warChat' then
        if a == 'lucas' then
            doLucas(d)
        end
        if a == 'him' then
            doHim(d)
        end
    end
end

function doLucas(text)
    doTweenX('textMove1', 'text1', 90, 0.2, 'sinIn')
    doTweenX('textMoveBox1', 'textBox1', 50, 0.2, 'sinIn')
    doTweenAlpha('Text1', 'text1', 1, 0.25 / playbackRate, 'sinIn')
    doTweenAlpha('TextBox1', 'textBox1', 1, 0.25 / playbackRate, 'sinIn')
    addLuaText('text1')
    addLuaSprite('textBox1')
    text1 = ' ' .. text:gsub("/n", "\n")
    if difficultyName  == 'pussy' then
        text1 = text1:gsub("scared", "worried")
        text1 = text1:gsub("wounded", "confused")
        text1 = text1:gsub("losing", "losing?")
        text1 = text1:gsub("mortally", "utterly")
    end
    textNum1 = - #text1
    setTextString('text1', '')
    runTimer('type1', 0.06 / playbackRate, #text1)
    runTimer('removeSprite1', (0.7 + (#text1 * 0.075))/ playbackRate)
end 

function doHim(text)
    setProperty('text2.alpha', 1)
    setProperty('textBox2.alpha', 1)
    setObjectOrder('textBox2', getObjectOrder('dadGroup') - 0.5)
    setObjectOrder('text2', getObjectOrder('dadGroup'))
    addLuaSprite('textBox2')
    addLuaText('text2')
    setTextString('text2', '')
    text2 = ' ' .. text:gsub("/n", "\n")
    if difficultyName  == 'pussy' then
        text2 = text2 .. '\n But it failed!   '
    end
    setTextAlignment('text2', 'left')
    
    textNum2 = - #text2
    runTimer('type2', 0.035 / playbackRate, #text2)
    runTimer('removeSprite2', (0.8 + (#text2 * 0.02))/ playbackRate)

end

function onTimerCompleted(tag)
    if tag == 'removeSprite1' then
        doTweenAlpha('Text1', 'text1', 0, 0.20 / playbackRate, 'cubeIn')
        doTweenAlpha('TextBox1', 'textBox1', 0, 0.20 / playbackRate, 'cubeIn')
        doTweenX('textMove1', 'text1', 40, 0.20 / playbackRate, 'cubeIn')
        doTweenX('textMoveBox1', 'textBox1', 0, 0.20 / playbackRate, 'cubeIn')
        runTimer('removeFr1', 0.25 / playbackRate)
    end
    if tag == 'removeFr1' then
        removeLuaSprite('textBox1', false)
        removeLuaText('text1', false)
        setProperty('textBox1.x', 100)
        setProperty('text1.x', 140)
    end
    if tag == 'type2' then
        setTextString('text2', text2:sub(1, textNum2))
        textNum2 = textNum2 + 1
    end
    if tag == 'type1' then
        setTextString('text1', text1:sub(1, textNum1))
        textNum1 = textNum1 + 1
    end
    if tag == 'removeSprite2' then
        doTweenAlpha('Text2', 'text2', 0, 0.15 / playbackRate, 'cubeIn')
        doTweenAlpha('TextBox2', 'textBox2', 0, 0.15 / playbackRate, 'cubeIn')
        runTimer('removeFr2', 0.2 / playbackRate)
    end
    if tag == 'removeFr2' then
        removeLuaSprite('textBox2', false)
        removeLuaText('text2', false)
    end
end
