local dir = "stages/angeles/"
function onCreate()
	-- background shit

	makeLuaSprite('Sky', dir .. 'LAsky', -800, -600)
	setScrollFactor('Sky', 0, 0)

	makeLuaSprite('FarCity', dir .. 'LAcity far', -650, -350)
	setScrollFactor('FarCity', 0.8, 0.8)

	makeLuaSprite('NearCity', dir .. 'LAcity back', -650, -50)
	setScrollFactor('NearCity', 0.6, 0.6)
	makeLuaSprite('House', dir .. 'LAlive house', 200, -725)
	makeLuaSprite('Street', dir .. 'LAstreet', -850, -450)
	scaleObject("Street", 1.1, 1.1)

	addLuaSprite('Sky')
	addLuaSprite('FarCity')
	addLuaSprite('NearCity')
	addLuaSprite('Street')
	addLuaSprite('House')
end

function onCreatePost()
	setProperty('camGame.height', getProperty('camGame.height') - 150)
	setProperty('camGame.y', 75)
	if not downscroll then
		for i = 0, 7 do
			setPropertyFromGroup('strumLineNotes', i, 'y', defaultPlayerStrumY0 + 25)
		end

		setProperty('healthBar.y', getProperty('healthBar.y') - 25)
		setProperty('iconP1.y', getProperty('iconP1.y') - 25)
		setProperty('iconP2.y', getProperty('iconP2.y') - 25)
	else
		for i = 0, 7 do
			setPropertyFromGroup('strumLineNotes', i, 'y', defaultPlayerStrumY0 - 30)
		end
	end
end
