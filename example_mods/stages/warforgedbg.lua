--Stage lua remade by Ferzy
local stageLoc = 'stages/Claus/'
local alphaos = { "iconP1", "iconP2", "healthBar", "healthBarBG" }
local firstBG = { 'bgback', 'bgfront', 'deadGirl', 'deadDawg', 'foregroundrock', 'ravineFlash' }
local playerzoom = 0.575
local opponentzoom = 0.45
local particles = {}
local pp = 275
local dadAlpha
function onCreate()
	setProperty('camZoomingMult', 0)
	setProperty('camZoomingDecay', 1.5)
	precacheImage('warforged/sademote')
	precacheImage('warforged/sademote2')
	makeLuaSprite('white', nil, 0, 0)
	makeGraphic('white', 1, 1, 'FFFFFF')
	scaleObject('white', screenWidth * 1.2, screenHeight * 1.2, 'FFFFFF')
	setScrollFactor('white', 0, 0)
	setObjectCamera('white', 'camHUD')
	setProperty('white.alpha', 0)
	setObjectOrder('white', 3)
	addLuaSprite('white')
	precacheImage('psilove')

	makeLuaSprite('bgback', stageLoc .. 'bgback', -1900, -900)
	setScrollFactor('bgback', 0.6, 0.6)
	scaleObject('bgback', 4.5, 4.5)

	makeLuaSprite('bgfront', stageLoc .. 'bgfront', -2000, -1100)
	scaleObject('bgfront', 4.5, 4.5)

	makeLuaSprite('deadGirl', stageLoc .. 'Kumatora', 1300, 600)
	scaleObject('deadGirl', 3, 3)
	setProperty('deadGirl.angle', -10)

	makeLuaSprite('deadDawg', stageLoc .. 'Boney', 250, 400)
	scaleObject('deadDawg', 2.25, 2.25)
	setProperty('deadDawg.angle', -10)

	makeLuaSprite('foregroundrock', stageLoc .. 'foregroundrock', 1800, -400)
	setScrollFactor('foregroundrock', 0.7, 0.7)
	scaleObject('foregroundrock', 4.2, 4)

	makeAnimatedLuaSprite('static', stageLoc .. 'STATIC', 0, 0)
	addAnimationByPrefix('static', 'static', 'static', 20, true)
	setObjectCamera('static', 'hud')
	scaleObject('static', 2, 2)
	screenCenter('static')

	setProperty('static.alpha', 0)
	setProperty('scoreTxt.visible', false)

	makeAnimatedLuaSprite('acidtrip', stageLoc .. 'acidTrip', -400, -450)
	addAnimationByPrefix('acidtrip', 'idle', 'idle', 8, true)
	setProperty('acidtrip.alpha', 1)
	setProperty('acidtrip.antialiasing', false)

	setScrollFactor('acidtrip', 0, 0)
	scaleObject('acidtrip', 13, 9)
	setProperty('acidtrip.alpha', 0)
	if not lowQuality then
		makeAnimatedLuaSprite('ravineFlash', 'ravenFlash', -1300, -500)
		addAnimationByPrefix('ravineFlash', 'pulse', 'flash', 24, false)
		scaleObject('ravineFlash', 1.9, 1.7)
		setBlendMode('ravineFlash', 'add')
	end
end

function onCreatePost()
	setProperty('ravineFlash.visible', false)
	addLuaSprite('bgback', false)
	addLuaSprite('foregroundrock', false)
	if not lowQuality then
		addLuaSprite('ravineFlash', false)
	end
	addLuaSprite('bgfront', false)
	addLuaSprite('deadGirl', false)
	addLuaSprite('deadDawg', false)
	addLuaSprite('acidtrip')
	setProperty('camZooming', true)
	addLuaSprite("static", true);
	zoom()
	setProperty('scoreTxt.visible', false)
end

--weird zoomie stuff

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
		doTweenZoom('zoom', 'camGame', targetZoom, crochet / 1000 / playbackRate, 'quadOut')
		oldtarget = targetZoom
	end
	setProperty('defaultCamZoom', targetZoom)
end

