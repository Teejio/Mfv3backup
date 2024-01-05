time = 1
stagefilelocation = 'Tent'

function onCreate()
	-- background shit
	createSprite('tent', 'threedTent', -100, -220, 1, 1, 1, 1, false)
	--For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage

	makeAnimatedLuaSprite('circus', 'stages/Tent/glitchbox', 0, 0)
	setObjectCamera('circus', 'other')
	addAnimationByPrefix('circus', 'text box glitch', 'text box glitch', 24, false)
	scaleObject('circus', 0.75, 0.75)
	screenCenter('circus')
	addLuaSprite('circus', true)
end

function createSprite(name, file, x, y, scaleX, scaleY, scrollX, scrollY, infront)
	makeLuaSprite(name, 'stages/' .. stagefilelocation .. '/' .. file, x, y);
	setScrollFactor(name, scrollX, scrollY);
	scaleObject(name, scaleX, scaleY);
	addLuaSprite(name, infront);
	setProperty(name .. '.antialiasing', false)
end

function createAnimSprite(name, file, x, y, scaleX, scaleY, scrollX, scrollY, infront, anim)
	makeAnimatedLuaSprite(name, 'stages/' .. stagefilelocation .. '/' .. file, x, y);
	luaSpriteAddAnimationByPrefix(name, anim, anim, 24, true);
	setScrollFactor(name, scrollX, scrollY);
	scaleObject(name, scaleX, scaleY);
	addLuaSprite(name, infront);
	setProperty(name .. '.antialiasing', false)
end

function onCreatePost()
	fix = not getPropertyFromClass('ClientPrefs', 'fixmiddleScroll')
	if (not middlescroll or fix) then
		setPropertyFromGroup('opponentStrums', 0, 'x', defaultPlayerStrumX0 + 1)
		setPropertyFromGroup('opponentStrums', 1, 'x', defaultPlayerStrumX1 + 1)
		setPropertyFromGroup('opponentStrums', 2, 'x', defaultPlayerStrumX2 + 1)
		setPropertyFromGroup('opponentStrums', 3, 'x', defaultPlayerStrumX3 + 1)
		setPropertyFromGroup('playerStrums', 0, 'x', defaultOpponentStrumX0 + 1)
		setPropertyFromGroup('playerStrums', 1, 'x', defaultOpponentStrumX1 + 1)
		setPropertyFromGroup('playerStrums', 2, 'x', defaultOpponentStrumX2 + 1)
		setPropertyFromGroup('playerStrums', 3, 'x', defaultOpponentStrumX3 + 1)
		setPropertyFromGroup('playerStrums', 4, 'x', defaultOpponentStrumX4 + 1)
	end
	close(true)
end

function onUpdatePost()
	-- thx Unholywanderer04 for the health flip
	setProperty('healthBar.flipX', true)
	P1Mult = getProperty('healthBar.x') +
	((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26)

	P2Mult = getProperty('healthBar.x') +
	((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2)

	setProperty('iconP1.x', P1Mult - 110)

	setProperty('iconP1.origin.x', 240)

	setProperty('iconP1.flipX', true)

	setProperty('iconP2.x', P2Mult + 110)

	setProperty('iconP2.origin.x', -100)

	setProperty('iconP2.flipX', true)
end
