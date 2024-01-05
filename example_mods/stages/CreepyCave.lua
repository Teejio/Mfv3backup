--Script redone by ferzy

local TargetAlpha, alpha = 0, 0
local HudStuff = { 'iconP1', 'iconP2', 'timeBar', 'timeBarBG', 'timeTxt', 'healthBar', 'healthBarBG', 'scoreTxt' }

local playerzoom = 0.75
local opponentzoom = 1.2
local zoomspeed = 0.6
function onCreate()
	makeLuaSprite('CreepyBack', 'stages/gieguebg/giedark', -600, -300);
	setScrollFactor('CreepyBack', 0.4, 0.4);
	scaleObject('CreepyBack', 1.6, 1.6);

	makeLuaSprite('CreepyStage', 'stages/gieguebg/giegue platform', -1000, -900);
	setScrollFactor('CreepyStage', 1.0, 1.0);
	scaleObject('CreepyStage', 2, 2);

	makeLuaSprite('CreepyOverlay', 'stages/gieguebg/CreepyOverlay', -600, -300);
	setScrollFactor('CreepyOverlay', 1.0, 1.0);
	scaleObject('CreepyOverlay', 1.6, 1.6);


	addLuaSprite('CreepyBack', false);
	addLuaSprite('CreepyStage', false);

	makeAnimatedLuaSprite('rainbow', 'stages/gieguebg/rainbow', -300, -300);

	if flashingLights == true then
		luaSpriteAddAnimationByPrefix('rainbow', 'rainbow', 'frame', 6, true);
	else
		luaSpriteAddAnimationByPrefix('rainbow', 'rainbow', 'bingus', 6, true);
	end
	setScrollFactor('rainbow', 0.05, 0.05);
	scaleObject('rainbow', 10.0, 5.100);
	addLuaSprite('rainbow', false);
end

function Intro()
	makeLuaSprite('black', nil, -10, -10)
	makeGraphic('black', 1, 1, '0xFF000000')
	scaleObject('black', screenWidth * 1.5, screenHeight * 1.5)
	setObjectCamera('black', 'camOther')
	addLuaSprite('black', false)
	for _, var in ipairs(HudStuff) do
		setProperty(var .. '.alpha', 0)
	end
	for i = 0, 7 do
		setPropertyFromGroup('strumLineNotes', i, 'visible', false)
	end
end

function onCreatePost()
	if songPath == 'dissonance' then
		Intro()
	end
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
		doTweenZoom('zoom', 'camGame', targetZoom, zoomspeed / playbackRate, 'quadOut')
		oldtarget = targetZoom
	end
	setProperty('defaultCamZoom', targetZoom)
end

function onSongStart()
	doTweenAlpha('show', 'black', 0, 8, 'sinIn')
end

function onBeatHit()
	if curBeat == 4 then
		for i = 0, 7 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
			if i > 3 then
				setPropertyFromGroup('strumLineNotes', i, 'visible', true)
			end
		end
	end
	if curBeat == 62 then
		for i = 4, 7 do
			noteTweenAlpha('appear' .. i, i, 1, 1, 'sinOut')
		end
	end
	if curBeat == 97 then
		triggerEvent('Add Camera Zoom', '0.5', '0.4')
		for _, var in ipairs(HudStuff) do
			doTweenAlpha(var .. '.alpha', var, 1, 0.2, 'sinOut')
		end
	end
end

function onUpdatePost()
	setProperty('healthBar.flipX', true)
	alpha = ((TargetAlpha - alpha) / 10) + alpha
	setProperty('rainbow.alpha', alpha)
	setProperty('iconP1.flipX', true)
	setProperty('iconP2.flipX', true)
end

function onEvent(n, value1, value2)
	if n == 'RainbowON' then
		TargetAlpha = 1
	end
	if n == 'RainbowOFF' then
		TargetAlpha = 0
	end
end
