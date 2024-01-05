local targetHealth = 50
local customHealth = 50

local psi = 0

function onUpdatePost(elapsed)

    setHealth(10000*customHealth)

    if keyboardJustPressed('SPACE') and (psi > 19 )and ( targetHealth ~= 100 )then
        PSILifeUp()
    end
    
end


function onEvent(n, value1, value2)
	if n == 'LifeUp' then
		PSILifeUp()
	end
	if n == 'StarDrain' then
		Targethealth = SmoothHealth - 50
	end

	
end

function PSILifeUp()
    psi = psi - 20
    targetHealth = targetHealth + 50 
    

    if targetHealth > 100 then
        targetHealth = 100
    end

    debugPrint(targetHealth)
    playSound('heal-1', 0.5)
    cameraFlash('camHUD', 0x9000FF11, 0.75)
end
function onCreate()
    targetHealth = 50

psi = 0
    setProperty('camHUD.alpha',0)
end

function onStepHit ()
    if curStep == 93 then
        doTweenAlpha('cam', 'camHUD', 1, 0.25, 'sinIn')
    end


    if targetHealth > customHealth then
        customHealth = customHealth + 1
        debugPrint(customHealth)
    end

    if targetHealth < customHealth then
        customHealth = customHealth - 1
        debugPrint(customHealth)
    end
end

function goodNoteHit()
    psi = psi + 1
    if psi > 100 then
        psi = 100
    end

    debugPrint(psi)
end



function noteMiss()
    targetHealth = targetHealth - 10


    debugPrint(targetHealth)
end
