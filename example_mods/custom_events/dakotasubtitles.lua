function onEvent(name, val1, val2)
	if name == 'dakotasubtitles' then
		textname = getSongPosition()

		if val2 == 'left' then
			xpos = -1000
			destinationx = 1500
		else
			xpos = 1500
			destinationx = -1000
		end

		ypos = math.random(0, 650)

		makeLuaText(textname, val1, 0, xpos, ypos)
		setObjectCamera(textname, 'other')
		scaleObject(textname, 5, 5)
		setProperty(textname .. '.alpha', 0.4)
		addLuaText(textname, true)

		doTweenX(textname .. 'fly', textname, destinationx, 1.5, 'linear')
	end
end