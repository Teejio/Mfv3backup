

package objects;

class Noti extends FlxSprite
{
	public var sprTracker:FlxSprite;

	public function new(size:Int)
	{
		super();
        loadGraphic(Paths.image("noti"));
        setGraphicSize(size);
		//scrollFactor.set();
	}

	public function updatePosition()
	{


		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width - (width/2), sprTracker.y - (height/2));

         //trace(this);
	}

    override public function draw():Void
        {
            updatePosition();
            super.draw();
    

        }
}
