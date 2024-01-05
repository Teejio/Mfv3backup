function onCreatePost()
	addLuaScript("custom_events/zCameraFix")

	boxposx = getProperty('circus.x')
	boxposy = getProperty('circus.y')
	setProperty('circus.alpha', 0)
end

local strength
boxposx = 0
boxposy = 0
yippee = false
circuscutscene = false

opponentNoteModChart = true
playerNoteModChart = false
playerintensity = 0.1
function onUpdate()
	if getProperty('dad.animation.curAnim.name') == 'idle' then
		strength = 0.4
	else
		strength = 1.35
	end
	if math.random(1, 10) == 1 then
		setProperty('dad.alpha', 0)
		if circuscutscene == false then
			setProperty('iconP2.alpha', 0)
		end
	else
		setProperty('dad.alpha', 1)
		if circuscutscene == false then
			setProperty('iconP2.alpha', 1)
		end
	end


	if playerNoteModChart == true then
		noteTweenAlpha('4', 4, math.random(0.7, 1), 0.001, 'linear')
		noteTweenAlpha('5', 5, math.random(0.7, 1), 0.001, 'linear')
		noteTweenAlpha('6', 6, math.random(0.7, 1), 0.001, 'linear')
		noteTweenAlpha('7', 7, math.random(0.7, 1), 0.001, 'linear')

		noteTweenX('4x', 4, defaultOpponentStrumX0 - (60 * math.sin(getSongPosition() / (500 / 0.7))) * playerintensity,
			0.1, 'linear')
		noteTweenX('5x', 5, defaultOpponentStrumX1 - (40 * math.sin(getSongPosition() / (500 / 0.5))) * playerintensity,
			0.1, 'linear')
		noteTweenX('6x', 6, defaultOpponentStrumX2 - (60 * math.sin(getSongPosition() / (500 / 0.9))) * playerintensity,
			0.1, 'linear')
		noteTweenX('7x', 7, defaultOpponentStrumX3 - (50 * math.sin(getSongPosition() / (500 / 0.4))) * playerintensity,
			0.1, 'linear')

		noteTweenY('4y', 4, defaultOpponentStrumY0 - (10 * math.sin(getSongPosition() / (100 / 0.4))) * playerintensity,
			0.1, 'linear')
		noteTweenY('5y', 5, defaultOpponentStrumY1 - (10 * math.sin(getSongPosition() / (100 / 0.8))) * playerintensity,
			0.1, 'linear')
		noteTweenY('6y', 6, defaultOpponentStrumY2 - (10 * math.sin(getSongPosition() / (100 / 0.2))) * playerintensity,
			0.1, 'linear')
		noteTweenY('7y', 7, defaultOpponentStrumY3 - (10 * math.sin(getSongPosition() / (100 / 1.2))) * playerintensity,
			0.1, 'linear')

		noteTweenAngle('4angle', 4, 0 - (5 * math.sin(getSongPosition() / (100 / 0.6))) * playerintensity, 0.1, 'linear')
		noteTweenAngle('5angle', 5, 0 - (15 * math.sin(getSongPosition() / (100 / 0.2))) * playerintensity, 0.1, 'linear')
		noteTweenAngle('6angle', 6, 0 - (12 * math.sin(getSongPosition() / (100 / 1.1))) * playerintensity, 0.1, 'linear')
		noteTweenAngle('7angle', 7, 0 - (9 * math.sin(getSongPosition() / (100 / 0.4))) * playerintensity, 0.1, 'linear')
	end

	if yippee == true then
		doTweenAngle('circusAngle', 'circus', 0 + 15 * math.sin(getSongPosition() / (100 / 0.2)), 0.5, 'circout')
		doTweenY('circusYjiggle', 'circus', 200 - 20 * math.sin(getSongPosition() / (100 / 0.8)), 0.1, 'circOut')
	end
end

function onUpdatePost()
	if opponentNoteModChart == true then
		noteTweenAngle('0angle', 0, 0 + 5 * math.sin(getSongPosition() / (100 / 0.6)), 0.1, 'linear')
		noteTweenAngle('1angle', 1, 0 + 15 * math.sin(getSongPosition() / (100 / 0.2)), 0.1, 'linear')
		noteTweenAngle('2angle', 2, 0 + 12 * math.sin(getSongPosition() / (100 / 1.1)), 0.1, 'linear')
		noteTweenAngle('3angle', 3, 0 + 9 * math.sin(getSongPosition() / (100 / 0.4)), 0.1, 'linear')
		for i = 0, 3 do
			setProperty('opponentStrums.members[' .. i .. '].alpha', getRandomFloat(0.5, 1) * strength)
			setProperty('opponentStrums.members[' .. i .. '].x',
				_G['defaultPlayerStrumX' .. i] + getRandomFloat(-6, 6) * strength)
			if getRandomBool(70 * strength) then
				setProperty('opponentStrums.members[' .. i .. '].y',
					_G['defaultPlayerStrumY' .. i] + 1 * math.tan(getSongPosition() / (getRandomInt(1000, 2000) * strength)))
			end
		end
		setProperty('iconP2.offset.x', getRandomFloat(-3, 3)*strength * math.tan(getSongPosition() / 5)*strength)
		setProperty('iconP2.offset.y', getRandomFloat(-3, 3)*strength * math.tan(getSongPosition() / 5)*strength)
		setProperty('dad.offset.y', getRandomFloat(-2, 2) * math.tan(getSongPosition() / 10))
		setProperty('dad.offset.x', getRandomFloat(-1, 1) * math.tan(getSongPosition() / 10))
		if getProperty('dad.animation.curAnim.name') == 'idle' then
			setProperty('iconP2.alpha', getRandomFloat(-0.1, 0.4))
		end
	end
