--echo but better lol
--ferzy do but capp is goat for original
local startYFerz, des
local reversed, bfEcho, dadEcho, screenStuff = false, false, false, false
function onCreatePost()
	precacheImage('NOTE_assets')
	if downscroll then
		startYFerz = 550
		des = 400
	else
		startYFerz = 30
		des = 175
	end
	setProperty('camHUD.height', getProperty('camHUD.height') + 25)
	setProperty('camHUD.width', getProperty('camHUD.width') + 50)
end

function onStepHit()
	if curStep == 2063 then
		setProperty('boyfriendCameraOffset[0]', getProperty("boyfriendCameraOffset[0]") + 100)
		setProperty('boyfriendCameraOffset[1]', getProperty("boyfriendCameraOffset[1]") - 75)
		bfEcho = true
	end
	if curStep == 2335 then
		screenStuff = true
		setProperty('boyfriendCameraOffset[0]', getProperty("boyfriendCameraOffset[0]") - 100)
		setProperty('boyfriendCameraOffset[1]', getProperty("boyfriendCameraOffset[1]") + 75)
		dadEcho = true
	end
	if curStep == 2591 then
		if downscroll then
			des = 700
			startYFerz = 550
		else
			des = -90
			startYFerz = 50
		end
		reversed = true
	end
end

local function coloring(tag, id)
end

local dir = { "left", "down", "up", "right" }
function opponentNoteHit(o, d, s, f)
	if dadEcho and not f then
		local a = getSongPosition() * 2 + getRandomInt(-10, 10)
		local skin = '-' .. getPropertyFromClass('backend.ClientPrefs', 'data.noteSkin')
		if skin == '-Default' then
			skin = ''
		end
		makeAnimatedLuaSprite('per' .. a, 'noteSkins/NOTE_assets' .. string.lower(skin),
			_G['defaultOpponentStrumX' .. d] - 25, startYFerz)
		addAnimationByPrefix('per' .. a, tostring(getRandomFloat(0, 1)), dir[d + 1] .. ' confirm', 7.5, false)
		setObjectCamera('per' .. a, 'hud')
		scaleObject('per' .. a, 0.65, 0.65)
		addLuaSprite('per' .. a, true)
		setProperty('per' .. a .. '.alpha', getProperty('opponentStrums.members[' .. d .. '].alpha') - 0.25)
		setRGBShader('per' .. a, getPropertyFromGroup('notes', o, 'rgbShader.r'),
			getPropertyFromGroup('notes', o, 'rgbShader.g'), getPropertyFromGroup('notes', o, 'rgbShader.b'))

		if not reversed then
			runTimer('per' .. a, 0.25 / playbackRate)
			if downscroll then
				doTweenY('per2' .. a, 'per' .. a, des * getRandomFloat(0.6, 1.05), 0.8 / playbackRate, 'circOut')
			else
				doTweenY('per2' .. a, 'per' .. a, des * getRandomFloat(0.9, 1.75), 0.8 / playbackRate, 'circOut')
			end
			setProperty('per' .. a .. '.angularVelocity', getRandomFloat(-100, 100) * playbackRate)
			doTweenX('per3' .. a, 'per' .. a .. '.scale', 0.6, 0.75 / playbackRate, 'sinIn')
			doTweenY('per4' .. a, 'per' .. a .. '.scale', 0.6, 0.75 / playbackRate, 'sinIn')
		else
			runTimer('per' .. a, 0.45 / playbackRate)
			setProperty('per' .. a .. '.angularAcceleration', getRandomFloat(-200, 200) * playbackRate)
			if downscroll then
				setProperty('per' .. a .. '.acceleration.y', -1000)
				setProperty('per' .. a .. '.velocity.y', 450)
			else
				setProperty('per' .. a .. '.acceleration.y', 1000)
				setProperty('per' .. a .. '.velocity.y', -450)
			end
			setBlendMode('per' .. a, 'screen')
		end
		coloring('per' .. a, o)
	end
end

