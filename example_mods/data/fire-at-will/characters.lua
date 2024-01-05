--Ferzy
local lucasOn = false
function onBeatHit()
    if curBeat % 2 == 0 then
        if getProperty('wolf.animation.curAnim.finished') then
            haxidle('wolf')
        end
        if getProperty('lucas.animation.curAnim.finished') then
            haxidle('lucas')
        end
    end
    if curBeat == 199 then
        playAnim('dad', 'sleepy', true)
    end
    if curBeat == 324 then
        callOnLuas('customLoad', { 'dad', 'hotwolf' })
        callOnLuas('customLoad', { 'bf', 'lucas' })
    end
    if curBeat == 368 then
        for i = 0, getProperty('unspawnNotes.length') do
            setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
        end
        for i = 0, getProperty('notes.length') do
            setPropertyFromGroup('notes', i, 'noAnimation', true)
        end
        callMethod('iconP2.changeIcon', { 'Wolf' })
        setHealthBarColors("7828FF", rgbToHex(getProperty('boyfriend.healthColorArray')))
        lucasOn = true
    end
    if curBeat == 382 then
        callMethod('iconP1.changeIcon', { 'LucasTM' })

        setHealthBarColors("7828FF", "F0C800")
    end
end

function goodNoteHit(a, s, d, f)
    if lucasOn then
        local anim = getProperty('singAnimations')[s + 1]
        callMethod('lucas.playAnim', { anim, true })
    end
end

function opponentNoteHit(a, s, d, f)
    if lucasOn then
        local anim = getProperty('singAnimations')[s + 1]
        callMethod('wolf.playAnim', { anim, true })
        setProperty('wolf.holdTimer', 0)
    end
end

function onSongStart()
    haxidle('lucas')
    haxidle('wolf')
end

function onCountdownTick(fag)
    if fag == 2 then
        haxidle('lucas')
        haxidle('wolf')
    end
end

function haxidle(char)
    callMethod(char .. '.dance')
end

function rgbToHex(rgb)
    return string.format("%02x%02x%02x", math.floor(rgb[1]), math.floor(rgb[2]), math.floor(rgb[3]))
end
