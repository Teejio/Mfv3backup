package backend;


import flixel.util.FlxSave;


class Cartisave {
    public var songNotis:Array<String> = [];
    public var smashSongNotis:Array<String> = [];
    public var songCompleted:Array<String> = [];
	public var catridgeUnlock:Map<String, Bool> = new Map<String, Bool>();
    public function new(){
        //Why does haxe needs this again?
    }

}


class CartridgeHandler {

    public static var data:Cartisave =  new Cartisave();


    public static var save:FlxSave = new FlxSave();

    public static function initData():Void
        
    {
        data = new Cartisave();
        data.catridgeUnlock["tobyfox"] = false;
        data.catridgeUnlock["MotherSongs"] = false;
        data.catridgeUnlock["Mother2Songs"] = false;
        data.catridgeUnlock["Mother3Songs"] = false;
        data.catridgeUnlock["internet"] = true;



        data.songNotis = [];
        data.songCompleted = [];
        data.smashSongNotis = [];
        trace("catridge vars initizalied");
        saveData();


    }

    public static function removeNoti(songName:String):Void 
        {

        if (data.songNotis.contains(songName)){
            data.songNotis.remove(songName);
            saveData();
        }
    }

    public static function load():Void
        
        {
            trace("trying load");
            save.bind('cartridgeData', CoolUtil.getSavePath());
    

            trace(save.data.data);
            if (save.data.data == null){
                initData();

            }
            else{
                trace(save.data.data);
                data.songNotis = save.data.data.songNotis;
                data.smashSongNotis = save.data.data.smashSongNotis;
                data.catridgeUnlock = save.data.data.catridgeUnlock;
                data.songCompleted = save.data.data.songCompleted;
               // data.songNotis = [];
            }

            trace("catridge vars loaded");


        }


        public static function saveData():Void{


            save.bind('cartridgeData', CoolUtil.getSavePath());
            save.data.data = data;
            save.flush();

            trace("catridgedata Saved");
        }


        public static function checkforNoti(songs:Array<String>):Bool{

            for (str in songs){

                if (songs.contains(str)){
                    return true;
                }
            }
            return false;
        }

}