function onCreatePost()
	addLuaScript("custom_events/zCameraFix")
end

bouncy = false
function onBeatHit()
	if bouncy == true then
		if curBeat % 2 == 0 then
			doTweenAngle('iconP1Angle', 'iconP1', -10, 0.5, 'circOut')
			doTweenAngle('iconP2Angle', 'iconP2', 10, 0.5, 'circOut')

			noteTweenAngle('angle0', 0, -10, 0.5, 'circOut')
			noteTweenX('x0', 0, defaultOpponentStrumX0 - 10, 0.25, 'circInOut')

			noteTweenAngle('angle1', 1, -10, 0.5, 'circOut')
			noteTweenX('x1', 1, defaultOpponentStrumX1 - 10, 0.25, 'circInOut')

			noteTweenAngle('angle2', 2, -10, 0.5, 'circOut')
			noteTweenX('x2', 2, defaultOpponentStrumX2 - 10, 0.25, 'circInOut')

			noteTweenAngle('angle3', 3, -10, 0.5, 'circOut')
			noteTweenX('x3', 3, defaultOpponentStrumX3 - 10, 0.25, 'circInOut')

			noteTweenAngle('angle4', 4, -10, 0.5, 'circOut')
			noteTweenX('x4', 4, defaultPlayerStrumX0 - 10, 0.25, 'circInOut')

			noteTweenAngle('angle5', 5, -10, 0.5, 'circOut')
			noteTweenX('x5', 5, defaultPlayerStrumX1 - 10, 0.25, 'circInOut')

			noteTweenAngle('angle6', 6, -10, 0.5, 'circOut')
			noteTweenX('x6', 6, defaultPlayerStrumX2 - 10, 0.25, 'circInOut')

			noteTweenAngle('angle7', 7, -10, 0.5, 'circOut')
			noteTweenX('x7', 7, defaultPlayerStrumX3 - 10, 0.25, 'circInOut')
		else
			doTweenAngle('iconP1Angle', 'iconP1', 10, 0.5, 'circOut')
			doTweenAngle('iconP2Angle', 'iconP2', -10, 0.5, 'circOut')

			noteTweenAngle('angle0', 0, 10, 0.5, 'circOut')
			noteTweenX('x0', 0, defaultOpponentStrumX0 + 10, 0.25, 'circInOut')

			noteTweenAngle('angle1', 1, 10, 0.5, 'circOut')
			noteTweenX('x1', 1, defaultOpponentStrumX1 + 10, 0.25, 'circInOut')

			noteTweenAngle('angle2', 2, 10, 0.5, 'circOut')
			noteTweenX('x2', 2, defaultOpponentStrumX2 + 10, 0.25, 'circInOut')

			noteTweenAngle('angle3', 3, 10, 0.5, 'circOut')
			noteTweenX('x3', 3, defaultOpponentStrumX3 + 10, 0.25, 'circInOut')

			noteTweenAngle('angle4', 4, 10, 0.5, 'circOut')
			noteTweenX('x4', 4, defaultPlayerStrumX0 + 10, 0.25, 'circInOut')

			noteTweenAngle('angle5', 5, 10, 0.5, 'circOut')
			noteTweenX('x5', 5, defaultPlayerStrumX1 + 10, 0.25, 'circInOut')

			noteTweenAngle('angle6', 6, 10, 0.5, 'circOut')
			noteTweenX('x6', 6, defaultPlayerStrumX2 + 10, 0.25, 'circInOut')

			noteTweenAngle('angle7', 7, 10, 0.5, 'circOut')
			noteTweenX('x7', 7, defaultPlayerStrumX3 + 10, 0.25, 'circInOut')
		end
	end
end

function onStepHit()
	if bouncy == true then
		if curStep % 4 == 0 then
			noteTweenY('0y', 0, defaultOpponentStrumY0, 0.125, 'circInOut')
			noteTweenY('1y', 1, defaultOpponentStrumY1, 0.125, 'circInOut')
			noteTweenY('2y', 2, defaultOpponentStrumY2, 0.125, 'circInOut')
			noteTweenY('3y', 3, defaultOpponentStrumY3, 0.125, 'circInOut')
			noteTweenY('4y', 4, defaultPlayerStrumY0, 0.125, 'circInOut')
			noteTweenY('5y', 5, defaultPlayerStrumY1, 0.125, 'circInOut')
			noteTweenY('6y', 6, defaultPlayerStrumY2, 0.125, 'circInOut')
			noteTweenY('7y', 7, defaultPlayerStrumY3, 0.125, 'circInOut')

		elseif curStep % 4 == 2 then
			if downscroll == true then
				noteTweenY('0y', 0, defaultOpponentStrumY0 - 10, 0.125, 'circOut')
				noteTweenY('1y', 1, defaultOpponentStrumY1 - 10, 0.125, 'circOut')
				noteTweenY('2y', 2, defaultOpponentStrumY2 - 10, 0.125, 'circOut')
				noteTweenY('3y', 3, defaultOpponentStrumY3 - 10, 0.125, 'circOut')
				noteTweenY('4y', 4, defaultPlayerStrumY0 - 10, 0.125, 'circOut')
				noteTweenY('5y', 5, defaultPlayerStrumY1 - 10, 0.125, 'circOut')
				noteTweenY('6y', 6, defaultPlayerStrumY2 - 10, 0.125, 'circOut')
				noteTweenY('7y', 7, defaultPlayerStrumY3 - 10, 0.125, 'circOut')
			else
				noteTweenY('0y', 0, defaultOpponentStrumY0 + 10, 0.125, 'circOut')
				noteTweenY('1y', 1, defaultOpponentStrumY1 + 10, 0.125, 'circOut')
				noteTweenY('2y', 2, defaultOpponentStrumY2 + 10, 0.125, 'circOut')
				noteTweenY('3y', 3, defaultOpponentStrumY3 + 10, 0.125, 'circOut')
				noteTweenY('4y', 4, defaultPlayerStrumY0 + 10, 0.125, 'circOut')
				noteTweenY('5y', 5, defaultPlayerStrumY1 + 10, 0.125, 'circOut')
				noteTweenY('6y', 6, defaultPlayerStrumY2 + 10, 0.125, 'circOut')
				noteTweenY('7y', 7, defaultPlayerStrumY3 + 10, 0.125, 'circOut')
			end
		end
	end

	if curStep == 152 then
		doTweenAngle('camgameangle', 'camGame', -360, 0.7, 'circOut')
		doTweenAngle('camhudangle', 'camHUD', -360, 0.7, 'circOut')
	elseif curStep == 159 then
		bouncy = true
	elseif curStep == 1095 then
		doTweenAngle('camgameangle', 'camGame', -720, 0.7, 'circOut')
		doTweenAngle('camhudangle', 'camHUD', -720, 0.7, 'circOut')
	end
end