function goodNoteHit(o, d, s, f)
	if bfEcho and not f then
		local a = getSongPosition() + getRandomInt(-10, 10)
		local skin = '-' .. getPropertyFromClass('backend.ClientPrefs', 'data.noteSkin')
		if skin == '-Default' then
			skin = ''
		end
		makeAnimatedLuaSprite('plE' .. a, 'noteSkins/NOTE_assets' .. string.lower(skin), _G['defaultPlayerStrumX' .. d] -
			25, startYFerz)
		addAnimationByPrefix('plE' .. a, tostring(getRandomFloat(0, 1)), dir[d + 1] .. ' confirm', 7.5, true)
		setObjectCamera('plE' .. a, 'hud')
		scaleObject('plE' .. a, 0.7, 0.7)
		addLuaSprite('plE' .. a, true)
		setProperty('plE' .. a .. '.alpha', getProperty('playerStrums.members[' .. d .. '].alpha') - 0.25)
		setRGBShader('plE' .. a, getPropertyFromGroup('notes', o, 'rgbShader.r'),
			getPropertyFromGroup('notes', o, 'rgbShader.g'), getPropertyFromGroup('notes', o, 'rgbShader.b'))
		runTimer('plE' .. a, 0.25 / playbackRate)
		if not reversed then
			if downscroll then
				doTweenY('plE2' .. a, 'plE' .. a, des * getRandomFloat(0.7, 0.95), 0.8 / playbackRate, 'circOut')
			else
				doTweenY('plE2' .. a, 'plE' .. a, des * getRandomFloat(1.1, 1.3), 0.8 / playbackRate, 'circOut')
			end
			setProperty('plE' .. a .. '.angularVelocity', getRandomFloat(-50, 50) * playbackRate)
		else
			setProperty('plE' .. a .. '.angularVelocity', getRandomFloat(-100, 100) * playbackRate)
			if downscroll then
				setProperty('plE' .. a .. '.acceleration.y', -800 * playbackRate)
				setProperty('plE' .. a .. '.velocity.y', 500 * playbackRate)
			else
				setProperty('plE' .. a .. '.acceleration.y', 800 * playbackRate)
				setProperty('plE' .. a .. '.velocity.y', -500 * playbackRate)
			end
			setBlendMode('plE' .. a, 'add')
			setProperty('plE' .. a .. '.alpha', getProperty('playerStrums.members[' .. d .. '].alpha'))
		end
		doTweenX('plE3' .. a, 'plE' .. a .. '.scale', 0.6, 0.75 / playbackRate, 'sinIn')
		doTweenY('plE4' .. a, 'plE' .. a .. '.scale', 0.6, 0.75 / playbackRate, 'sinIn')
		coloring('plE' .. a, o)
	end
end

local speed = 0.65
function onUpdatePost()
	if screenStuff then
		setProperty('camHUD.x', 12 * math.sin(getSongPosition() / (500 / speed)))
		setProperty('camHUD.y', -5 + 5 * math.sin(getSongPosition() / (750 / speed)))
		setProperty('camHUD.angle', 0.75 * math.sin(getSongPosition() / (1000 / speed)))
		setProperty('camGame.angle', -1.25 * math.sin(getSongPosition() / (800 / speed)))
		for i = 0, 3 do
			setProperty('playerStrums.members[' .. i .. '].x',
				_G['defaultPlayerStrumX' .. i] + getRandomFloat(-3, 3))
			setProperty('playerStrums.members[' .. i .. '].y',
				_G['defaultPlayerStrumY' .. i] + getRandomFloat(-3, 3))
		end
	end
end

function onTimerCompleted(tag)
	if string.sub(tag, 1, 3) == 'plE' then
		doTweenAlpha(tag .. '1', tag, 0, 0.45 / playbackRate, 'quadOut')
		runTimer('do' .. tag .. 'remove', 0.6 / playbackRate)
	end
	if string.find(tag, 'remove') then
		removeLuaSprite(tag:sub(3, -7), true)
	end
	if string.sub(tag, 1, 3) == 'per' then
		doTweenAlpha(tag .. '1', tag, 0, 0.45 / playbackRate, 'quadOut')
		runTimer('do' .. tag .. 'delete', 0.6 / playbackRate)
	end
	if string.find(tag, 'delete') then
		removeLuaSprite(tag:sub(3, -7), true)
	end
end
