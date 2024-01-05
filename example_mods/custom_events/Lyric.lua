 	function onCreate()
	 
	 makeLuaText('sunglyric','',0,screenWidth/2,screenHeight - 200);
	 setObjectCamera('sunglyric', 'hud')
	addLuaText('sunglyric');
	setTextSize('sunglyric',30);
	setTextAlignment('sunglyric','center')
	setProperty("sunglyric.x", screenWidth/2 - getTextWidth('sunglyric')/2)
	setTextColor('sunglyric', '0x00888888')
		if downscroll then
			setProperty("sunglyric.y", 200)
		end
	end
	function onEvent(n , v1 , v2)
		if n == 'Lyric' then
			setTextString('sunglyric', v1)
			setProperty("sunglyric.x", screenWidth/2 - getTextWidth('sunglyric')/2)
		end
		if n == 'DadSing' and (not songName == "Pick Up") then
			setTextString('sunglyric', v1)
			setProperty("sunglyric.x", screenWidth/2 - getTextWidth('sunglyric')/2)
		end
	end