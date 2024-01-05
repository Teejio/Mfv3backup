import objects.Character;
import objects.Note;

var names:Array<String> = ["singLEFT", "singDOWN", "singUP", "singRIGHT"];
var start:Array<Int> = [0, 1];
var banned:Array<String> = ["rtc", "fire-at-will"]; // Songs that shouldn't have it or don't need it

function onCreatePost() {
    addNewAnims(game.dad);
    addNewAnims(game.boyfriend);
    
        for (unNote in game.unspawnNotes) {
            if (StringTools.endsWith(unNote.animation.curAnim.name, 'end')) {
                    unNote.animSuffix = '-ender';
                    unNote.prevNote.noAnimation = true;
            }
            if (!unNote.isSustainNote && unNote.nextNote.isSustainNote && StringTools.endsWith(unNote.nextNote.animation.curAnim.name, 'hold')) {
                unNote.animSuffix = '-Start';
                unNote.nextNote.noAnimation = true;
            }
        }
}

function addNewAnims(char:Character) {
    for (item in names) {
        char.animation.addByIndices(item + "-Start", getAnim(char, item) , start, "", 20, false);
        char.animOffsets[item + "-Start"] = char.animOffsets[item];
        char.animation.addByIndices(item + "-Start-alt", getAnim(char, item)+'-alt', start, "", 20, false);
        char.animOffsets[item + "-Start-alt"] = char.animOffsets[item];
    }
}

function goodNoteHit(note:Note) {
    if (note.isSustainNote) {
        playRightAnim(note, game.boyfriend, "");
    } else {
        game.boyfriend.animation.curAnim.frameRate = getFPS(game.boyfriend, names[note.noteData]);
        if (note.animSuffix == "-Start" && altAnim) game.boyfriend.playAnim(names[note.noteData]+'-Start-alt', true, false);
    }
}

function opponentNoteHit(note:Note) {
    if (note.isSustainNote) {
        playRightAnim(note, game.dad, "");
    } else {
        
        game.dad.animation.curAnim.frameRate = getFPS(game.dad, names[note.noteData]);
        if (note.animSuffix == "-Start" && altAnim) game.dad.playAnim(names[note.noteData]+'-Start-alt', true, false);
    }
}

function playRightAnim(note:Note, char:Character, ending:String) {
    var item = names[note.noteData];
    if (altAnim) var suffix = '-alt'; else var suffix = '';
    if (!note.noAnimation) {
        if (note.animSuffix == '-ender') {
            char.playAnim(item + suffix, true, false, 2);
            char.animation.curAnim.frameRate = getFPS(char, item) * 1.1;
        }
        else {
            char.playAnim(item + suffix, true, false, 1);
            char.animation.curAnim.frameRate = 1;
            }
    }

    var strum = char == game.boyfriend ? game.playerStrums : game.opponentStrums;

    if (StringTools.endsWith(note.animation.curAnim.name, 'hold')) {
        strum.members[note.noteData].animation.curAnim.frameRate = 1;
        strum.members[note.noteData].animation.curAnim.curFrame = 0;
    } else {
        strum.members[note.noteData].animation.curAnim.frameRate = 24;
    }
}

function onEvent(name:String, value1:String, value2:String, strumTime:Float) {
    if (name == 'Change Character') {
        if (value1 == 'BF') {
            addNewAnims(game.boyfriend);
        } else if (value1 == 'Dad') {
            addNewAnims(game.dad);
        }
    }
}

function getFPS(char:Character, animation:String):Int {
    for (anim in char.animationsArray) {
        if (anim.anim == animation) return anim.fps;
    }
    return 24; 
}

function getAnim(char:Character, animation:String):String {
    for (anim in char.animationsArray) {
        if (anim.anim == animation) return anim.name;
    }
    return ""; 
}

function noteMiss(note:Note) {
    game.boyfriend.playAnim(names[note.noteData] + 'miss', true);
}
