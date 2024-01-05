


function goodNoteHit(a, s, d, f)
    if boyfriendName == 'WFlucassbutSad' then
        if not f then
            shaky = 11
        end
        if f then
            shaky = 7
        end
    end
end
function onEvent(a)
    if a == 'Change Character' then
        lucasX = getProperty('boyfriend.x')
        runTimer('loop', 0.01, 100000)
    end
end

function onTimerCompleted(tag)
    if tag == 'loop' then
        if shaky > 0.1 then
            shaky = shaky - 0.2
            setProperty('boyfriend.x', lucasX + getRandomFloat(-shaky, shaky))
        end
    end
end

function onStepHit()
    if boyfriendName == 'WFlucassbutSad' then
        if getProperty('boyfriend.animation.curAnim.name') == 'idle' and getProperty('boyfriend.animation.curAnim.curFrame') < 3 then
            shaky = 9
        end
    end
end
