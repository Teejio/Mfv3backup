speed = 1
HUDspeed = 1
luaDebugMode = true
local chose = false

function onCustomSubstateUpdate()
	if keyboardJustPressed('SPACE') then
		closeCustomSubstate()
	end
end

function onCreatePost()
	setVar('testal', 0)
	addLuaScript("custom_events/zCameraFix")
	if not middlescroll then
		for i = 0, 3 do
			_G['defaultPlayerStrumX' .. i] = _G['defaultOpponentStrumX' .. i]
			_G['defaultPlayerStrumY	' .. i] = _G['defaultOpponentStrumY' .. i]
		end
	end
	dadX = getProperty('dad.x')
end

function onSongStart()
	startTween('lmao', '', { testal = 40 }, 10, { ease = 'linear' })
end

movetoggled = true
notetoggled = false
noteoffset = 6
shake = 0
scared = false

function onUpdate()
	if movetoggled then
		doTweenX('camGameX', 'camGame', 0 + 20 * math.sin(getSongPosition() / (500 / HUDspeed)), 0.5, 'linear')
		doTweenY('camGameY', 'camGame', 0 + 30 * math.sin(getSongPosition() / (750 / HUDspeed)), 0.5, 'linear')
		doTweenAngle('camGameAngle', 'camGame', 0 + 2 * math.sin(getSongPosition() / (1000 / HUDspeed)), 0.5, 'linear')
		doTweenX('camHUDX', 'camHUD', 0 + 10 * math.sin(getSongPosition() / (500 / HUDspeed)), 0.5, 'linear')
		doTweenY('camHUDY', 'camHUD', 0 + 15 * math.sin(getSongPosition() / (750 / HUDspeed)), 0.5, 'linear')
		doTweenAngle('camHUDAngle', 'camHUD', 0 + 2 * math.sin(getSongPosition() / (1000 / HUDspeed)), 0.5, 'linear')
	else
		--dont
	end

	if notetoggled then
		for i = 0, 3 do
			setProperty('playerStrums.members[' .. i .. '].x',
				_G['defaultPlayerStrumX' .. i] + getRandomFloat(-noteoffset, noteoffset))
			setProperty('playerStrums.members[' .. i .. '].y',
				_G['defaultPlayerStrumY' .. i] + getRandomFloat(-noteoffset, noteoffset) / 2)
		end
	else
		for i = 0, 3 do
			setProperty('playerStrums.members[' .. i .. '].x',
				_G['defaultPlayerStrumX' .. i])
			setProperty('playerStrums.members[' .. i .. '].y',
				_G['defaultPlayerStrumY' .. i])
		end
	end

	if scared then
		setProperty('dad.x', 600 + math.random(-shake, shake))
		setProperty('dad.y', -100 + math.random(-shake, shake))
		shake = shake + 0.0015
	else
		shake = 0
		setProperty('dad.y', -100 - 50 * math.cos(getSongPosition() / 1500))
		setProperty('dad.x', dadX)
	end
end

angry = false
function opponentNoteHit()
	if angry then
		triggerEvent('Screen Shake', '0.1, 0.001', '0.1, 0.001')
	end
end

function onStepHit()
	if curStep == 384 then
		angry = true
		hudtoggled = true
	elseif curStep == 1168 then
		movetoggled = false
		scared = true
		doTweenX('camGameXreturn', 'camGame', 0, 1.2, 'expoIn')
		doTweenX('camGameYreturn', 'camGame', 0, 1.2, 'expoIn')
		doTweenAngle('camGameAnglereturn', 'camGame', 0, 1.2, 'expoIn')

		doTweenX('camHUDXreturn', 'camHUD', 0, 1.1, 'expoIn')
		doTweenX('camHUDYreturn', 'camHUD', 0, 1.1, 'expoIn')
		doTweenAngle('camHUDAnglereturn', 'camHUD', 0, 1.2, 'expoIn')
	elseif curStep == 1304 then
		movetoggled = true
		hudtoggled = true
		notetoggled = true

		scared = false

		HUDspeed = 1.5
	elseif curStep == 2224 then
		movetoggled = false
		hudtoggled = false

		scared = true

		doTweenX('camGameXreturn', 'camGame', 0, 1.2, 'expoIn')
		doTweenX('camGameYreturn', 'camGame', 0, 1.2, 'expoIn')
		doTweenAngle('camGameAnglereturn', 'camGame', 0, 1.2, 'expoIn')

		doTweenX('camHUDXreturn', 'camHUD', 0, 1.1, 'expoIn')
		doTweenX('camHUDYreturn', 'camHUD', 0, 1.1, 'expoIn')
		doTweenAngle('camHUDAnglereturn', 'camHUD', 0, 1.2, 'expoIn')

		noteoffset = 9
	end
	if curStep >= 2240 then
		noteoffset = noteoffset*0.9
	end
	if curStep == 2368 then
		notetoggled = false
	elseif curStep == 2720 then
		cameraFlash('camHUD', '0x72FFFFFF', 1, true)
	elseif curStep == 2752 then
		scared = false
	end
	if curStep == 2736 then
		doTweenAlpha('cam', 'camHUD', 0, 1)
	end
	if curStep == 2749 then
		triggerEvent('Add Camera Zoom', '0.2', '0.1')
		cameraFade('camOther', '000000', 0.1)
	end
end
