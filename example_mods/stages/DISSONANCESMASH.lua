stagefilelocation = 'scarycavesmash'

function onCreate()
	createSprite('mothership', 'mothership', 0, 1000, 1.5, 1.5, 1, 0.9, false)
	createSprite('ground', 'ground', 0, 0, 1.5, 1.5, 1, 1, false)

	makeAnimatedLuaSprite('crew', 'stages/scarycavesmash/crew', 450, 500)
	scaleObject('crew', 1.2, 1.2)
	addAnimationByPrefix('crew', 'crew', 'crew', 24, true)
	addLuaSprite('crew', true)

	makeAnimatedLuaSprite('rainbow', 'stages/gieguebg/rainbow', -300, -300);

	if flashingLights == true then
		luaSpriteAddAnimationByPrefix('rainbow', 'rainbow','frame', 6, true);
	else 
		luaSpriteAddAnimationByPrefix('rainbow', 'rainbow','bingus', 6, true);
	end
	setScrollFactor('rainbow', 0.05, 0.05);
	scaleObject('rainbow', 10.0, 5.100);
	setProperty('rainbow.alpha', 0)
	addLuaSprite('rainbow', false);
end

function onCreatePost()
	setProperty('camGame.alpha', 0)
	setProperty('camHUD.alpha', 0)
end

function createSprite(name, file, x , y, scaleX, scaleY, scrollX, scrollY, infront)
	makeLuaSprite(name, 'stages/' .. stagefilelocation..'/'.. file, x, y);
	setScrollFactor(name, scrollX, scrollY);
	scaleObject(name, scaleX, scaleY);
	addLuaSprite(name, infront);
	setProperty(name ..'.antialiasing', false)
end

shaggy = false
function onUpdate()
	setProperty('dad.y', -750 + 40 * math.sin(getSongPosition() / 750))

	if shaggy == true then
		setProperty('dad.x', 870 + 100 * math.sin(getSongPosition() / (750 / 2)))
	end
end

function onStepHit()
	if curStep == 8 then
		noteTweenAlpha('0', 0, 0, 0.1, 'linear')
		noteTweenAlpha('1', 1, 0, 0.1, 'linear')
		noteTweenAlpha('2', 2, 0, 0.1, 'linear')
		noteTweenAlpha('3', 3, 0, 0.1, 'linear')
	elseif curStep == 112 then
		doTweenAlpha('camGame', 'camGame', 1, 2.5, 'quadInOut')
	elseif curStep == 176 then
		doTweenY('mothership', 'mothership', -1500, 7.5, 'quadOut')
	elseif curStep == 232 then
		doTweenY('crew', 'crew', -100, 2.5, 'quadOut')
	elseif curStep == 368 then
		doTweenAlpha('camHud', 'camHUD', 1, 2.5, 'quadInOut')
	elseif curStep == 1856 then
		doTweenAlpha('mothership', 'mothership', 0, 0.5, 'quadOut')
		doTweenAlpha('ground', 'ground', 0, 0.5, 'quadOut')
		doTweenAlpha('crew', 'crew', 0, 0.5, 'quadOut')
		doTweenAlpha('rainbow', 'rainbow', 1, 0.5, 'quadOut')
	elseif curStep == 1984 then
		shaggy = true
		doTweenAlpha('mothership', 'mothership', 1, 0.5, 'quadOut')
		doTweenAlpha('ground', 'ground', 1, 0.5, 'quadOut')
		doTweenAlpha('crew', 'crew', 1, 0.5, 'quadOut')
		doTweenAlpha('rainbow', 'rainbow', 0, 0.5, 'quadOut')
	elseif curStep == 3296 then
		doTweenAlpha('mothership', 'mothership', 0, 0.5, 'quadOut')
		doTweenAlpha('ground', 'ground', 0, 0.5, 'quadOut')
		doTweenAlpha('crew', 'crew', 0, 0.5, 'quadOut')
		doTweenAlpha('rainbow', 'rainbow', 1, 0.5, 'quadOut')
		shaggy = false
		doTweenX('dadxgo', 'dad', 870, 5, 'quadOut')
	elseif curStep == 3552 then
		doTweenAlpha('crew', 'crew', 1, 5, 'quadOut')
	elseif curStep == 3808 then
		doTweenAlpha('mothership', 'mothership', 1, 0.5, 'quadOut')
		doTweenAlpha('ground', 'ground', 1, 0.5, 'quadOut')
		doTweenAlpha('rainbow', 'rainbow', 0, 0.5, 'quadOut')
	end
end