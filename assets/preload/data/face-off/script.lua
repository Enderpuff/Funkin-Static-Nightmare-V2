function onSongStart()
    tween()
end

function tween()
    for i=0,3 do
        noteTweenAlpha(i+16, i, math.floor(curStep/9999), 0.1, 'quartInOut')
    end

    if middlescroll == false then
        noteTweenX('note4', 4, 412, 0.1, 'quartInOut')
        noteTweenX('note5', 5, 524, 0.1, 'quartInOut')
        noteTweenX('note6', 6, 636, 0.1, 'quartInOut')
        noteTweenX('note7', 7, 748, 0.1, 'quartInOut')
    end

    runTimer("noteTween",0.1)
end

function onTimerCompleted(tag)
    if(tag == "noteTween") then
        tween()
    end
end