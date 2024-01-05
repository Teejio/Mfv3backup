function onCreate()
	-- background shit
	makeLuaSprite('BackOmlet', 'stages/ness/BackOmlet', -600, -300);
	setScrollFactor('BackOmlet', 0.5, 0.5);
	scaleObject('BackOmlet', 1.6, 1.6);

	makeLuaSprite('FrontOmlet', 'stages/ness/FrontOmlet', -600, -300);
	setScrollFactor('FrontOmlet', 1.0, 1.0);
	scaleObject('FrontOmlet', 1.6, 1.6);

	addLuaSprite('BackOmlet', false);
	addLuaSprite('FrontOmlet', false);

	makeAnimatedLuaSprite('AcidTrip', 'stages/ness/AcidTrip', -800, -300);
	luaSpriteAddAnimationByPrefix('AcidTrip', 'AcidTrip', 'AcidTrip idle', 24, true);
	setScrollFactor('AcidTrip', 0.5, 0.5);
	scaleObject('AcidTrip', 6.0, 6.0);

	addLuaSprite('AcidTrip', false);
	setProperty('AcidTrip.antialiasing', false);
	setProperty('AcidTrip.visible', false);
end

function onBeatHit()
	if (curBeat == 164) then
		setProperty('camGame.zoom', 2);
		cameraFlash('other', '0xFFFFFF', 1, true)
		setProperty('AcidTrip.visible', true);
		triggerEvent('ToggleShader', '', '')
	end

	--TO TIME THE WOW! EFFECT
	if (curBeat == 265) then
		cameraFlash('other', '0xFFFFFF', 1, true)
		setProperty('AcidTrip.visible', false);
	end
end
