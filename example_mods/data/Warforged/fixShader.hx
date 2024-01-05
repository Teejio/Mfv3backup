var resetCamCache;
var fixShaderCoordFix;
function onCreate(){
    resetCamCache = function(?spr) {
        if (spr == null || spr.filters == null) return;
        spr.__cacheBitmap = null;
        spr.__cacheBitmapData3 = spr.__cacheBitmapData2 = spr.__cacheBitmapData = null;
        spr.__cacheBitmapColorTransform = null;
    }

    fixShaderCoordFix = function(?_) {
        resetCamCache(game.camGame.flashSprite);
        resetCamCache(game.camHUD.flashSprite);
    }

    FlxG.signals.gameResized.add(fixShaderCoordFix);
    fixShaderCoordFix();
}
function onDestroy()
    FlxG.signals.gameResized.remove(fixShaderCoordFix);
function onEndSong()
    FlxG.signals.gameResized.remove(fixShaderCoordFix);