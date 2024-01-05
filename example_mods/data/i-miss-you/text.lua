happening = false
local textnames = {
    textname11,
    textname,
    textname2,
    textname3,
    textname4,
    textname5,
    textname6,
    textname7,
    textname8,
    textname9,
    textname10,
    textname12
}
function onStepHit()
	if happening == true then
		if curStep % 21 == 0 then
			textname11 = (curStep .. '0')
			textname = (curStep .. '1')
			textname2 = (curStep .. '2')
			textname3 = (curStep .. '3')
			textname4 = (curStep .. '4')
			textname5 = (curStep .. '5')
			textname6 = (curStep .. '6')
			textname7 = (curStep .. '7')
			textname8 = (curStep .. '8')
			textname9 = (curStep .. '9')
			textname10 = (curStep .. '10')
			textname12 = (curStep .. '11')

			makeLuaText(textname11, 'i miss you', 0, 1600, -105)
			setObjectCamera(textname11, 'camGame')
			scaleObject(textname11, 6, 6)
			setObjectOrder(textname11, getObjectOrder('window') - 1)
			setProperty(textname11 .. '.alpha', 0.7)
			addLuaText(textname11, false)

			makeLuaText(textname, 'i miss you', 0, -1000, -30)
			setObjectCamera(textname, 'camGame')
			scaleObject(textname, 6, 6)
			setObjectOrder(textname, getObjectOrder('window') - 1)
			setProperty(textname .. '.alpha', 0.7)
			addLuaText(textname, false)

			makeLuaText(textname2, 'i miss you', 0, 1600, 45)
			setObjectCamera(textname2, 'camGame')
			scaleObject(textname2, 6, 6)
			setObjectOrder(textname2, getObjectOrder('window') - 1)
			setProperty(textname2 .. '.alpha', 0.7)
			addLuaText(textname2, false)

			makeLuaText(textname3, 'i miss you', 0, -1000, 120)
			setObjectCamera(textname3, 'camGame')
			scaleObject(textname3, 6, 6)
			setObjectOrder(textname3, getObjectOrder('window') - 1)
			setProperty(textname3 .. '.alpha', 0.7)
			addLuaText(textname3, false)

			makeLuaText(textname4, 'i miss you', 0, 1600, 195)
			setObjectCamera(textname4, 'camGame')
			scaleObject(textname4, 6, 6)
			setObjectOrder(textname4, getObjectOrder('window') - 1)
			setProperty(textname4 .. '.alpha', 0.7)
			addLuaText(textname4, false)

			makeLuaText(textname5, 'i miss you', 0, -1000, 270)
			setObjectCamera(textname5, 'camGame')
			scaleObject(textname5, 6, 6)
			setObjectOrder(textname5, getObjectOrder('window') - 1)
			setProperty(textname5 .. '.alpha', 0.7)
			addLuaText(textname5, false)

			makeLuaText(textname6, 'i miss you', 0, 1600, 345)
			setObjectCamera(textname6, 'camGame')
			scaleObject(textname6, 6, 6)
			setObjectOrder(textname6, getObjectOrder('window') - 1)
			setProperty(textname6 .. '.alpha', 0.7)
			addLuaText(textname6, false)

			makeLuaText(textname7, 'i miss you', 0, -1000, 410)
			setObjectCamera(textname7, 'camGame')
			scaleObject(textname7, 6, 6)
			setObjectOrder(textname7, getObjectOrder('window') - 1)
			setProperty(textname7 .. '.alpha', 0.7)
			addLuaText(textname7, false)

			makeLuaText(textname8, 'i miss you', 0, 1600, 485)
			setObjectCamera(textname8, 'camGame')
			scaleObject(textname8, 6, 6)
			setObjectOrder(textname8, getObjectOrder('window') - 1)
			setProperty(textname8 .. '.alpha', 0.7)
			addLuaText(textname8, false)

			makeLuaText(textname9, 'i miss you', 0, -1000, 560)
			setObjectCamera(textname9, 'camGame')
			scaleObject(textname9, 6, 6)
			setObjectOrder(textname9, getObjectOrder('window') - 1)
			setProperty(textname9 .. '.alpha', 0.7)
			addLuaText(textname9, false)

			makeLuaText(textname10, 'i miss you', 0, 1600, 635)
			setObjectCamera(textname10, 'camGame')
			scaleObject(textname10, 6, 6)
			setObjectOrder(textname10, getObjectOrder('window') - 1)
			setProperty(textname10 .. '.alpha', 0.7)
			addLuaText(textname10, false)

			makeLuaText(textname12, 'i miss you', 0, -1000, -180)
			setObjectCamera(textname12, 'camGame')
			scaleObject(textname12, 6, 6)
			setObjectOrder(textname12, getObjectOrder('window') - 1)
			setProperty(textname12 .. '.alpha', 0.7)
			addLuaText(textname12, false)

			doTweenX(textname11 .. ' flying', textname11, -1000, 17, 'linear')
			doTweenX(textname .. ' flying', textname, 1600, 17, 'linear')
			doTweenX(textname2 .. ' flying', textname2, -1000 + 125, 17, 'linear')
			doTweenX(textname3 .. ' flying', textname3, 1600, 17, 'linear')
			doTweenX(textname4 .. ' flying', textname4, -1000 + 125, 17, 'linear')
			doTweenX(textname5 .. ' flying', textname5, 1600, 17, 'linear')
			doTweenX(textname6 .. ' flying', textname6, -1000 + 125, 17, 'linear')
			doTweenX(textname7 .. ' flying', textname7, 1600, 17, 'linear')
			doTweenX(textname8 .. ' flying', textname8, -1000 + 125, 17, 'linear')
			doTweenX(textname9 .. ' flying', textname9, 1600, 17, 'linear')
			doTweenX(textname10 .. ' flying', textname10, -1000 + 125, 17, 'linear')
			doTweenX(textname12 .. ' flying', textname12, 1600, 17, 'linear')
		end
	end

	if curStep == 728 then
		happening = true
	end
end
function onBeatHit()
	if curBeat == 246 then
		cameraFlash('camOther', '0x7BFF0000',  0.5, true)
	end
end