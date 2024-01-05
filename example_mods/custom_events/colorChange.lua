function onEvent(n,v1,v2)
    if n == 'colorChange' then
        callOnLuas('customLoad',{tostring(v1),tostring(v2)})
    end
end