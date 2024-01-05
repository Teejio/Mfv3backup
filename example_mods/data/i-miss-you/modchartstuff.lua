setProperty('skipCountdown', true)
local scary = true
function onCreatePost()
	setProperty('camHUD.alpha', 0)
	cameraFlash('camGame', '000000', crochet / 1000 * 24)
	setProperty('boyfriend.skipDance', true)
	playAnim('boyfriend', 'show', true)
	setProperty('boyfriend.animation.curAnim.frameRate', 0)
end
function onSongStart()
	doTweenZoom('cazoomie', 'camGame', 0.9, crochet / 1000 * 64 / playbackRate, 'expoIn')
end
function onUpdatePost()
	if scary then
		setProperty('force', (getProperty('camGame.zoom') - 0.45) * 1.25)
		setProperty('strength', (getProperty('camGame.zoom') - 0.6) * 0.35)
		setProperty('bloom', (getProperty('camGame.zoom')) * -0.45)

	end
end

function onTweenCompleted(tag)
	if tag == 'cazoomie' then
		scary = false
		setProperty('boyfriend.specialAnim', true)
		setProperty('boyfriend.animation.curAnim.frameRate', 24)
		setProperty('boyfriend.skipDance', false)
	end
end

function onStepHit()
	if curStep == 256 then
		toggled = false
		doTweenAlpha('camHUDalpha', 'camHUD', 1, 1, 'circOut')
	elseif curStep == 408 then
		toggled = true
	elseif curStep == 728 then
		speed = 2
		intensity = 0.5
	end
end
