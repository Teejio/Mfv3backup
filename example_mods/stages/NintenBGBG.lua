stagefilelocation = 'Ninten'
time = 1
local dadx,dady,bfx,bfy
function hideHUD()
        setProperty("healthBarBG.alpha", 0);
        setProperty("healthBar.alpha", 0);

        setProperty("timeBarBG.alpha", 0);
        setProperty("timeBar.alpha", 0);

        setProperty("timeBarBG.visible", false);
        setProperty("timeBar.visible", false);
        setProperty("timeTxt.visible", false);

        setProperty("scoreTxt.alpha", 0);
        setProperty("timeTxt.alpha", 0);

        setProperty("iconP1.alpha", 0);
        setProperty("iconP2.alpha", 0);
end

function onCreate()
        createSprite('ninbg', 'ninbg', -700, -400, 1.8, 1.8, 1, 1, false)
        addLuaSprite('ninbg')
        makeLuaSprite('ourple', 'overlay/ourple', 0, 0);
        addLuaSprite('ourple', true);
        scaleObject('ourple', .75, .75);
        setObjectCamera('ourple', 'other')
        setProperty('ourple.alpha', 0.25);
end

function onCreatePost()
        -- end of "create"
        dadx,dady,bfx,bfy = getProperty('dad.x'), getProperty('dad.y'), getProperty('boyfriend.x'), getProperty('boyfriend.y')
        hideHUD();
        createSprite('sky', 'sky', -600, -300, 1.6, 1.6, 0.1, 0.1, false)
        createSprite('newbg', 'newninbg', -600, -300, 1.6, 1.6, .451, .451, false)
        createSprite('floorb', 'ground', -600, -500, 1.8, 1.8, 1, 1, false)
end

function createSprite(name, file, x, y, scaleX, scaleY, scrollX, scrollY, infront)
        makeLuaSprite(name, 'stages/' .. stagefilelocation .. '/' .. file, x, y);
        setScrollFactor(name, scrollX, scrollY);
        scaleObject(name, scaleX, scaleY);
end

function onCountdownTick(counter)
        -- counter = 0 -> "Three"
        -- counter = 1 -> "Two"
        -- counter = 2 -> "One"
        -- counter = 3 -> "Go!"
        -- counter = 4 -> Nothing happens lol, tho it is triggered at the same time as onSongStart i think
        if counter == 0 then
                hideHUD();
        end
end

function setXY(person, X, Y)
        if person == 'Bf' then
                setProperty('boyfriend.x', X)
                setProperty('boyfriend.y', Y)
        else
                setProperty('dad.x', X)
                setProperty('dad.y', Y)
        end
end

function introduce()
        doTweenAlpha('iconP2', 'iconP2', 1, time, 'linear')
        doTweenAlpha('iconP1', 'iconP1', 1, time, 'linear')

        doTweenAlpha('healthBar', 'healthBar', 1, time, 'linear')
        doTweenAlpha('healthBarBG', 'healthBarBG', 1, time, 'linear')

        doTweenAlpha('timeBar', 'timeBar', 1, time, 'linear')
        doTweenAlpha('timeBarBG', 'timeBarBG', 1, time, 'linear')

        doTweenAlpha('scoreTxt', 'scoreTxt', 1, time, 'linear')
        doTweenAlpha('timeTxt', 'timeTxt', 1, time, 'linear')

        setProperty("timeBarBG.visible", true);
        setProperty("timeBar.visible", true);
        setProperty("timeTxt.visible", true);
end

function onStepHit()
        if songName == 'Encore' then --to make sure...
                if curStep >= 66 then
                        introduce();
                end
        end


        --Ferzy was here
        --Magicant part
        if curStep == 1024 then
                addLuaSprite('sky')
                addLuaSprite('newbg')
                addLuaSprite('floorb')
                setXY('Bf', 1100, 300)
                setXY('dad', 150, 40)
                cameraFlash('hud', '0xFFC7F7', 1, true)
                callOnLuas('customLoad', { 'dad', 'ninten-Dream' })
                callOnLuas('customLoad', { 'bf', 'bf-Dream' })
        end

        --End of da part =(
        if curStep == 1280 then
                cameraSetTarget('dad')
                removeLuaSprite('sky', false)
                removeLuaSprite('newbg', false)
                removeLuaSprite('floorb', false)
                cameraFlash('hud', '0xFFC7F7', 0.75, true)
                setXY('Bf', bfx, bfy)
                setXY('dad', dadx, dady)
                callOnLuas('customLoad', { 'dad', 'ninten' })
                callOnLuas('customLoad', { 'bf', 'bf' })
        end

        if curStep == 1630 then
                cameraFlash('camOther', 'FFF8FE', 1, true)
                setProperty('camHUD.alpha', 0)
        end
        -- close(true);
end

function onBeatHit()
        if curBeat == 192 then
                callOnLuas('customLoad', { 'bf', 'noColor' })
        end
        if curBeat == 200 then
                callOnLuas('customLoad', { 'bf', 'bf' })
        end
end
