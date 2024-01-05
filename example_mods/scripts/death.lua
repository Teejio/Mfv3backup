songList = { 'Rockin', "Encore", "Dissonance", "Angeles", "Angeles-smash" }
picoList = { "Angeles", "Angeles-smash" }
function onGameOver()
    if songPath ~= 'eat-will-ya' then
        if (has_value(songList, songName)) then
            if songPath ~= 'fire-at-will' then
                if songPath ~= 'rtc' then
                else
                    playSound("rtc")
                end
                restartSong()
                playSound('die', 0.7)
                return Function_Stop
            end
        else
            setProperty('camGame.scroll.y', 'camFollow.y')
            setProperty('camGame.scoll.x', 'camFollow.x')
        end
    end
end

function onCreatePost()
    if (has_value(picoList, songName)) then
        addCharacterToList('bf-dead')
        setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-dead')
    else
        addCharacterToList('pico-dead')

        setPropertyFromClass('GameOverSubstate', 'characterName', 'pico-dead')
    end
end

function has_value(tab, val)
    for i = 1, table.getn(tab), 1 do
        if tab[i] == val then
            return false
        end
    end

    return true
end
