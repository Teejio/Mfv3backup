stagefilelocation = 'dexter'

function onCreate()
	createSprite('sky', 'nerdSky', 0 , -300, 2, 2, 0.1,0.1,false)
	createSprite('back', 'nerdMountainBack', 0 , -200, 2, 2, 0.25,0.25,false)
	createSprite('mountain', 'nerdMountain', 0 , -50, 2, 2, 0.5,0.5,false)
	createSprite('roof', 'roof', 0 , 0, 2, 2, 1,1,false)


		makeLuaSprite('blue', 'overlay/actuallyblue' , 0, 0);
	addLuaSprite('blue', true);
	scaleObject('blue', .75, .75);
	setObjectCamera('blue', 'other')
	setProperty('blue.alpha', 0.25);
end

function createSprite(name, file, x , y, scaleX, scaleY, scrollX, scrollY, infront)
	makeLuaSprite(name, 'stages/' .. stagefilelocation..'/'.. file, x, y);
	setScrollFactor(name, scrollX, scrollY);
	scaleObject(name, scaleX, scaleY);
	addLuaSprite(name, infront);
	setProperty(name ..'.antialiasing', false)
end
