Targethealth = 100
SmoothHealth = 100
lfirst = 1
lsecond = 0
lthird = 0
mechanicbutton = 0;
Targetpsi = 0
Smoothpsi = 0
pfirst = 0
psecond = 0
frame = 0
pthird = 0

function onCreate()
	-- background shit


	makeAnimatedLuaSprite('smash_yield', 'stages/Starman/smash_yield', -300, 200);
	addLuaSprite('smash_yield', true);
	luaSpriteAddAnimationByPrefix('smash_yield', 'smash_yield', 'smash_yield', 24, false)
	setScrollFactor('smash_yield', 0, 0);
	scaleObject('smash_yield', 1.5, 1.5);
	setProperty('smash_yield.antialiasing', false)
	setProperty("smash_yield.visible", false)
	setObjectCamera('smash_yield', 'other')

	makeAnimatedLuaSprite('starmanbg', 'stages/Starman/starmanbg', -700, -200);
	luaSpriteAddAnimationByPrefix('starmanbg', 'starmanbg', 'frame', 6, true);
	setScrollFactor('starmanbg', -0.7, -0.7);
	scaleObject('starmanbg', 7.0, 7.0);
	addLuaSprite('starmanbg', false);
	setProperty('starmanbg.antialiasing', false)


end

function onCreate2Post()
	if (not middlescroll) then
		setPropertyFromGroup('playerStrums', 0, 'x', defaultPlayerStrumX0 - 65)
		setPropertyFromGroup('playerStrums', 1, 'x', defaultPlayerStrumX1 - 65)
		setPropertyFromGroup('playerStrums', 2, 'x', defaultPlayerStrumX2 - 65)
		setPropertyFromGroup('playerStrums', 3, 'x', defaultPlayerStrumX3 - 65)
	end
end
function onCreatePost()
	
	setProperty("timeBarBG.visible", false)
	setProperty("timeTxt.visible", false);
	setProperty("timeBar.visible", false)
	setProperty("healthTxt.visible", false);
	setProperty("healthBar.visible", false)
	setProperty("healthBarBG.visible", false)
	setProperty("iconP1.visible", false)
	setProperty("iconP2.visible", false)
end
function onUpdatePost(elapsed)
	setPropertyFromGroup('opponentStrums', 0, 'alpha', 0)
	setPropertyFromGroup('opponentStrums', 1, 'alpha', 0)
	setPropertyFromGroup('opponentStrums', 2, 'alpha', 0)
	setPropertyFromGroup('opponentStrums', 3, 'alpha', 0)
	if ((mainkeyPressed or secondarykeyPressed) and not (curBeat > 197 and curBeat < 208)) then
		Psiy = 1000
		PSILifeUp()
	end
	if (SmoothHealth < 21) then
		setProperty('redHUDThingy.visible', true)
	else
		setProperty('redHUDThingy.visible', false)
	end
end

function onEvent(n, value1, value2)
	if n == 'LifeUp' then
		PSILifeUp()
	end
	if n == 'StarDrain' then
		Targethealth = SmoothHealth - 50
	end

	if n == 'StarEnd' then
		setProperty("smash_yield.visible", true)
		setProperty("black.visible", true)
		setProperty("smash_yield.visible", true)
		objectPlayAnimation("smash_yield", "smash_yield", true)
	end
end

function onBeatHit()
	if (curBeat == 1) then
		Psiy = 500
		objectPlayAnimation("psibox", "blank", true)
	end
	if (curBeat == 2) then
		Psiy = 500
		objectPlayAnimation("psibox", "frame", true)
	end
	if (curBeat == 24) then
		Psiy = 1000
		objectPlayAnimation("psibox", "blank", true)
	end
end

-- i forgot who i got this from sry ;-;
function getKeyBind(keybind_name, isExtraBind)
	local ieb = 0
	if isExtraBind then ieb = 1 end
	return runHaxeCode([[
		var keyarray:Array<Dynamic> = [
			[-2, 'ANY'],
			[-1, 'NONE'],
			[65, 'A'],
			[66, 'B'],
			[67, 'C'],
			[68, 'D'],
			[69, 'E'],
			[70, 'F'],
			[71, 'G'],
			[72, 'H'],
			[73, 'I'],
			[74, 'J'],
			[75, 'K'],
			[76, 'L'],
			[77, 'M'],
			[78, 'N'],
			[79, 'O'],
			[80, 'P'],
			[81, 'Q'],
			[82, 'R'],
			[83, 'S'],
			[84, 'T'],
			[85, 'U'],
			[86, 'V'],
			[87, 'W'],
			[88, 'X'],
			[89, 'Y'],
			[90, 'Z'],
			[48, 'ZERO'],
			[49, 'ONE'],
			[50, 'TWO'],
			[51, 'THREE'],
			[52, 'FOUR'],
			[53, 'FIVE'],
			[54, 'SIX'],
			[55, 'SEVEN'],
			[56, 'EIGHT'],
			[57, 'NINE'],
			[33, 'PAGEUP'],
			[34, 'PAGEDOWN'],
			[36, 'HOME'],
			[35, 'END'],
			[45, 'INSERT'],
			[27, 'ESCAPE'],
			[189, 'MINUS'],
			[187, 'PLUS'],
			[46, 'DELETE'],
			[8, 'BACKSPACE'],
			[219, 'LBRACKET'],
			[221, 'RBRACKET'],
			[220, 'BACKSLASH'],
			[20, 'CAPSLOCK'],
			[186, 'SEMICOLON'],
			[222, 'QUOTE'],
			[13, 'ENTER'],
			[16, 'SHIFT'],
			[188, 'COMMA'],
			[190, 'PERIOD'],
			[191, 'SLASH'],
			[192, 'GRAVEACCENT'],
			[17, 'CONTROL'],
			[18, 'ALT'],
			[32, 'SPACE'],
			[38, 'UP'],
			[40, 'DOWN'],
			[37, 'LEFT'],
			[39, 'RIGHT'],
			[96, 'NUMPADZERO'],
			[97, 'NUMPADONE'],
			[98, 'NUMPADTWO'],
			[99, 'NUMPADTHREE'],
			[100, 'NUMPADFOUR'],
			[101, 'NUMPADFIVE'],
			[102, 'NUMPADSIX'],
			[103, 'NUMPADSEVEN'],
			[104, 'NUMPADEIGHT'],
			[105, 'NUMPADNINE'],
			[109, 'NUMPADMINUS'],
			[107, 'NUMPADPLUS'],
			[110, 'NUMPADPERIOD'],
			[106, 'NUMPADMULTIPLY'],
		];
		for (str in keyarray)
			if (str[0] == ClientPrefs.keyBinds[']] .. keybind_name .. [['][ ]] .. tostring(ieb) .. [[ ])
				return str[1];
	]])
end
