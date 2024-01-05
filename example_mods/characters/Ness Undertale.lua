--Ferzy nom nom

function onUpdatePost()
    if checkAnim('boyfriend', 'name', 'idle-alt') and getProperty('boyfriend.idleSuffix') == '-alt' then
        setProperty('boyfriend.idleSuffix', '')
        debugPrint('test')
        setProperty('boyfriend.specialAnim', true)
        runTimer('chom', (4 / 24) / playbackRate)
    end
end

function goodNoteHit()
    if not getProperty('darkOut') then
        if getProperty('healthy') <= 1.8 then
            setProperty('boyfriend.idleSuffix', '-alt')
        else
            setProperty('boyfriend.idleSuffix', '')
        end
    end
end

function checkAnim(char, type, other)
    local propValue = getProperty(char .. '.animation.curAnim.' .. type)

    if type == 'name' or type == 'curFrame' then
        return propValue == other
    elseif type == 'finished' then
        return propValue
    end
end

function onTimerCompleted(tag)
    if tag == 'chom' then
        if checkAnim('boyfriend', 'name', 'idle-alt') then
            callOnLuas('addHealthy', { 0.5 })
            playSound('mus_heal', 0.5)
            setProperty('scoreTxt.color', getColorFromHex('00FF00'))
            doTweenColor('lmao', 'scoreTxt', 'FFFFFF', 0.5, 'sinIn')
        end
    end
end
