originalpos = 0
function onCreatePost()
	addLuaScript("custom_events/zCameraFix")

	setProperty('camHUD.alpha', 0)
	defaultdady = getProperty('dad.y')
	defaultbfy = getProperty('boyfriend.y')

	originalpos = getProperty('iconP2.y')
end

function onUpdatePost()
	setProperty('iconP2.origin.x', 80)
	setProperty('iconP2.origin.y', 0)
end

bouncy = false
function onBeatHit()
	if bouncy == true then
		triggerEvent('Add Camera Zoom', '0.03', '0.03')

		if curBeat % 2 == 0 then
			doTweenAngle('camGameAngle', 'camGame', -2, 0.5, 'circOut')
			doTweenAngle('iconP2Angle', 'iconP2', 10, 0.5, 'circOut')

			noteTweenAngle('angle0', 0, -10, 0.5, 'circOut')
			noteTweenX('x0', 0, defaultPlayerStrumX0 - 10, 0.25, 'circInOut')

			noteTweenAngle('angle1', 1, -10, 0.5, 'circOut')
			noteTweenX('x1', 1, defaultPlayerStrumX1 - 10, 0.25, 'circInOut')

			noteTweenAngle('angle2', 2, -10, 0.5, 'circOut')
			noteTweenX('x2', 2, defaultPlayerStrumX2 - 10, 0.25, 'circInOut')

			noteTweenAngle('angle3', 3, -10, 0.5, 'circOut')
			noteTweenX('x3', 3, defaultPlayerStrumX3 - 10, 0.25, 'circInOut')

			noteTweenAngle('angle4', 4, -10, 0.5, 'circOut')
			noteTweenX('x4', 4, defaultOpponentStrumX0 - 10, 0.25, 'circInOut')

			noteTweenAngle('angle5', 5, -10, 0.5, 'circOut')
			noteTweenX('x5', 5, defaultOpponentStrumX1 - 10, 0.25, 'circInOut')

			noteTweenAngle('angle6', 6, -10, 0.5, 'circOut')
			noteTweenX('x6', 6, defaultOpponentStrumX2 - 10, 0.25, 'circInOut')

			noteTweenAngle('angle7', 7, -10, 0.5, 'circOut')
			noteTweenX('x7', 7, defaultOpponentStrumX3 - 10, 0.25, 'circInOut')
		else
			doTweenAngle('camGameAngle', 'camGame', 2, 0.5, 'circOut')
			doTweenAngle('iconP2Angle', 'iconP2', -10, 0.5, 'circOut')

			noteTweenAngle('angle0', 0, 10, 0.5, 'circOut')
			noteTweenX('x0', 0, defaultPlayerStrumX0 + 10, 0.25, 'circInOut')

			noteTweenAngle('angle1', 1, 10, 0.5, 'circOut')
			noteTweenX('x1', 1, defaultPlayerStrumX1 + 10, 0.25, 'circInOut')

			noteTweenAngle('angle2', 2, 10, 0.5, 'circOut')
			noteTweenX('x2', 2, defaultPlayerStrumX2 + 10, 0.25, 'circInOut')

			noteTweenAngle('angle3', 3, 10, 0.5, 'circOut')
			noteTweenX('x3', 3, defaultPlayerStrumX3 + 10, 0.25, 'circInOut')

			noteTweenAngle('angle4', 4, 10, 0.5, 'circOut')
			noteTweenX('x4', 4, defaultOpponentStrumX0 + 10, 0.25, 'circInOut')

			noteTweenAngle('angle5', 5, 10, 0.5, 'circOut')
			noteTweenX('x5', 5, defaultOpponentStrumX1 + 10, 0.25, 'circInOut')

			noteTweenAngle('angle6', 6, 10, 0.5, 'circOut')
			noteTweenX('x6', 6, defaultOpponentStrumX2 + 10, 0.25, 'circInOut')

			noteTweenAngle('angle7', 7, 10, 0.5, 'circOut')
			noteTweenX('x7', 7, defaultOpponentStrumX3 + 10, 0.25, 'circInOut')
		end
	end
end

function onStepHit()
	if curStep == 256 then
		doTweenAlpha('camhudalpha', 'camHUD', 1, 0.5, 'circOut')
		bouncy = true
	end

	if bouncy == true then
		if curStep % 4 == 0 then
			noteTweenY('0y', 0, defaultPlayerStrumY0, 0.125, 'circInOut')
			noteTweenY('1y', 1, defaultPlayerStrumY1, 0.125, 'circInOut')
			noteTweenY('2y', 2, defaultPlayerStrumY2, 0.125, 'circInOut')
			noteTweenY('3y', 3, defaultPlayerStrumY3, 0.125, 'circInOut')
			noteTweenY('4y', 4, defaultOpponentStrumY0, 0.125, 'circInOut')
			noteTweenY('5y', 5, defaultOpponentStrumY1, 0.125, 'circInOut')
			noteTweenY('6y', 6, defaultOpponentStrumY2, 0.125, 'circInOut')
			noteTweenY('7y', 7, defaultOpponentStrumY3, 0.125, 'circInOut')

			doTweenY('bfy', 'boyfriend', defaultbfy - 20, 0.05, 'circOut')
			doTweenY('dady', 'dad', defaultdady - 20, 0.05, 'circOut')

			doTweenY('iconP2y', 'iconP2', originalpos - 30, 0.05, 'circOut')
		elseif curStep % 4 == 2 then
			if downscroll == true then
				noteTweenY('0y', 0, defaultPlayerStrumY0 - 10, 0.125, 'circOut')
				noteTweenY('1y', 1, defaultPlayerStrumY1 - 10, 0.125, 'circOut')
				noteTweenY('2y', 2, defaultPlayerStrumY2 - 10, 0.125, 'circOut')
				noteTweenY('3y', 3, defaultPlayerStrumY3 - 10, 0.125, 'circOut')
				noteTweenY('4y', 4, defaultOpponentStrumY0 - 10, 0.125, 'circOut')
				noteTweenY('5y', 5, defaultOpponentStrumY1 - 10, 0.125, 'circOut')
				noteTweenY('6y', 6, defaultOpponentStrumY2 - 10, 0.125, 'circOut')
				noteTweenY('7y', 7, defaultOpponentStrumY3 - 10, 0.125, 'circOut')
			else
				noteTweenY('0y', 0, defaultPlayerStrumY0 + 10, 0.125, 'circOut')
				noteTweenY('1y', 1, defaultPlayerStrumY1 + 10, 0.125, 'circOut')
				noteTweenY('2y', 2, defaultPlayerStrumY2 + 10, 0.125, 'circOut')
				noteTweenY('3y', 3, defaultPlayerStrumY3 + 10, 0.125, 'circOut')
				noteTweenY('4y', 4, defaultOpponentStrumY0 + 10, 0.125, 'circOut')
				noteTweenY('5y', 5, defaultOpponentStrumY1 + 10, 0.125, 'circOut')
				noteTweenY('6y', 6, defaultOpponentStrumY2 + 10, 0.125, 'circOut')
				noteTweenY('7y', 7, defaultOpponentStrumY3 + 10, 0.125, 'circOut')
			end
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'bfy' then
		doTweenY('bfyreturn', 'boyfriend', defaultbfy, 0.1, 'circInOut')
		doTweenY('dadyreturn', 'dad', defaultdady, 0.1, 'circInOut')
		doTweenY('iconP2y', 'iconP2', originalpos, 0.1, 'circInOut')
	end
end