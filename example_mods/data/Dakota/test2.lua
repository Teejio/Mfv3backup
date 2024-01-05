

function opponentNoteHit(a, s, f, g)
    if not g then 
    if s == 0 then
        setProperty('opponentStrums.members['..s..'].scale.x', getProperty('opponentStrums.members['..s..'].scale.x')*2)
        setProperty('opponentStrums.members['..s..'].scale.y', getProperty('opponentStrums.members['..s..'].scale.y')*0.75)
    elseif s == 1 then
        setProperty('opponentStrums.members['..s..'].scale.x', getProperty('opponentStrums.members['..s..'].scale.x')*0.75)
        setProperty('opponentStrums.members['..s..'].scale.y', getProperty('opponentStrums.members['..s..'].scale.y')*2)
    elseif s == 2 then
        setProperty('opponentStrums.members['..s..'].scale.x', getProperty('opponentStrums.members['..s..'].scale.x')*0.75)
        setProperty('opponentStrums.members['..s..'].scale.y', getProperty('opponentStrums.members['..s..'].scale.y')*2)
    elseif s == 3 then
        setProperty('opponentStrums.members['..s..'].scale.x', getProperty('opponentStrums.members['..s..'].scale.x')*2)
        setProperty('opponentStrums.members['..s..'].scale.y', getProperty('opponentStrums.members['..s..'].scale.y')*0.75)
    end
    doTweenX('notesX' .. s, 'opponentStrums.members[' .. s .. '].scale', 0.7, 0.5 / playbackRate, 'backOut')
    doTweenY('notesY' .. s, 'opponentStrums.members[' .. s .. '].scale', 0.7, 0.5 / playbackRate, 'backOut')
end
end