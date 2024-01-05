--just mess with these numbers to move da camera
camZoom = 0.9;
camSpeed = 1;



function onBeatHit()
    -- 0.5, 1.0, 1.5
    -- 0.85, 0.9, 1.25

    if (curBeat == 4) then
        setProperty('cameraSpeed', 1);      --Default Camera Move
        setProperty('defaultCamZoom', 0.9); --Default Zoom
    end

    --850 gen
    --1050 focus BF

    if (curBeat == 36) then
        setProperty('defaultCamZoom', 0.8); --Distanced Zoom
        setProperty('cameraSpeed', 0.65);   --Slowed Camera Move
    end

    if (curBeat == 52) then
        setProperty('cameraSpeed', 1.35);   --Quick Camera Move
        setProperty('defaultCamZoom', 0.9); --Default Zoom
    end

    if (curBeat == 65) then
        setProperty('cameraSpeed', 1);       --Default Camera Move
        setProperty('defaultCamZoom', 1.05); --Aproaching Zoom
    end

    if (curBeat == 68) then
        setProperty('cameraSpeed', 1.35);   --Quick Camera Move
        setProperty('defaultCamZoom', 0.9); --Default Zoom
    end

    if (curBeat == 84) then
        setProperty('defaultCamZoom', 1.1); --Aproaching Zoom
    end

    if (curBeat == 100) then
        setProperty('cameraSpeed', 1); --Default Camera Move
        setProperty('defaultCamZoom', 0.75);
    end

    if (curBeat == 160) then
        setProperty('cameraSpeed', 1.25);
        setProperty('defaultCamZoom', 1);
    end

    --164 is the start of fuzzy part

    if (curBeat == 192) then
        setProperty('cameraSpeed', 1);
        setProperty('defaultCamZoom', 1.1);
    end

    if (curBeat == 196) then
        setProperty('defaultCamZoom', 0.9);
    end

    --focus
    if (curBeat == 200) then
        setProperty('defaultCamZoom', 1.0); --Default Zoom
    end

    if (curBeat == 232) then
        setProperty('cameraSpeed', 1.25);
    end

    --264, i put 265 to time the WOW!

    if (curBeat == 265) then
        setProperty('cameraSpeed', 1);      --Default Camera Move
        setProperty('defaultCamZoom', 0.9); --Default Zoom
    end

    if (curBeat == 296) then
        setProperty('cameraSpeed', 1);
        setProperty('defaultCamZoom', 0.85);
    end

    if (curBeat == 320) then
        setProperty('cameraSpeed', 1);
        setProperty('defaultCamZoom', 0.9);
    end

    if (curBeat == 324) then
        setProperty('defaultCamZoom', 1);
    end

    if (curBeat == 328) then
        setProperty('cameraSpeed', 1.25);
        setProperty('defaultCamZoom', 1.1);
    end

    if (curBeat == 332) then
        setProperty('defaultCamZoom', 1.2);
    end

    if (curBeat == 336) then
        setProperty('cameraSpeed', 0.75);
        setProperty('defaultCamZoom', 0.75);
    end
end
