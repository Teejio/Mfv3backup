package objects;

import objects.HealthIcon;
import backend.CartridgeHandler;


class FreeplayText extends FlxText {

    var bfIcon:HealthIcon;
    var dadIcon:HealthIcon;
    var songName:String;
    private var time:Float = 0;
    public function new(songs:Array<String>, X:Float, Y:Float, Width:Int, ?Text:String, Size:Int = 8, EmbeddedFont:Bool = true){
       // size = 32;
       super(X, Y, Width, Text, Size, EmbeddedFont);

        songName = songs[0];
        text = songName;
        dadIcon = new HealthIcon(songs[1]);
        bfIcon = new HealthIcon(songs[2]);

        dadIcon.scale.x =  dadIcon.scale.y = bfIcon.scale.x =  bfIcon.scale.y = 0.5;
        
        dadIcon.scrollFactor.set(0, 0);
        bfIcon.scrollFactor.set(0, 0);
        setFormat(Paths.font("opening.ttf"), 32, FlxColor.WHITE, RIGHT, OUTLINE, FlxColor.BLACK);

        trace(this);

    }

    override public function update(elapsed:Float){
        super.update(elapsed);
        if (CartridgeHandler.data.songNotis.contains(songName)){
            time += elapsed * 4;
            color = FlxColor.fromRGBFloat(1, 1, Math.abs(Math.sin(time)), 1);
        }
    }

    override public function draw():Void
        {
            super.draw();
    

            if (bfIcon != null){

                bfIcon.alpha = alpha;

 
                bfIcon.x = x + width - 24;
                bfIcon.y = y -60;
                bfIcon.cameras = cameras;
                bfIcon.draw();

                dadIcon.alpha = alpha;

                dadIcon.cameras = cameras;
                dadIcon.x = x - 120;
                dadIcon.y = y -60;
                dadIcon.draw();
                
            }

        }

        override public function destroy():Void
            {
                if (bfIcon != null){
    
                    bfIcon.destroy();
                    dadIcon.destroy();
                    
                }
                super.destroy();
        
    
                
    
            }


}