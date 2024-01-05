function onEvent(name, v1, v2)
	if name == 'psithunder' then
		makeAnimatedLuaSprite('psithunder', 'stages/gieguebg/psi_thunder', 80, 20)
		addAnimationByPrefix('psithunder', 'psithunder', 'psi_thunder', 24, false)
		setObjectCamera('psithunder', 'camhud')
		objectPlayAnimation('psithunder', 'psi_thunder', true)
		addLuaSprite('psithunder', true)

		if downscroll then
			setProperty('psithunder.flipY', true)
		end
	end
end