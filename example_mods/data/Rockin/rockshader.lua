--script by Ferzy
local shaderTog = false

function onCreate()
    makeLuaSprite('dark', 'overlay/blue' , -500, -500);
	scaleObject('dark', 2, 2);
    setScrollFactor('dark', 0,0)
	setObjectCamera('dark', 'game')
	setProperty('dark.alpha', 0);
	setBlendMode('dark', 'multiply')
	addLuaSprite('dark', true);
end



function onUpdatePost(elapsed)
    if shaderTog then
        setProperty('clorsap.hue', (0.05 * math.cos(getSongPosition() / 1000)))
    end
end



function onBeatHit()
	if curBeat == 164 then
        setProperty('clorsap.hue', -0.06)
        setProperty('clorsap.brightness', 0.25)

        shaderTog = true
	end

	--TO TIME THE WOW! EFFECT
	if (curBeat == 265) then
        setProperty('clorsap.hue', -0.06)
        setProperty('clorsap.brightness', 0)
        shaderTog = false
	end
    if curBeat == 264 then
        debugPrint('darkening')
        doTweenAlpha('fas', 'dark', 0.7, (crochet/1000)*95, 'linear')
        doTweenColor('das', 'BackOmlet', '8E8EF4', (crochet/1000)*100, 'linear')
    end
end
