function onCreate()
	-- background shit
	makeAnimatedLuaSprite('AcidTrip', 'AcidTrip', -1200, -300);
	luaSpriteAddAnimationByPrefix('AcidTrip', 'AcidTrip','AcidTrip idle', 24, true);
	setScrollFactor('AcidTrip', 0.9, 0.9);
	scaleObject('AcidTrip', 5.0, 5.0);
	
	addLuaSprite('AcidTrip', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end