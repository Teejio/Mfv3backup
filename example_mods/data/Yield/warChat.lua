
function onCreatePost()
    luaDebugMode = true

    --lucas
    makeLuaSprite('textBox1', 'minty', 200, 210)
    scaleObject('textBox1', 0.95, 0.9)
    setProperty('textBox1.antialiasing', false)
    makeLuaText('text1', '', 0, 235, 230)
    setTextFont('text1', 'orange kid.ttf')
    setObjectCamera('textBox1', 'camGame')
    setObjectCamera('text1', 'camGame')
    setTextColor('text1', '0xe8e6b2')
    setTextBorder('text1', '0xD6DC15')
    runHaxeCode([[
        game.getLuaObject('text1').scrollFactor.set(1,1);
        ]])
    setTextSize('text1', 45)
    setProperty('textBox1.alpha', 0)
    setProperty('text1.alpha', 0)

    --claus




end

function onCountdownTick(counter)
    if counter == 3 then
        local text = '•Press space to use PSI Life-Up!        \n•It costs 20PP.'
        setTextAlignment('text1', 'left')
        doTweenAlpha('Text1', 'text1', 1, 0.25, 'sinIn')
        doTweenAlpha('TextBox1', 'textBox1', 1, 0.25, 'sinIn')
        addLuaSprite('textBox1', true)
        addLuaText('text1', true)
        text1 = text:gsub("/n", "\n")
        textNum1 = - #text1
        setTextString('text1', '')
        runTimer('type1', 0.05, #text1)
        runTimer('removeSprite1', 0.08 + (#text1 * 0.075))
    end
end

function onEvent(n, a, d)
    if n == 'PSI health' then
        doLucas('•Ness uses PSI Life Up!    \n•Recovered lost HP.')
    end
end

function doLucas(text)
    setProperty('textBox1.x',200, 210)
    setProperty('textBox1.y',210)
    setProperty('text1.x',235)
    setProperty('text1.y',230)

    setTextAlignment('text1', 'left')
    doTweenAlpha('Text1', 'text1', 1, 0.15, 'sinIn')
    doTweenAlpha('TextBox1', 'textBox1', 1, 0.15, 'sinIn')
    addLuaSprite('textBox1')
    addLuaText('text1')
    text1 = text:gsub("/n", "\n")
    textNum1 = - #text1
    setTextString('text1', '')
    runTimer('type1', 0.03, #text1)
    runTimer('removeSprite1', 0.07 + (#text1 * 0.045))
end 



function onTimerCompleted(tag)
    if tag == 'removeSprite1' then
        doTweenAlpha('Text1', 'text1', 0, 0.20, 'cubeIn')
        doTweenAlpha('TextBox1', 'textBox1', 0, 0.20, 'cubeIn')
        runTimer('removeFr1', 0.25)
    end
    if tag == 'removeFr1' then
        removeLuaSprite('textBox1', false)
        removeLuaText('text1', false)
        setProperty('textBox1.x', 100)
        setProperty('text1.x', 140)
    end
    if tag == 'type1' then
        setTextString('text1', text1:sub(1, textNum1))
        textNum1 = textNum1 + 1
    end
end
