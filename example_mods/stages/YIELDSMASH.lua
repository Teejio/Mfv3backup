stagefilelocation = 'YIELDSMASH'

function onCreate()
	createSprite('sky', 'cotpbackdrop', -1000 , -1000, 1.5, 1.5, 0.1,0.1,false)
	createSprite('ground', 'cotpground', -1500 , -500, 1, 1, 1,1,false)

	makeAnimatedLuaSprite('starmanbg', 'tripacid', -400 , -1000, -400);
	addAnimationByPrefix('starmanbg', 'tripacid idle','tripacid idle', 20, true);
	setScrollFactor('starmanbg', -0.7, -0.7);
	scaleObject('starmanbg', 7.0, 7.0);
	addLuaSprite('starmanbg', false);
	setProperty('starmanbg.antialiasing', false)
	setProperty('starmanbg.alpha', 0)
end

function createSprite(name, file, x , y, scaleX, scaleY, scrollX, scrollY, infront)
	makeLuaSprite(name, 'stages/' .. stagefilelocation..'/'.. file, x, y);
	setScrollFactor(name, scrollX, scrollY);
	scaleObject(name, scaleX, scaleY);
	addLuaSprite(name, infront);
	setProperty(name ..'.antialiasing', false)
end
