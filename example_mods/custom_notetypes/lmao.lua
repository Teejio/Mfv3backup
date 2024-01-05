
function onCreatePost()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'lmao' then
            setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
		end
	end
end