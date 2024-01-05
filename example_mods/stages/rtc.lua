function onCreate()
	makeLuaSprite('bg', 'stages/rtc/bg', -500, -700)
	scaleObject('bg', 1, 1)
	setScrollFactor('bg', 0.01, 0.01)
	addLuaSprite('bg', false)

	makeAnimatedLuaSprite('bg2', 'stages/rtc/giygas_static', -500, 0)
	addAnimationByPrefix('bg2', 'giygas static', 'giygas static', 24, true)
	setProperty('bg2.alpha', 0)
	scaleObject('bg2', 2, 2)
	addLuaSprite('bg2', false)

	makeLuaSprite('ground', 'stages/rtc/ground', -1000, 240)
	scaleObject('ground', 1, 1)
	addLuaSprite('ground', false)

	makeLuaSprite('trees', 'stages/rtc/trees', -1100, -700)
	scaleObject('trees', 1, 1)
	setScrollFactor('trees', 0.75, 0.75)
	addLuaSprite('trees', false)

	makeLuaSprite('mushrooms', 'stages/rtc/mushrooms', 400, 500)
	scaleObject('mushrooms', 1, 1)
	setScrollFactor('mushrooms', 0.75, 0.75)
	addLuaSprite('mushrooms', false)

	makeLuaSprite('groundscary', 'stages/rtc/groundscary', -1000, 240)
	scaleObject('groundscary', 1, 1)
	addLuaSprite('groundscary', false)
	setProperty('groundscary.alpha', 0)

	makeLuaSprite('treesscary', 'stages/rtc/treesscary', -1100, -700)
	scaleObject('treesscary', 1, 1)
	setScrollFactor('treesscary', 0.75, 0.75)
	addLuaSprite('treesscary', false)
	setProperty('treesscary.alpha', 0)

	makeLuaSprite('mushroomsscary', 'stages/rtc/mushroomsscary', 400, 500)
	scaleObject('mushroomsscary', 1, 1)
	setScrollFactor('mushroomsscary', 0.75, 0.75)
	addLuaSprite('mushroomsscary', false)
	setProperty('mushroomsscary.alpha', 0)

	makeAnimatedLuaSprite('static', 'stages/rtc/giygas_static', 0, 0)
	addAnimationByPrefix('static', 'giygas static', 'giygas static', 24, true)
	setProperty('static.alpha', 0)
	scaleObject('static', 2, 2)
	setObjectCamera('static', 'other')
	addLuaSprite('static', true)

	makeLuaSprite('streamerbg', 'stages/rtc/streamerbg', 925, 400)
	setObjectCamera('streamerbg', 'other')
	scaleObject('streamerbg', 0.3, 0.25)
	addLuaSprite('streamerbg', false)

	makeLuaSprite('ded', 'stages/rtc/vinny_ded_yippieeeee', 925, 350)
	setObjectCamera('ded', 'other')
	scaleObject('ded', 0.2, 0.3)
	addLuaSprite('ded', true)
	setProperty('ded.alpha', 0)
end

function onCreatePost()
	setObjectCamera('boyfriend', 'other')
	setProperty('boyfriend.x', 900)
	setProperty('boyfriend.y', 370)
end

function onSongStart()
	bfx = getProperty('boyfriend.x')
	bfy = getProperty('boyfriend.y')

	notePosX4 = getPropertyFromGroup('playerStrums', 0, 'x')
	notePosX5 = getPropertyFromGroup('playerStrums', 1, 'x')
	notePosX6 = getPropertyFromGroup('playerStrums', 2, 'x')
	notePosX7 = getPropertyFromGroup('playerStrums', 3, 'x')
	
	noteTweenAlpha('0', 0, 0, 1, 'linear')
	noteTweenAlpha('1', 1, 0, 1, 'linear')
	noteTweenAlpha('2', 2, 0, 1, 'linear')
	noteTweenAlpha('3', 3, 0, 1, 'linear')

	noteTweenX('4', 4, notePosX4 - 320, 1, 'quadInOut')
	noteTweenX('5', 5, notePosX5 - 320, 1, 'quadInOut')
	noteTweenX('6', 6, notePosX6 - 320, 1, 'quadInOut')
	noteTweenX('7', 7, notePosX7 - 320, 1, 'quadInOut')
end

function setAlpha(value)
	setProperty('bg.alpha', value)
	setProperty('ground.alpha', value)
	setProperty('trees.alpha', value)
	setProperty('mushrooms.alpha', value)
end

function setAlphascary(value)
	setProperty('groundscary.alpha', value)
	setProperty('treesscary.alpha', value)
	setProperty('mushroomsscary.alpha', value)
end

function onStepHit()
	if curStep == 526 then
		doTweenAlpha('staticalpha', 'static', 1, 0.1, 'quadIn')
	elseif curStep == 528 then
		doTweenAlpha('staticalpha', 'static', 0, 1, 'quadOut')
	elseif curStep == 1030 then
		doTweenAlpha('staticalpha', 'static', 1, 1, 'quadIn')
	elseif curStep == 1036 then
		doTweenAlpha('camgamealpha', 'camGame', 0, 0.01, 'linear')
	elseif curStep == 1040 then
		setAlpha(0)
		setAlphascary(1)

		doTweenAlpha('staticalpha', 'static', 0, 1, 'quadIn')

		doTweenAlpha('camgamealpha', 'camGame', 1, 5, 'quadInOut')
		doTweenAlpha('camhudalpha', 'camHUD', 0.5, 5, 'quadInOut')
	elseif curStep == 1580 then
		doTweenAlpha('camgamealpha', 'camGame', 0, 0.01, 'quadInOut')
		doTweenAlpha('camhudalpha', 'camHUD', 0.5, 0.01, 'quadInOut')
		doTweenAlpha('staticalpha', 'static', 1, 0.25, 'quadIn')
	elseif curStep == 1584 then
		doTweenAlpha('staticalpha', 'static', 0.1, 0.25, 'quadIn')
		setAlpha(1)
		setAlphascary(0)

		setProperty('bg.alpha', 0)
		setProperty('bg2.alpha', 1)

		doTweenAlpha('camgamealpha', 'camGame', 1, 1, 'quadInOut')
		doTweenAlpha('camhudalpha', 'camHUD', 1, 1, 'quadInOut')
	elseif curStep == 2364 then
		doTweenAlpha('staticalpha', 'static', 1, 0.3, 'quadIn')
	elseif curStep == 2368 then
		setAlpha(0)
		setProperty('gf.alpha', 0)
		setProperty('dad.alpha', 0)
		setProperty('boyfriend.alpha', 0)
		setProperty('ded.alpha', 1)
		setProperty('bg2.alpha', 0)
		setProperty('streamerbg.alpha', 0)
		setProperty('camHUD.alpha', 0)
		doTweenAlpha('staticalpha', 'static', 0, 0.3, 'quadOut')
	end
end