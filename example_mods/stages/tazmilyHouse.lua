function onCreate()
	-- background shit

        makeLuaSprite('skyHigh', 'stages/lucas/skyHigh', -150, 50);
	setScrollFactor('skyHigh', 0.8, 0.8);
	scaleObject('skyHigh', 1.5, 1.5);

	makeLuaSprite('backField', 'stages/lucas/backField', 0, 20);
	setScrollFactor('backField', 1.0, 1.0);
	scaleObject('backField', 1.5, 1.3);	

    makeLuaSprite('daHouse', 'stages/lucas/daHouse', -100, -250);
	setScrollFactor('daHouse', 1.0, 1.0);
	scaleObject('daHouse', 1.4, 1.4);

	makeLuaSprite('ship', 'stages/lucas/ship', 1800, 20);
	setScrollFactor('ship', 0.2, 0.2);

        --layering
	addLuaSprite('skyHigh', false);
	addLuaSprite('ship', false)
	addLuaSprite('backField', false);
	addLuaSprite('daHouse', false);    
	
        close(true); 
        
end

function onCreatePost()
	-- end of "create"
      
end