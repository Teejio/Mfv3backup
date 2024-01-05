function onCreate()
    addLuaScript('custom_events/pklifeup2')
    setProperty('speedie', 0.75)
end
function onStepHit()
    if curStep == 94 then
        setProperty('healthy', 0.03)
    end
    
end
function onUpdatePost()
    if keyboardJustPressed('SPACE') then
        triggerEvent('pklifeup2', '', '')
        triggerEvent('PSI health', '', '')
    end
    
end