local indices = [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27,
        28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55,
        56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 72, 71, 70, 69, 68, 67, 66, 65, 64, 63,
        62, 61, 60, 59, 58, 57, 56, 55, 54, 53, 52, 51, 50, 49, 48, 47, 46, 45, 44, 43, 42, 41, 40, 39, 38, 37, 36, 35,
        34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6,
        5, 4, 3, 2, 1']]
--ferzy zoomie
local playerzoom = 1.2
local opponentzoom = 0.95
local zoomspeed = 0.8

function onCreate()
        precacheImage('stages/mrSaturn/shit')
        makeLuaSprite('grey', 'stages/mrSaturn/grey', -700, -750);
        makeAnimatedLuaSprite('ong', 'stages/mrSaturn/shit', -600, -650)
        addAnimationByIndicesLoop('ong', 'idle', 'idle', indices, 24)
        addLuaSprite('grey', false)
        makeLuaSprite('white', nil, 0, 0)
        makeGraphic('white', 1, 1, 'FFFFFF')
        scaleObject('white', screenWidth, screenHeight)
        setObjectCamera('white', 'camHUD')
        addLuaSprite('white', true)
        setProperty('white.alpha', 0)
        CreateHue()
end

function onCreatePost()
        scaleObject('grey', 2, 2);
        scaleObject('ong', 4, 4);
        fix = not getPropertyFromClass('ClientPrefs', 'fixmiddleScroll')
        if (not middlescroll or fix) then
                setPropertyFromGroup('opponentStrums', 0, 'x', defaultPlayerStrumX0 + 1)
                setPropertyFromGroup('opponentStrums', 1, 'x', defaultPlayerStrumX1 + 1)
                setPropertyFromGroup('opponentStrums', 2, 'x', defaultPlayerStrumX2 + 1)
                setPropertyFromGroup('opponentStrums', 3, 'x', defaultPlayerStrumX3 + 1)
                setPropertyFromGroup('playerStrums', 0, 'x', defaultOpponentStrumX0 + 1)
                setPropertyFromGroup('playerStrums', 1, 'x', defaultOpponentStrumX1 + 1)
                setPropertyFromGroup('playerStrums', 2, 'x', defaultOpponentStrumX2 + 1)
                setPropertyFromGroup('playerStrums', 3, 'x', defaultOpponentStrumX3 + 1)
                setPropertyFromGroup('playerStrums', 4, 'x', defaultOpponentStrumX4 + 1)
        end
end

function onUpdatePost()
        setProperty('healthBar.flipX', true)
        P1Mult = getProperty('healthBar.x') +
            ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26)

        P2Mult = getProperty('healthBar.x') +
            ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2)

        setProperty('iconP1.x', P1Mult - 110)

        setProperty('iconP1.origin.x', 240)

        setProperty('iconP1.flipX', true)

        setProperty('iconP2.x', P2Mult + 110)

        setProperty('iconP2.origin.x', -100)

        setProperty('iconP2.flipX', true)
        setProperty('clorsap.hue', getProperty('clorsap.hue') + 0.001)
end

function onSectionHit()
        zoom()
end

function zoom()
        if mustHitSection then
                targetZoom = playerzoom
        else
                targetZoom = opponentzoom
        end
        if oldtarget ~= targetZoom then
                doTweenZoom('zoom', 'camGame', targetZoom, zoomspeed, 'backInOut')
                oldtarget = targetZoom
        end
        setProperty('defaultCamZoom', targetZoom)
end

function onBeatHit()
        if curBeat == 320 then
                addLuaSprite('ong')
                cameraFlash('camOther', '0xFFFFBCDB', 1, true)
        end
        if curBeat == 384 then
                cameraFlash('camOther', '0xFFFFBCDB', 1, true)
                removeLuaSprite('ong', true)
        end
end

--Ferzy was here

function CreateHue()
        addHaxeLibrary('ColorSwap', 'shaders')
        runHaxeCode([[
        var clorsap = new ColorSwap();
        setVar('clorsap', clorsap);
        game.getLuaObject('ong').shader = clorsap.shader;
]])
end