end

bouncy = false
function onBeatHit()
	if bouncy == true then
		if curBeat % 2 == 0 then
			doTweenAngle('camGameAngle', 'camGame', -2, 0.5, 'circOut')
			doTweenAngle('iconP2Angle', 'iconP2', 10, 0.5, 'circOut')
		else
			doTweenAngle('camGameAngle', 'camGame', 2, 0.5, 'circOut')
			doTweenAngle('iconP2Angle', 'iconP2', -10, 0.5, 'circOut')
		end
	end
end

function onStepHit()
	if bouncy == true then
		if curStep % 4 == 0 then
			doTweenY('camGameY', 'camGame', 10, 0.1, 'circOut')
		end
	end

	if curStep == 1 then
		doTweenX('circusX', 'circus', boxposx - 300, 0.25, 'expoOut')
		doTweenY('circusY', 'circus', 1000, 0.25, 'elasticOut')
		doTweenAngle('circusAngle', 'circus', -180, 0.25, 'circOut')
	elseif curStep == 448 then
		bouncy = true
	elseif curStep == 596 or curStep == 608 or curStep == 612 or curStep == 616 or curStep == 620 or curStep == 628 or curStep == 660 or curStep == 676 or curStep == 684 or curStep == 686 or curStep == 724 or curStep == 736 or curStep == 740 or curStep == 744 or curStep == 748 or curStep == 756 or curStep == 788 or curStep == 812 or curStep == 814 then
		opponentNoteModChart = false
	elseif curStep == 600 or curStep == 611 or curStep == 615 or curStep == 619 or curStep == 624 or curStep == 632 or curStep == 664 or curStep == 678 or curStep == 685 or curStep == 688 or curStep == 728 or curStep == 739 or curStep == 743 or curStep == 747 or curStep == 752 or curStep == 760 or curStep == 792 or curStep == 813 or curStep == 816 then
		opponentNoteModChart = true
	elseif curStep == 2080 then
		objectPlayAnimation('circus', 'text box glitch', true)
		doTweenAlpha('circusAlpha', 'circus', 1, 0.25, 'circOut')
		doTweenX('circusX', 'circus', boxposx, 0.4, 'expoInOut')
		doTweenY('circusY', 'circus', 200, 0.25, 'expoInOut')
		doTweenAngle('circusAngle', 'circus', 20, 0.4, 'expoInOut')

		doTweenAlpha('scoreTxt1', 'scoreTxt', 0, 0.25, 'linear')
		doTweenAlpha('healthBar1', 'healthBar', 0, 0.25, 'linear')
		doTweenAlpha('healthBarBG1', 'healthBarBG', 0, 0.25, 'linear')
		doTweenAlpha('iconP1alpha', 'iconP1', 0, 0.25, 'linear')
		doTweenAlpha('iconP2alpha', 'iconP2', 0, 0.25, 'linear')
		circuscutscene = true
	elseif curStep == 2084 then
		yippee = true
	elseif curStep == 2108 then
		doTweenAlpha('circusAlpha', 'circus', 0, 0.25, 'circOut')

		doTweenAlpha('scoreTxt1', 'scoreTxt', 1, 0.25, 'linear')
		doTweenAlpha('healthBar1', 'healthBar', 1, 0.25, 'linear')
		doTweenAlpha('healthBarBG1', 'healthBarBG', 1, 0.25, 'linear')
		doTweenAlpha('iconP1alpha', 'iconP1', 1, 0.25, 'linear')
		doTweenAlpha('iconP2alpha', 'iconP2', 1, 0.25, 'linear')
		circuscutscene = false
	elseif curStep == 2112 then
		playerNoteModChart = true
		playerintensity = 0.1
	elseif curStep == 2128 then
		playerintensity = 0.2
	elseif curStep == 2144 then
		playerintensity = 0.3
	elseif curStep == 2160 then
		playerintensity = 0.4
	elseif curStep == 2176 then
		playerintensity = 0.5
	elseif curStep == 2624 then
		doTweenAlpha('camHudalpha', 'camHUD', 0, 7.5, 'linear')
	end
end

function onTweenCompleted(name)
	if name == 'camGameY' then
		doTweenY('camGameYreturn', 'camGame', 0, 0.2, 'circIn')
	end
end
