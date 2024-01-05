function hideHUD()
   doTweenAlpha('iconP2A', 'iconP2', 0, 0.1, 'linear')
   doTweenAlpha('iconP1A', 'iconP1', 0, 0.1, 'linear')

   doTweenAlpha('healthBar1', 'healthBar', 0, 0.1, 'linear')
   doTweenAlpha('healthBarBG1', 'healthBarBG', 0, 0.1, 'linear')

   doTweenAlpha('timeBar1', 'timeBar', 0, 0.1, 'linear')
   doTweenAlpha('timeBarBG1', 'timeBarBG', 0, 0.1, 'linear')

   doTweenAlpha('scoreTxt1', 'scoreTxt', 0, 0.1, 'linear')
   doTweenAlpha('timeTxt1', 'timeTxt', 0, 0.1, 'linear')

   setProperty("timeBarBG.visible", false);
   setProperty("timeBar.visible", false);
   setProperty("timeTxt.visible", false);
end

function unHideHUD()
   doTweenAlpha('iconP2B', 'iconP2', 1, 0.1, 'linear')
   doTweenAlpha('iconP1B', 'iconP1', 1, 0.1, 'linear')

   doTweenAlpha('healthBar2', 'healthBar', 1, 0.1, 'linear')
   doTweenAlpha('healthBarBG2', 'healthBarBG', 1, 0.1, 'linear')

   doTweenAlpha('timeBar2', 'timeBar', 1, 0.1, 'linear')
   doTweenAlpha('timeBarBG2', 'timeBarBG', 1, 0.1, 'linear')

   doTweenAlpha('scoreTxt2', 'scoreTxt', 1, 0.1, 'linear')
   doTweenAlpha('timeTxt2', 'timeTxt', 1, 0.1, 'linear')

   setProperty("timeBarBG.visible", true);
   setProperty("timeBar.visible", true);
   setProperty("timeTxt.visible", true);
end

function onBeatHit()
   if curBeat == 296 or curBeat == 560 then --Immersion Mode
      hideHUD()
   end

   if curBeat == 326 then
      cameraShake('camGame', 0.05, 0.3);
   end

   if curBeat == 326 then
      unHideHUD()
   end
end

function onUpdatePost()
   if curStep >= 1307 and curStep <= 1315 then
      playAnim('boyfriend', 'eletricuted', false)
      setProperty('boyfriend.specialAnim', true)
      setProperty('healthy', math.max(getProperty('healthy') - 0.015, 0.05))
      cameraShake('camGame', 0.02, 0.025)
      cameraShake('camHUD', 0.005, 0.025)
      setProperty('boyfriend.x', defaultBoyfriendX + 30 * math.sin(getSongPosition() / 5))
   end
end

function onStepHit()
   if curStep == 1307 then
      setProperty('boyfriend.skipDance', true)
   end
   if curStep == 1316 then
      playAnim('boyfriend', 'singRIGHTmiss', true, false, 1)
      setProperty('boyfriend.specialAnim', true)
   end
   if curStep == 1444 then
      setProperty('boyfriend.skipDance', false)
   end
end
