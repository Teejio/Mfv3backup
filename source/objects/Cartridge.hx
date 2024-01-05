package objects;
#if MODS_ALLOWED
import sys.FileSystem;
#end

import tjson.TJSON as Json;
import lime.utils.Assets;
import backend.CartridgeHandler;
import objects.Noti;
typedef FreeplayData = {

   var  cartridgeName:String;
   var  songs:Array<Array<String>>;
   var  weekName:String;
   var  noti:Noti;
   var  hintText:String;
}
class Cartridge extends FlxSprite
{

    public var unlocked:Bool = false;

    public var name:String;
    public var idx:Int;
    public var noti:Noti;
    public var lock:FlxSprite;
    public var time:Float;

    public static var cartFiles:Map<String, FreeplayData> = new Map<String, FreeplayData>();
    public static var hintText:Map<String, String> = new Map<String, String>();

    public function new(x:Float, y:Float, catridgeName:String, index:Int, ?allowGPU:Bool = true )
        {
            name = catridgeName;
            super(x,y);
            unlocked = CartridgeHandler.data.catridgeUnlock[name];
            idx = index;
            var img = 'cartridges/' + cartFiles[name].cartridgeName;
            trace(img);
            loadGraphic(Paths.image(img));
         
            spawnNoti();

            if (!unlocked){
                color = 0xFF000000;
                lock = new FlxSprite(0,0).loadGraphic(Paths.image("lock"));
                lock.scale.x = lock.scale.y = 0.8;
                lock.updateHitbox();
            }

        }


        function spawnNoti():Void {
          for ( song in    Cartridge.cartFiles[name].songs ){

              if (CartridgeHandler.data.songNotis.contains(song[0])){
                noti = new Noti(50);
                noti.sprTracker = this;

                break;
              }

          }
        }
        override public function update(elapsed:Float){
          super.update(elapsed);
          time += elapsed*5;
        }

        public static function unlockWeek(weekName:String):Void{
          var idc = getNames();
          trace(weekName);
          if (cartFiles[weekName]== null){
            return;
          }

          if ( CartridgeHandler.data.catridgeUnlock[weekName] == true){
            return;
          }

          for (song in cartFiles[weekName].songs){
            CartridgeHandler.data.songNotis.push(song[0]);
          }

          CartridgeHandler.data.catridgeUnlock[weekName] = true;
          CartridgeHandler.saveData();

        }
        public static function getNames():Array<String>{
            var names:Array<String> = [];

            var data:Array<String> = FileSystem.readDirectory('mods/freeplay');
            data.sort(function(a:String, b:String):Int {
                a = a.toUpperCase();
                b = b.toUpperCase();
              
                if (a < b) {
                  return -1;
                }
                else if (a > b) {
                  return 1;
                } else {
                  return 0;
                }
              });

              trace(data);


            for (str in   data){

                trace(Assets.getText('mods/freeplay/' + str));
                var o:FreeplayData = Json.parse(Assets.getText('mods/freeplay/' + str));
                names.push(o.weekName);
                cartFiles[o.weekName] = o;
                hintText[o.weekName] = o.hintText;
            }

            
            return (names);
        }

        override public function draw():Void
          {
              super.draw();
      
  
              if (noti != null){
  
                noti.alpha = alpha;
                noti.alpha*= Math.abs(Math.sin(time));
                  noti.draw();

                  
              }

              if (lock != null){
  
                lock.x = x +( width/2) + (lock.width/-2);
                lock.y = y  + (height/2)+ (lock.height/-2);
                lock.alpha = alpha;
                lock.draw();

                  
              }
  
          }
}