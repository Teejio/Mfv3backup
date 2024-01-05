local v1, v2

function onEvent(name, value1, value2)
	if name == "Flash New" then
		v1 = (value1 ~= '') and value1 or 'hud'
		v2 = (value2 ~= '') and value2 or 0.5
		cameraFlash(tostring(v1), '0xFFFFFF', v2, true)
	end
end

function onCreatePost()
end
