--Event by sirFerzy
local dmg = { 0, 0, 0.5, 1 }
local move, side, bfX, dadX = 0, 0, getProperty('boyfriend.x'), getProperty('dad.x')
local shaker, shika = 0, 0
function onCreate()
	if difficultyName == 'pussy' then
		close()
	end
	precacheSound('pk_love')
	luaDebugMode = true
	precacheImage('psilove')
	makeAnimatedLuaSprite('psi', 'psilove', 0, 0)
	addAnimationByPrefix('psi', 'nothing', 'psilove psi0000', 2, true)
	addAnimationByPrefix('psi', 'psilove psi', 'psilove psi', 21, false)
	setObjectCamera('psi', 'other')
	scaleObject('psi', 0.8, 0.7)
	addLuaSprite('psi', true)
	setProperty('psi.alpha', 0.001)
	movey = getProperty('camGame.height') * 0.5
	movex = getProperty('camGame.width') * 0.5
	setProperty('camGame.height', getProperty('camGame.height') * 2)
	setProperty('camGame.width', getProperty('camGame.width') * 2)
	setProperty('camGame.x', -movex)
	setProperty('camGame.y', -movey)
	windowX = getPropertyFromClass('openfl.Lib', 'application.window.x')
	windowY = getPropertyFromClass('openfl.Lib', 'application.window.y')
	setProperty('boyfriendCameraOffset[1]', getProperty("boyfriendCameraOffset[1]") - movey)
	setProperty("opponentCameraOffset[1]", getProperty("opponentCameraOffset[1]") - movey)
	setProperty('boyfriendCameraOffset[0]', getProperty("boyfriendCameraOffset[0]") - movex)
	setProperty("opponentCameraOffset[0]", getProperty("opponentCameraOffset[0]") - movex)
	makeLuaSprite('overL', nil, -200, -200)
	makeGraphic('overL', 1, 1, 'FF4DFF')
	scaleObject('overL', screenWidth * 3.5, screenHeight * 3.5)
	setScrollFactor('overL', 0, 0)
	setProperty('overL.alpha', 0)
	setBlendMode('overL', 'screen')
end

function onCreatePost()
	addLuaSprite('overL', true)
end

function math.lerp(from, to, i)
	return from + (to - from) * i
end

function onUpdate(elapsed)
	local duration = 0.3 / playbackRate
	local timed = (os.clock() % duration) / duration
	local value = -1 + 2 * math.abs(timed * 2 - 1)
	move = math.lerp(move, 0, (elapsed * 4.5) * playbackRate)

	shaker = math.lerp(shaker, shika, elapsed * 0.5 * playbackRate)
	setProperty('dad.x', dadX + shaker * 60 * math.sin(getSongPosition() / 220 * (shaker * 10 + 0.1)))
	if move > 2 then
		if side == 0 then
			setProperty('camGame.y', -movey + (move * value))
			setPropertyFromClass('openfl.Lib', 'application.window.y', windowY + (move * value) / 2.5)
			setPropertyFromClass('openfl.Lib', 'application.window.x', windowX + (getRandomInt(-10, 10) * move / 45))
		elseif side == 1 then
			setProperty('camGame.x', -movex + (move * value))
			setPropertyFromClass('openfl.Lib', 'application.window.x', windowX + (move * value) / 3.5)
			setPropertyFromClass('openfl.Lib', 'application.window.y', windowY + (getRandomInt(-10, 10) * move / 225))
		end
	end
end

function onSongStart()
	bfX = getProperty('boyfriend.x')
end

function onEvent(name, a, b)
	if name == 'warChat' and a == 'him' and songPath == 'warforged' then
		startTween('cam3', 'dad.colorTransform', { redOffset = 255, greenOffset = 255, blueOffset = 0 },
			crochet / 2000 / playbackRate, { type = 'PINGPONG' })
		startTween('cam2', 'iconP2.colorTransform', { redOffset = 255, greenOffset = 255, blueOffset = 0 },
			crochet / 2000 / playbackRate, { type = 'PINGPONG' })
	end
	if name == 'PSILOVE' then
		cancelTween('cam3')
		cancelTween('cam2')
		startTween('cam3', 'dad.colorTransform',
			{
				redOffset = 255,
				greenOffset = 255,
				blueOffset = 255,
				redMultiplier = -0.2,
				greenMultiplier = -0.2,
				blueMultiplier = 0
			}, 0.5 / playbackRate, { ease = 'bounceOut' })
		startTween('cam2', 'iconP2.colorTransform',
			{
				redOffset = 255,
				greenOffset = 255,
				blueOffset = 255,
				redMultiplier = -0.2,
				greenMultiplier = -0.2,
				blueMultiplier = 0
			}, 0.5 / playbackRate, { ease = 'bounceOut' })
		shika = 10
		cancelTween('fade')
		doTweenAlpha('cam34', 'overL', 0.5, 0.35 / playbackRate)
		setProperty('psi.alpha', 0.7)
		setBlendMode('psi', 'screen')
		playAnim('psi', 'psilove psi', true)
		runTimer('shake1', 0.6 / playbackRate)
		if playbackRate <= 3 then
			playSound('pk_love', 0.8, "boom")
		end
	end
