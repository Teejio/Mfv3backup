local disappear = { 'iconP1', 'iconP2', 'timeBarBG', 'timeBar','timeTxt', 'healthBar', 'healthBarBG', 'scoreTxt', 'dad' }
function onCreatePost()

	makeLuaSprite('whitebg', '', 0, 0)
	setScrollFactor('whitebg', 0, 0)
	makeGraphic('whitebg', 1, 1, 'ffffff')
	scaleObject('whitebg', 3840, 2160)
	updateHitbox('whitebg')
	addLuaSprite('whitebg', false)
	setProperty('whitebg.alpha', 0)
	screenCenter('whitebg')
	setObjectOrder('whitebg', getObjectOrder('dadGroup') - 1)
end

function onEvent(n, v1, v2)
	if n == 'disaper' and string.lower(v1) == 'a' then
		doTweenAlpha('whitene', 'whitebg', 1, v2, 'linear')
		for i = 1, #disappear do
			setProperty(disappear[i] .. '.visible', false)
		end
		for i = 0,3 do
			setPropertyFromGroup('opponentStrums', i, 'alpha', 0)
		end
		doTweenColor('woh', 'boyfriend', '000000', v2, 'linear')
	end
	if n == 'disaper' and string.lower(v1) == 'b' then
		doTweenAlpha('whitene', 'whitebg', 0, v2, 'linear')
		for i = 1, #disappear do
			setProperty(disappear[i] .. '.visible', true)
		end
		for i = 0,3 do
			setPropertyFromGroup('opponentStrums', i, 'alpha', 1)
		end
		doTweenColor('woh', 'boyfriend', 'FFFFFF', v2, 'linear')
	end
end
