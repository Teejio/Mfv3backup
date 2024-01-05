--Modified script by Ferzy

local steps = {
    {64, 0.8, 1},
    {190, 0.6, 1.25},
    {322, 0.85, 0.8},
    {448, nil, 1.25},
    {576, 0.6, 1.1},
    {640, 0.7},
    {704, 0.8, 0.6},
    {736, nil, 1.1},
    {768, 0.7, 1},
    {800, 0.8, 1},
    {896, 0.85, 1.1},
    {1008, 1, 1.25},
    {1016, 1.1, 1.25},
    --MAGICANT PART
    {1024, 0.7, 1},
    {1152, 0.8, 1.1},
    {1224, 0.9, 1.5},
    --END OF IT
    {1312, 0.6, 1},
    {1504, 0.8, 1},
    {1568, 0.85, 1.25}
}

local speedMutl = 1.05

function onStepHit()
    for _, change in ipairs(steps) do
        if curStep == change[1] then
            if change[2] ~= nil then
                setProperty('defaultCamZoom', change[2])
            end
            if change[3] ~= nil then
                setProperty('cameraSpeed', getProperty('cameraSpeed') * speedMutl)
            end
            break
        end
    end
end
