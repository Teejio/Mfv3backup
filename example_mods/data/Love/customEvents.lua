--forcing the camera parameters cause yes...

local xx = 950;
local yy = 760; --to only move horizontally
local xx2 = 1450;
local yy2 = 760; --to only move horizontally
local ofs = 15;
local followchars = true;
local del = 0;
local del2 = 0;

function onUpdatePost()
    if getPropertyFromClass('ClientPrefs', 'camMovements') == false then
        setProperty('camGame.zoom',  getProperty('defaultCamZoom') + 0.3)
    end
end
function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if getPropertyFromClass('ClientPrefs', 'camMovements') == false then
        setProperty('camGame.zoom',  getProperty('defaultCamZoom') + 0.3)
    end
    if getPropertyFromClass('ClientPrefs', 'camMovements') then
        if followchars == true then
            if mustHitSection == false then
                if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                    triggerEvent('Camera Follow Pos',xx-ofs,yy)
                end
                if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                    triggerEvent('Camera Follow Pos',xx+ofs,yy)
                end
                if getProperty('dad.animation.curAnim.name') == 'singUP' then
                    triggerEvent('Camera Follow Pos',xx,yy-ofs)
                end
                if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                    triggerEvent('Camera Follow Pos',xx,yy+ofs)
                end
                if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                    triggerEvent('Camera Follow Pos',xx-ofs,yy)
                end
                if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                    triggerEvent('Camera Follow Pos',xx+ofs,yy)
                end
                if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                    triggerEvent('Camera Follow Pos',xx,yy-ofs)
                end
                if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                    triggerEvent('Camera Follow Pos',xx,yy+ofs)
                end
                if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                    triggerEvent('Camera Follow Pos',xx,yy)
                end
                if getProperty('dad.animation.curAnim.name') == 'idle' then
                    triggerEvent('Camera Follow Pos',xx,yy)
                end
            else

                if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                    triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
                end
                if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                    triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
                end
                if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                    triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
                end
                if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                    triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
                end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                    triggerEvent('Camera Follow Pos',xx2,yy2)
                end
            end
        else
            triggerEvent('Camera Follow Pos','','')
        end
    end
end

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
                doTweenAlpha('iconP2B', 'iconP2', 1, 1, 'linear')
		doTweenAlpha('iconP1B', 'iconP1', 1, 1, 'linear')

		doTweenAlpha('healthBar2', 'healthBar', 1, 1, 'linear')
                doTweenAlpha('healthBarBG2', 'healthBarBG', 1, 1, 'linear')

                doTweenAlpha('timeBar2', 'timeBar', 1, 1, 'linear')
                doTweenAlpha('timeBarBG2', 'timeBarBG', 1, 1, 'linear')

                doTweenAlpha('scoreTxt2', 'scoreTxt', 1, 1, 'linear')
                doTweenAlpha('timeTxt2', 'timeTxt', 1, 1, 'linear')

                setProperty("timeBarBG.visible", true);
                setProperty("timeBar.visible", true);
                setProperty("timeTxt.visible", true);
end

function onCreatePost()
	-- end of "create"
hideHUD();    
end

function onBeatHit()
     if curBeat >= 96 then
        unHideHUD();   
     end      
end

function onStepHit()
--cinematic zooms

        if (curStep ==  384) then
		setProperty('cameraSpeed', 1.25); --Default Camera Move
                setProperty('defaultCamZoom', 0.85); --Default Zoom
                yy = 800;
                yy2 = 800;
	end

        if (curStep ==  512) then
		setProperty('cameraSpeed', 1.0);
                setProperty('defaultCamZoom', 0.7);
                yy = 770;
                yy2 = 770;
	end

        if (curStep ==  640) then
		setProperty('cameraSpeed', 0.75);
                setProperty('defaultCamZoom', 0.8);
                yy = 780;
                yy2 = 780;
	end

        if (curStep ==  768) then
		setProperty('cameraSpeed', 1.1);
                setProperty('defaultCamZoom', 0.65);
                yy = 700;
                yy2 = 700;
                xx = 1150;
                xx2 = 1200;
	end
    
    if curStep == 880 then
        playSound('pork', 3, 'pork')
    elseif curStep == 896 then
	    doTweenX('shipx', 'ship', 1100, 3.2, 'linear')
    elseif curStep == 910 then
        soundFadeOut('pork', 2, 0)
	end

        if (curStep ==  928) then
		setProperty('cameraSpeed', 0.6);
                setProperty('defaultCamZoom', 0.8);   
                yy = 760;
                yy2 = 760;
                xx = 950;
                xx2 = 1450;             
	end

        if (curStep ==  1056) then
		setProperty('cameraSpeed', 0.6);
                setProperty('defaultCamZoom', 1);  
                yy = 870;
                yy2 = 870;   
                xx2 = 1650        
	end

        if (curStep ==  1184) then
		setProperty('cameraSpeed', 0.8);
                setProperty('defaultCamZoom', 0.8);   
                yy = 760;
                yy2 = 760;
                xx = 950;
                xx2 = 1450;             
	end

         if (curStep ==  1312) then
		setProperty('cameraSpeed', 0.6);
                setProperty('defaultCamZoom', 0.65);   
                 yy = 700;
                yy2 = 700;
                xx = 1150;
                xx2 = 1200;            
	end
end