function onBeatHit()
	if curBeat == 128 then
		runTimer('spawn', 0.075, 1000000)
	end
	if curBeat == 187 then
		cancelTimer('spawn')
	end
	if curBeat == 191 then
		runTimer('spawn', 0.035, 1000000)
	end
	if curBeat == 254 then
		setProperty('camZoomingDecay', 2)
		setProperty('camZoomingMult', 1.25)

		cancelTimer('spawn')
		runTimer('spawn', 0.25, 1000000)
	end
	if curBeat == 320 then
		cancelTimer('spawn')
		runTimer('spawn', 0.4, 1000000)
	end
	if curBeat == 382 then
		cancelTimer('spawn')
		runTimer('spawn', 0.125, 1000000)
	end
	if curBeat == 510 then
		cancelTimer('spawn')
	end
	if curBeat == 584 then
		runTimer('spawn', 0.025, 1000000)
	end
	if curBeat == 648 then
		cancelTimer('spawn')
		runTimer('spawn', 0.005, 1000000)
		setProperty('ravineFlash.visible', true)
	end
	if curBeat >= 648 and curBeat % 2 == 0 and curBeat <= 808 then
		playAnim('ravineFlash', 'pulse', true)
		thrust()
		for i = 0, 25 do
			makeSquare(getRandomFloat(-screenWidth * 0.9, screenWidth * 1.45), getRandomFloat(200, 600))
		end
	end
	if curBeat == 518 then
		setObjectCamera('white', 'camOther')
		doTweenAlpha('wher', 'white', 1, 0.5, 'sinIn')
		doTweenZoom('wow', 'camGame', 0.75, 0.5, 'sinIn')
		dadAlpha = getPropertyFromGroup('opponentStrums', 1, 'alpha')
		for i = 0, 3 do
			noteTweenAlpha('notePoo' .. i, i, 0, 0.4, 'sinIn')
		end
		for _, var in ipairs(alphaos) do
			doTweenAlpha(var, var, 0.001, 0.4, 'sinIn')
		end
	end
	if curBeat == 520 then
		doTweenAlpha('wher', 'white', 0, 2, 'sinOut')
		callOnLuas('customLoad', { 'bf', 'lucas' })
	end
	if curBeat == 582 then
		doTweenAlpha('wher', 'white', 1, 0.5, 'sinIn')
	end
	if curBeat == 584 then
		doTweenAlpha('wher', 'white', 0, 1, 'sinOut')
		for i = 0, 3 do
			noteTweenAlpha('notePoo' .. i, i, dadAlpha, 0.3, 'sinIn')
		end
		for _, var in ipairs(alphaos) do
			doTweenAlpha(var, var, 1, 0.4, 'sinIn')
		end
	end
	if curBeat == 808 then
		addLuaSprite('static', true);
		doTweenAlpha('static', 'static', 1, 1.5, 'linear')
	end
	if curBeat == 712 then
		cancelTimer('spawn')
		doTweenAlpha('what', 'acidtrip', 1, 0.25, 'linear')
	end
	if curBeat == 714 then
		for _, obj in ipairs(firstBG) do
			removeLuaSprite(obj, true)
		end
	end
	if curBeat == 816 then
		cameraFade('camHUD', '000000', 0.1, true)
		setProperty('camGame.visible', false)
	end
end

--partickes
function makeSquare(x, y, color)
	local val = 'sq' .. getRandomInt(0, 100000)
	local size = getRandomFloat(5, 40)
	local fadeTime = getRandomFloat(1.5, 3)
	if getRandomBool(60) then
		makeLuaSprite(val, nil, x, y)
		makeGraphic(val, 1, 1, '0xFF117CFF')
		scaleObject(val, size, size)
	else
		makeLuaSprite(val, 'fag/frag' .. getRandomInt(1, 6), x, y)
		scaleObject(val, getRandomFloat(0.3, 1), getRandomFloat(0.3, 1))
		setProperty(val .. '.color', getColorFromHex("128DFF"))
	end
	setObjectCamera(val, 'camGame')
	setBlendMode(val, 'add')
	addLuaSprite(val, true)
	setObjectOrder(val, getObjectOrder('bgfront'))
	setProperty(val .. '.velocity.y', getRandomFloat(-120, -400))
	setProperty(val .. '.velocity.x', getRandomFloat(-20, 20))
	setProperty(val .. '.acceleration.x', getRandomFloat(-20, 20))
	setProperty(val .. '.angularVelocity', getRandomFloat(-100, 100))
	setProperty(val .. '.acceleration.y', getRandomFloat(-150, 100))
	doTweenAlpha(val, val, 0, fadeTime, 'cubeIn')
	table.insert(particles, val)
	runTimer(val, fadeTime + 0.05)
end

function thrust()
	for _, a in ipairs(particles) do
		local thrust = getRandomFloat(-75, -350)
		setProperty(a .. '.velocity.y', getProperty(a .. '.velocity.y') + thrust * 2.5)
		setProperty(a .. '.acceleration.y', getProperty(a .. '.acceleration.y') - thrust * 1.75)
	end
end

function onTimerCompleted(tag)
	if tag:sub(1, 2) == 'sq' then
		for i = #particles, 1, -1 do
			if particles[i] == tag then
				table.remove(particles, i)
			end
		end
		removeLuaSprite(tag, true)
	end
	if tag == 'spawn' and not lowQuality then
		makeSquare(getRandomFloat(-screenWidth * 0.9, screenWidth * 1.45), getRandomFloat(290, 320))
	end
end
