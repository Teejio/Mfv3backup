function onCreate()
	-- background shit
	makeLuaSprite('murasaki', 'murasaki', 0, 0);
	setScrollFactor('murasaki', 1, 1);
	scaleObject('murasaki', 6.0, 6.0);
	setProperty('murasaki.antialiasing', false)
	addLuaSprite('murasaki', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end