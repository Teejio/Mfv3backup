--script by sirFerzy
local animArray = { 'LEFT', 'DOWN', 'UP', 'RIGHT' }
local beats = { 384, 416, 448, 480 }
local strength = 0.4
function onCreate()
    precacheImage('characters/LucasDistressed')
end

function onCreatePost()
    for i = 1, 2 do
        makeLuaSprite('sademote' .. i, 'warforged/sademote'..i, 0, 0)
        addLuaSprite('sademote' .. i, true)
        setObjectCamera('sademote' .. i, 'hud')
        setProperty('sademote' .. i .. '.alpha', 0)
    end
end

function makeLucas()
    makeAnimatedLuaSprite('SadLucas', 'characters/LucasFB', 45, 100)
    addAnimationByPrefix('SadLucas', 'idle', 'IDLE', 24, false)
    for i = 1, 4 do
        addAnimationByPrefix('SadLucas', getProperty('singAnimations')[i], animArray[i], 14, false)
    end
    setObjectCamera('SadLucas', 'hud')
    addLuaSprite('SadLucas', false)
    setObjectOrder('SadLucas', 'sademote2'+1)
end

function onBeatHit()
    for _, beat in ipairs(beats) do
        if curBeat == beat then
            if not lowQuality then
                setProperty('sademote1.alpha', strength)
                doTweenAlpha('flash', 'sademote1', 0, 0.15 + strength / 2.5, 'sinOut')
                setProperty('bloom', 0.15 + strength / 10)
                setProperty('force', getProperty('force') + strength)
                strength = strength + 0.25
            else
                setProperty('sademote1.alpha', 0.9)
                doTweenAlpha('flash', 'sademote1', 0, 0.1 + strength / 2, 'sinOut')
            end
            for i = 0, math.floor(10 * strength) do
                callOnLuas('makeSquare',
                    { getRandomFloat(-screenWidth * 0.9, screenWidth * 1.45), getRandomFloat(200, 600) })
            end
            callOnLuas('thrust')
        end
    end
    if curBeat == 520 then
        setProperty('sademote1.alpha', 1)
        setObjectOrder('sademote1', 0)
        setObjectOrder('sademote2', 1)
        makeLucas()
        playAnim('SadLucas', 'singLEFT')
    end
    if curBeat == 552 then
        doTweenAlpha('sadEmote2', 'sademote2', 1, 0.5, 'sinOut')
    end
    if curBeat == 584 then
        removeLuaSprite('SadLucas', true)
        removeLuaSprite('sademote1', true)
        removeLuaSprite('sademote2', true)
    end
    if curBeat % 2 == 0 and getProperty('SadLucas.animation.curAnim.finished') then
        playAnim('SadLucas', 'idle', true)
    end
end

function goodNoteHit(a, s, d, f)
    if not f then
        playAnim('SadLucas', getProperty('singAnimations')[s + 1], true)
    end
end

function onUpdatePost()
    if curBeat >= 520 and curBeat <= 584 then
        for i = 0, 3 do
            setProperty('playerStrums.members[' .. i .. '].y',
                defaultPlayerStrumY0 + 10 * math.cos(getSongPosition() / 350 + (i + 1) * 100))
        end
    end
end
