--by sirFerzy
local darTurn = false
local beats = { 140, 141, 142, 143, 156, 157, 158, 159, 172, 173, 174, 175, 188, 189, 190, 191, 460, 461,
   462, 463, 464, 476, 477, 478, 479, 480, 492, 493, 494, 495, 496, 508, 509, 510, 511 }
local bigBeats = { 144, 160, 176, 448, 464, 480, 496 }
function onCreatePost()
   luaDebugMode = true
   runHaxeCode([[
   var darnell:Character;
   var blue:Character;

	darnell = new Character(1550, -75, 'Darnell', true);
	game.addBehindDad(darnell);
	setVar('darnell', darnell);


   blue = new Character(-20, -200, 'BBGang', false);
	game.addBehindDad(blue);
	setVar('blue', blue);

   ]])
   makeAnimatedLuaSprite('nene', 'stages/angeles/Nene', 650, 150)
   addAnimationByPrefix('nene', 'idle', 'Nene instance 1', 24, false)
   addLuaSprite('nene')
   setObjectOrder('nene', getObjectOrder('gfGroup'))
   setObjectOrder("darnell", getObjectOrder('House'))
   setObjectOrder("blue", getObjectOrder('House'))
end

function doIdle()
   playAnim('nene', 'idle')
   callMethod('darnell.dance')
   callMethod('blue.dance')
end

function onSongStart()
   doIdle()
end

function onCountdownTick(tag)
   if tag == 2 or tag == 0 then
      doIdle()
   end
end

function onBeatHit()
   if curBeat % 2 == 0 then
      doIdle()
   end
   if curBeat == 125 then
      doTweenAlpha('dad', 'dad', 0.5, 0.5, 'sinOut')
      doTweenAlpha('boyfriend', 'boyfriend', 0.5, 0.5, 'sinOut')
      doTweenAlpha('cam', 'camHUD', 0.5, 0.5, 'sinOut')
      doTweenZoom('show', 'camGame', 0.45, 0.25, 'sinOut')
      triggerEvent("Camera Follow Pos", 900, 300)
      setProperty('darnell.origin.x', getProperty('darnell.width') / 2)
      setProperty('darnell.origin.y', 0)
      setProperty('blue.origin.x', getProperty('blue.width') / 2)
      setProperty('blue.origin.y', 0)
      callMethod('darnell.playAnim', { "startSpin", true })
      callMethod('blue.playAnim', { "startSpin", true })
      setProperty('defaultCamZoom', 0.55)
   end
   if curBeat == 126 then
      setProperty('darnell.idleSuffix', "-alt")
      setProperty('blue.idleSuffix', "-alt")
      callMethod('darnell.playAnim', { "loopSpin", true })
      callMethod('blue.playAnim', { "loopSpin", true })
      setProperty('darnell.angle', -25)
      setProperty('blue.angle', 25)
      setProperty('blue.x', getProperty('blue.x') + 100)
      startTween('move', 'darnell', { x = getProperty('darnell.x') + 200, angle = -50 }, crochet / 1000 / playbackRate,
         { ease = 'cubeOut' })
      startTween('moveB', 'blue', { x = getProperty('blue.x') - 180, angle = 50 }, crochet / 1000 / playbackRate,
         { ease = 'cubeOut' })
      startTween('move2', 'darnell', { y = getProperty('darnell.y') + 100 }, crochet / 500 / playbackRate,
         { ease = 'cubeOut' })
      startTween('moveB2', 'blue', { y = getProperty('blue.y') + 100 }, crochet / 500 / playbackRate,
         { ease = 'cubeOut' })
      setObjectOrder("darnell", getObjectOrder('House') + 1)
      setObjectOrder("blue", getObjectOrder('House') + 1)
   end
   if curBeat == 127 then
      startTween('move', 'darnell', { x = getProperty('darnell.x') - 250, angle = 0 }, crochet / 1000 / playbackRate,
         { ease = 'cubeIn' })
      startTween('moveB', 'blue', { x = getProperty('blue.x') + 125, angle = 0 }, crochet / 1000 / playbackRate,
         { ease = 'cubeIn' })
   end
   if curBeat == 128 then
      cancelTween('move')
      cancelTween('moveB')
      setProperty('darnell.angle', 0)
      setProperty('blue.angle', 0)
      triggerEvent("Camera Follow Pos", "", "")
      doTweenAlpha('dad', 'dad', 1, 0.25, 'sinOut')
      doTweenAlpha('boyfriend', 'boyfriend', 1, 0.25, 'sinOut')
      doTweenAlpha('cam', 'camHUD', 1, 0.25, 'sinOut')
      setProperty('defaultCamZoom', 0.55)
      darnShoot()
      blueShoot()
      setProperty('strength', 3)
      setProperty('force', -3.5)
      setProperty('bloom', 0.6)
   end

   for _, beat in ipairs(beats) do
      if curBeat == beat then
         if darTurn then
            setProperty('force', -1.5)
            darnShoot(true)
         else
            blueShoot(true)
            setProperty('force', 1.5)
         end
         setProperty('bloom', 0.2)

         darTurn = not darTurn
         setProperty('strength', 1)
      end
   end
   for _, beat in ipairs(bigBeats) do
      if curBeat == beat then
         darnShoot(false)
         blueShoot(false)
         setProperty('strength', 2)
         setProperty('force', 2)
         setProperty('bloom', 0.5)
      end
   end
end

function darnShoot(canDodge)
   local var = "ek" .. math.floor((getRandomFloat(1, 4000) * 100))
   makeLuaSprite(var, nil, -810, 275)
   makeGraphic(var, 2000, 7, 'FFFFFF')
   setProperty(var .. '.origin.x', 2000)
   setProperty(var .. '.origin.y', 7 / 2)
   setProperty(var .. '.angle', getRandomFloat(-5, 5))
   startTween(var, var, { alpha = 0, x = -850 }, 0.3 / playbackRate, { ease = 'sinIn', type = 'ONESHOT' })
   startTween(var .. '1', var .. '.scale', { y = 3 }, 0.2 / playbackRate, { ease = 'sinOut', type = 'ONESHOT' })
   if getRandomBool(75) and canDodge then
      setObjectOrder(var, getObjectOrder("blue") + 1)
      callMethod('blue.playAnim', { "dodge", true })
   end
   addLuaSprite(var)
   callMethod('darnell.playAnim', { "shoot", true })
end

function blueShoot(canDodge)
   local var = "bul" .. math.floor((getRandomFloat(1, 4000) * 100))
   makeLuaSprite(var, nil, 750, 150)
   makeGraphic(var, 2000, 7, 'FFFFFF')
   setProperty(var .. '.origin.x', 0)
   setProperty(var .. '.origin.y', 7 / 2)
   setProperty(var .. '.angle', getRandomFloat(-2, 10))
   startTween(var, var, { alpha = 0, x = 750 }, 0.3 / playbackRate, { ease = 'sinIn', type = 'ONESHOT' })
   startTween(var .. '1', var .. '.scale', { y = 3 }, 0.2 / playbackRate, { ease = 'sinOut', type = 'ONESHOT' })
   if getRandomBool(75) and canDodge then
      setObjectOrder(var, getObjectOrder("darnell") + 1)
      callMethod('darnell.playAnim', { "dodge", true })
   end
   addLuaSprite(var)
   callMethod('blue.playAnim', { "shoot", true })
end

--remade by ferzy