end

function onUpdatePost()
	if shika > 0 then
		setProperty('iconP2.offset.x', getRandomFloat(-shaker, shaker) * 10 * math.sin(getSongPosition()))
		setProperty('iconP2.offset.y', getRandomFloat(-shaker, shaker) * 10 * math.sin(getSongPosition()))
	end
	for i = 1, 2 do
		if move > 2 then
			local st = move / 10
			setProperty('iconP' .. i .. '.offset.x', getRandomFloat(-st, st) * math.sin(getSongPosition() / 1) / i)
			setProperty('iconP' .. i .. '.offset.y', getRandomFloat(-st, st) * math.sin(getSongPosition() / 1) / i)
		end
	end
	setProperty('boyfriend.x', bfX + (move / 3) * math.sin(getSongPosition()))
end

function onTimerCompleted(timer)
	if timer == 'shake1' then
		shika = 0
		shaker = 0
		startTween('cam3', 'dad.colorTransform',
			{ redOffset = 0, greenOffset = 0, blueOffset = 0, redMultiplier = 1, greenMultiplier = 1, blueMultiplier = 1 },
			0.25 / playbackRate, { ease = 'linear' })
		startTween('cam2', 'iconP2.colorTransform',
			{ redOffset = 0, greenOffset = 0, blueOffset = 0, redMultiplier = 1, greenMultiplier = 1, blueMultiplier = 1 },
			0.25 / playbackRate, { ease = 'linear' })
		setProperty('overL.alpha', 0)
		setProperty('strength', 3)
		setProperty('force', getProperty('force') + 9)
		setProperty('bloom', getProperty('bloom') + 0.5)
		side = 1
		move = 750
		if getHealth() < 1.75 * dmg[difficulty + 1] then
			setProperty('healthy', -0.25 * dmg[difficulty + 1])
		else
			setProperty('healthy', getProperty('healthy') - 2.25 * dmg[difficulty + 1])
		end
		runTimer('shake2', 0.6 / playbackRate)
		if not lowQuality then
			cameraFlash('other', '0xD6FFFF69', 0.5 / playbackRate, true)
		end
	end
	if timer == 'shake2' then
		setProperty('camGame.x', -movex)
		setPropertyFromClass('openfl.Lib', 'application.window.x', windowX)
		side = 0
		move = 220
		setProperty('strength', 1.5)
		setProperty('force', getProperty('force') - 4)
		runTimer('end', 1.5 / playbackRate)
		doTweenAlpha('fade', 'psi', 0.01, 1 / playbackRate, "cubeOut")
		setProperty('bloom', getProperty('bloom') + 0.25)
	end
	if timer == 'end' then
		setProperty('camGame.y', -movey)
		setProperty('camGame.x', -movex)
		setPropertyFromClass('openfl.Lib', 'application.window.y', windowY)
		setPropertyFromClass('openfl.Lib', 'application.window.x', windowX)
	end
end

function goodNoteHit(a, s, f, e)
	if not e then
		setProperty('healthy', math.min(getProperty('healthy') + 0.016, 2))
	end
	if e then
		setProperty('healthy', math.min(getProperty('healthy') + 0.01, 2))
	end
end

function opponentNoteHit(a, s, f, e)
	if getProperty('healthy') > 0.025 then
		if not e then
			setProperty('healthy', math.min(getProperty('healthy') - 0.005, 2))
		end
		if e then
			setProperty('healthy', math.min(getProperty('healthy') - 0.002, 2))
		end
	end
end

function onDestroy()
	setPropertyFromClass('openfl.Lib', 'application.window.y', windowY)
	setPropertyFromClass('openfl.Lib', 'application.window.x', windowX)
end

function onPause()
	if move < 2 then
		windowX = getPropertyFromClass('openfl.Lib', 'application.window.x')
		windowY = getPropertyFromClass('openfl.Lib', 'application.window.y')
	end
end
