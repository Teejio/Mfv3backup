function onCreate()
	-- background shit
	makeAnimatedLuaSprite('giygasbg', 'stages/poopypants/giygasbg', -500, -300);
	luaSpriteAddAnimationByPrefix('giygasbg', 'giygasbg','giygas', 24, true);
	setScrollFactor('giygasbg', 0.05, 0.05);
	scaleObject('giygasbg', 5.0, 5.0);
	
	addLuaSprite('giygasbg', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end