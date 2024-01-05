import shaders.RGBPalette;
import psychlua.LuaUtils;
 

function onCreate() {

	createGlobalCallback('setRGBShader', function(tag:String, r:String, g:String, b:String)
	{
		setRGBShader(tag, r, g, b);
	});
}

function onPause()
    if (game.modchartSounds.exists('boom')) game.modchartSounds.get('boom').pause();

function onResume()
    if (game.modchartSounds.exists('boom')) game.modchartSounds.get('boom').resume();

function onUpdatePost()
    if (game.modchartSounds.exists('boom')) game.modchartSounds.get('boom').pitch = game.playbackRate;

function setRGBShader(tag:String, r:String, g:String, b:String){

    var rgbR = r;
    var rgbG = g;
    var rgbB = b;

    var split:Array<String> = tag.split('.');
    var leObj:FlxSprite = LuaUtils.getObjectDirectly(split[0]);
    if(split.length > 1) {
        leObj = LuaUtils.getVarInArray(LuaUtils.getPropertyLoop(split), split[split.length-1]);
    }

    if(leObj != null) {
        var shdr:RGBPalette = new RGBPalette();
        shdr.r = rgbR;
        shdr.g = rgbG;
        shdr.b = rgbB;
        leObj.shader = shdr.shader;
    }
}
