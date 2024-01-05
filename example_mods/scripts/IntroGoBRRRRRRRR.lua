songNameText = 'Test'
songCartridge = 'mother'
songCreator = 'joe mama'
bitch = ''
function findTheStuff()
    jsonShit = 'mother3\nlmnop'
    songNameText = songName
    if songName == 'Dakota!' then
        songNameText = 'Dakota'
    end

    if songName == 'Eat Will Ya' or songName == 'eat-will-ya'  then
        songNameText = 'eat-will-ya'
    end

    if songName == 'Fire at Will' or songName == 'fire-at-will'  then
        songNameText = 'fire-at-will'
    end


    jsonShit = getTextFromFile('data/' .. songNameText .. '/Info.txt')

	temp = split(jsonShit,",")
    --table.remove(temp, 1)

    songCreator = temp[2]
    songCartridge = temp[1]
    
    makeLuaText('dummy', songCartridge .. 'Box', 0, -250, 217);
    setTextAlignment('dummy', 'left')     
    setTextSize('dummy', 35) 
    setObjectCamera('dummy', 'other')
    addLuaText('dummy')
    bitch = getTextString('dummy')
    maketheFunkingSlideInShit()

end

function split(str, ts)
	if ts == nil then return {} end
	
	local t = {}; i=1
	
	for s in string.gmatch(str, "([^"..ts.."]+)") do
		t[i] = s
		i = i + 1 
	end
  
	return t
end
function ReplaceStrInSubstrs(inputString,phr,newstr)
    local str = inputString
    local r = ""
    local roll = true
    if  string.find(str,phr) then
        while roll do
            local a = string.find(str,phr)
            local b = a + #phr
            for i = 1,#str do
                if i >= a and i < b then 
                  r = r..newstr
                else
                  r = r..str:sub(i,i)
                end
            end
            str = r
            r = ""
            if not string.find(str,phr) then roll = false end
        end
    end
    return str
end
function maketheFunkingSlideInShit()
    --create Box that holds the silly stuff
        poopyhead = songName
        makeLuaSprite('Box', bitch, -1500, 160);
	    setScrollFactor('Box', 0, 0);
	    scaleObject('Box', 1.1, 1.1);
        setObjectCamera('Box', 'other')
        addLuaSprite('Box', true)
    --createSongText

        if not(string.match(songName, '-smash') == nil) then
            poopyhead = string.gsub(songName,'-smash',' SMAAAASH MIX')
        end
            makeLuaText('songText', poopyhead, 0,-1500, 172);
        setTextAlignment('songText', 'left')     
        setTextSize('songText', 45) 
        setObjectCamera('songText', 'other')
        addLuaText('songText',true)  
 
    -- crate the author Text
        makeLuaText('authorText', songCreator, 0, -1500, 217);
        setTextAlignment('authorText', 'left')     
        setTextSize('authorText', 35) 
        setObjectCamera('authorText', 'other')
        addLuaText('authorText',true)


end

function onSongStart()
    --findTheShit()
    findTheStuff()

    if songName == 'Yield' or songName == 'Yield-smash' then   
        doTweenX('AltBoxAppear', 'Box', 210, 0.8, 'linear') 
    else
        doTweenX('BoxAppear', 'Box', 50, 0.8, 'linear') 
    end
   
	-- Inst and Vocals start playing, songPosition = 0
     if  songName == 'Yield' or songName == 'Yield-smash' then
        doTweenX('songTextappearALT', 'songText', 250, 0.8, 'linear')
        doTweenX('authorTextappearALT', 'authorText', 250, 0.8, 'linear')
     else
        doTweenX('songTextappear', 'songText', 75, 0.8, 'linear')
        doTweenX('authorTextappear', 'authorText', 80, 0.8, 'linear')
     end
end

function onBeatHit()
        if curBeat >= 12 then
            doTweenAlpha('BoxFade', 'Box', 0, 0.2, 'linear')
            doTweenX('BoxReturn', 'Box', -2000, 0.8, 'linear') 
            doTweenX('songTextFade', 'songText', -2000, 0.2, 'linear')  
            doTweenX('authorTextfade', 'authorText', -2000, 0.8, 'linear')
        end
 end

 function onTimerCompleted(tag, loops, loopsLeft)
        if tag ==  "authorTextfade" then
            --close(true);
        end
 end