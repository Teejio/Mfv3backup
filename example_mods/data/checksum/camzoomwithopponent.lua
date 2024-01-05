--Script by TEEJIO1
playerzoom = 3.2 --the game zoom on the players turm 
opponentzoom = 2.4-- the game zoom on the opponents turn
zoomspeed = 1

playerfirst = true -- set this to false if the game should start zoomed in on the opponent
if playerfirst then
    targetZoom = playerzoom
else
    targetZoom = opponentzoom
end
zoom = targetZoom
zoomshift = 1
fps = 60
oldtarget = targetZoom

function onCreatePost()
    setProperty('camGame.zoom', targetZoom)
end
function onBeatHit()

 
end
function onUpdatePo2st(elapsed)
    if curBeat > 4 then
    luaDebugMode = true
    if not ( oldtarget == targetZoom ) then
        doTweenZoom('zoom', 'camGame', targetZoom, zoomspeed, 'linear')
       oldtarget = targetZoom
    end
    setProperty('defaultCamZoom', targetZoom)
    if curBeat > 1 then -- if i dont do this is goes wierd 4 some reason
        if mustHitSection then
            targetZoom = playerzoom
            
        else
            targetZoom = opponentzoom
        end
    end
--    debugPrint(getProperty('camGame.zoom'))
 --   debugPrint(targetZoom)
end
end