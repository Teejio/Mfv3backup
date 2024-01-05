--Script by sirFerzy
local rainbow = {
    "0000FF", "1E00F1", "3C00E3", "5A00D5", "7800C7", "9600B9", "B400AB",
    "D2009D", "F0008F", "FF007F", "FF1E6F", "FF3C5F", "FF5A4F", "FF7840",
    "FF9630", "FFB420", "FFD210", "FFF000", "FFFF00", "FFEA00", "FFD400",
    "FFBF00", "FFAA00", "FF9500", "FF8000", "FF6B00", "FF5600", "FF4100",
    "FF2C00", "FF1700", "FF0200", "FF0019", "FF0033", "FF004C", "FF0066",
    "FF0080", "FF0099", "FF00B3", "FF00CC", "FF00E6", "FF00FF", "E300FF",
    "C700FF", "AB00FF", "8F00FF", "7300FF", "5700FF", "3B00FF", "1F00FF"
}
local order1, order2, order3 = 3, 2, 1
local active = false
function onBeatHit()
    if curBeat == 296 or curBeat == 555 then
        setProperty('colorEnabled', false)
        active = true
    end
    if curBeat == 328 then
       callOnLuas('customLoad', { 'bf','bf' })
       setProperty('colorEnabled', true)
       active = false
    end
end
function onCreatePost()
    if not isRunning('scripts/colorNote') then
        close()
    end
    
end
function onUpdatePost()
    if math.floor(curDecStep * 10) % 5 == 0 and active then
        for i = 0, getProperty('notes.length') do
            if getPropertyFromGroup('notes', i, 'mustPress') then
                setPropertyFromGroup('notes', i, 'rgbShader.r', getColorFromHex(rainbow[order1]))
                setPropertyFromGroup('notes', i, 'rgbShader.g', getColorFromHex(rainbow[order3]))
                setPropertyFromGroup('notes', i, 'rgbShader.b', 0)
            end
        end
        for e = 0, 3 do
            if not getPropertyFromGroup('playerStrums', e, 'animation.name'):find('static') then
            setPropertyFromGroup('playerStrums', e, 'rgbShader.r', getColorFromHex(rainbow[order1]))
            setPropertyFromGroup('playerStrums', e, 'rgbShader.g', getColorFromHex(rainbow[order3]))
            setPropertyFromGroup('playerStrums', e, 'rgbShader.b', 0)
            end
        end
        order1 = (order1 % #rainbow) + 1
        order2 = (order2 % #rainbow) + 1
        order3 = (order3 % #rainbow) + 1
    end
end
