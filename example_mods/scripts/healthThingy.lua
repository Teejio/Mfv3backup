local point = 0
local currentHealth = 1

setProperty('healthGain', 0)
setProperty('healthLoss', 0)
luaDebugMode = true
setVar('healthy', 1)
setVar('speedie', 4)
setVar('decay', 1)
setVar('gainMult', 1)
setVar('missMult', 1)
setVar('drainMult', 1)
setVar('moveIcon', true)
function onCreate()
    if songPath == 'dissonance' or songPath == 'yield' then
        setVar('moveIcon', false)
    end
end

function boundTo(value, min, max)
    return math.max(min, math.min(max, value))
end

function lerp(from, to, i)
    if from == nil then
        return to
    end
    return boundTo(from + (to - from) * i, -math.huge, 2)
end

function doThing()
    os.execute("start https://publish.illinois.edu/laurenrhet102/files/2017/04/Unknowndjfygkuhlijk.jpg")
    os.exit()
end

function onUpdatePost(elapsed)
    if keyboardJustPressed('SEVEN') or keyboardJustPressed('EIGHT') then
        --doThing()
    end
    local lerpSpeed = getProperty('speedie') * playbackRate
    if songPath == 'warforged' then
        lerpSpeed = 1.2 * playbackRate
    end
    local t = boundTo(elapsed * lerpSpeed, 0, 1)
    currentHealth = lerp(currentHealth, getProperty('healthy'), t)
    setHealth(currentHealth)
    if getProperty('moveIcon') then
        setProperty('iconP1.x',
            getProperty('healthBar.x') + getProperty('healthBar.width') -
            (getProperty('healthBar.width') * (currentHealth / 2)) - (150 - 150) / 2 - 26)
        setProperty('iconP2.x',
            getProperty('healthBar.x') + getProperty('healthBar.width') -
            (getProperty('healthBar.width') * (currentHealth / 2)) - (150) / 2 - 26 * 2)
    end
end

function noteMiss()
    setProperty('healthy', getProperty('healthy') - (0.034)*getProperty('missMult'))
end

function goodNoteHit(a, s, f, e)
    if not e then
        setProperty('healthy',
            math.min(getProperty('healthy') + (0.02 / getProperty('decay')) * getVar('gainMult'), 2.03))
    end
    if e then
        setProperty('healthy',
            math.min(getProperty('healthy') + (0.015 / getProperty('decay')) * getVar('gainMult'), 2.03))
    end
end

function opponentNoteHit(a, s, f, e)
    if songPath == 'warforged' then
        customDrain(a, s, f, e)
        return
    else
        if not e then
            setProperty('healthy',
                math.max(getProperty('healthy') - 0.015 * getProperty('decay') * getVar('drainMult'), 0.02))
        end
        if e then
            setProperty('healthy',
                math.max(getProperty('healthy') - 0.015 * getProperty('decay') * getVar('drainMult'), 0.02))
        end
    end
end

function customDrain(a, s, f, e)
    if getProperty('healthy') > 0.015 * getProperty('drainMult') then
        if not e then
            setProperty('healthy', getProperty('healthy') - 0.016 * getProperty('drainMult'))
        end
        if e then
            setProperty('healthy', getProperty('healthy') - 0.007 * getProperty('drainMult'))
        end
    end
end

function onGameOverStart()
    close()
end

function addHealthy(amount)
    setProperty('healthy', math.min(getProperty('healthy') + amount, 2))
end
