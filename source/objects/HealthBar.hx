package objects;

import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxGradient;
import flixel.util.FlxSpriteUtil;


class HealthBar extends FlxSpriteGroup
{
	//public var leftBar:FlxSprite = FlxGradient.createGradientFlxSprite(700, 700, [0xffff0000, 0xffff8000, 0xffffff00], 2 );
	public var leftBar:FlxSprite;
	public var rightBar:FlxSprite;


	public var bg:FlxSprite;
	public var bgCover:FlxSprite;

	public var valueFunction:Void->Float = function() return 0;
	public var percent(default, set):Float = 0;
	public var bounds:Dynamic = {min: 0, max: 1};
	public var leftToRight(default, set):Bool = true;
	public var barCenter(default, null):Float = 0;

	

	// you might need to change this if you want to use a custom bar
	public var barWidth(default, set):Int = 1;
	public var barHeight(default, set):Int = 1;
	public var barOffset:FlxPoint = new FlxPoint(3, 3);

	public var isTimeBar:Bool = false;



	public function new(x:Float, y:Float, image:String = 'healthBar', valueFunction:Void->Float = null, boundX:Float = 0, boundY:Float = 1)
	{
		super(x, y);
		
		if(valueFunction != null) this.valueFunction = valueFunction;
		setBounds(boundX, boundY);

		var coverThing:String = image + 'Cover';
		var fillThing:String = image + 'Fill';

		if(image == 'timeBar') isTimeBar = true;
		
				bg = new FlxSprite().loadGraphic(Paths.image(image));
				bg.antialiasing = ClientPrefs.data.antialiasing;

				
				barWidth = Std.int(bg.width);
				barHeight = Std.int(bg.height);		

				bgCover = new FlxSprite().loadGraphic(Paths.image(coverThing));
				bgCover.x = bg.x;
				bgCover.y = bg.y;
				bgCover.antialiasing = ClientPrefs.data.antialiasing;

				bgCover.width = barWidth;
				bgCover.height = barHeight;

				
				
				leftBar = new FlxSprite().loadGraphic(Paths.image(fillThing));	
				leftBar.color = FlxColor.WHITE;					

				rightBar = new FlxSprite().loadGraphic(Paths.image(fillThing));	
				rightBar.color = FlxColor.BLACK;
				
	
				
				rightBar.antialiasing = ClientPrefs.data.antialiasing;
				leftBar.antialiasing = antialiasing = ClientPrefs.data.antialiasing;

				add(leftBar);
				add(rightBar);
				add(bg);
				add(bgCover);

		regenerateClips();
	}

	override function update(elapsed:Float) {
		var value:Null<Float> = FlxMath.remapToRange(FlxMath.bound(valueFunction(), bounds.min, bounds.max), bounds.min, bounds.max, 0, 100);
		percent = (value != null ? value : 0);
		super.update(elapsed);
	}

	
	public function setBounds(min:Float, max:Float)
	{
		bounds.min = min;
		bounds.max = max;
	}

	public function setColors(left:FlxColor, right:FlxColor)
	{		
		//GOTTA ADAPT >='(
		if(isTimeBar)
			{
				//FlxSpriteUtil.fill(rightBar, FlxColor.BLACK);
				FlxGradient.overlayGradientOnFlxSprite(leftBar, Std.int(barWidth * 1.25), Std.int(barHeight * 1.5), [left, right], 0, 0, 1, 0);
			}
		else {
			leftBar.color = left;
			rightBar.color = right;				
		}
			
	}

	public function updateBar()
	{
			if(leftBar == null || rightBar == null) return;			
			
			if(isTimeBar)
			{
				leftBar.setPosition(bg.x + 3, bg.y + 1);
				rightBar.setPosition(bg.x - 2, bg.y + 1);
			}
			else
			{
				leftBar.setPosition(bg.x + 3, bg.y);
				rightBar.setPosition(bg.x - 3, bg.y);
			}
			
				
			

		var leftSize:Float = 0;
		if(leftToRight) leftSize = FlxMath.lerp(0, barWidth, percent / 100);
		else leftSize = FlxMath.lerp(0, barWidth, 1 - percent / 100);

		leftBar.clipRect.width = leftSize;
		leftBar.clipRect.height = barHeight;
		leftBar.clipRect.x = barOffset.x;
		leftBar.clipRect.y = barOffset.y;

		rightBar.clipRect.width = barWidth - leftSize;
		rightBar.clipRect.height = barHeight;
		rightBar.clipRect.x = barOffset.x + leftSize;
		rightBar.clipRect.y = barOffset.y;

		barCenter = leftBar.x + leftSize + barOffset.x;

		// flixel is retarded
		leftBar.clipRect = leftBar.clipRect;
		rightBar.clipRect = rightBar.clipRect;
		
		
	}

	public function regenerateClips()
	{
		
			if(isTimeBar)
				{
					if(leftBar != null)
						{
							leftBar.setGraphicSize(Std.int(barWidth - 6), Std.int(barHeight - 6));
							leftBar.updateHitbox();
							leftBar.clipRect = new FlxRect(0, 0, Std.int(barWidth - 6), Std.int(barHeight - 6));
						}
						if(rightBar != null)
						{
							rightBar.setGraphicSize(Std.int(barWidth - 6), Std.int(barHeight - 6));
							rightBar.updateHitbox();
							rightBar.clipRect = new FlxRect(0, 0, Std.int(barWidth - 6), Std.int(barHeight - 6));
						}

				}
			else {
				if(leftBar != null)
					{
						leftBar.setGraphicSize(Std.int(barWidth - 2), Std.int(barHeight - 2));
						leftBar.updateHitbox();
						leftBar.clipRect = new FlxRect(0, 0, Std.int(barWidth - 2), Std.int(barHeight - 2));
					}
					if(rightBar != null)
					{
						rightBar.setGraphicSize(Std.int(barWidth - 2), Std.int(barHeight - 2));
						rightBar.updateHitbox();
						rightBar.clipRect = new FlxRect(0, 0, Std.int(barWidth - 2), Std.int(barHeight - 2));
					}
			}
			
		
				
			
		updateBar();
	}

	private function set_percent(value:Float)
	{
		var doUpdate:Bool = false;
		if(value != percent) doUpdate = true;
		percent = value;

		if(doUpdate) updateBar();
		return value;
	}

	private function set_leftToRight(value:Bool)
	{
		leftToRight = value;
		updateBar();
		return value;
	}

	private function set_barWidth(value:Int)
	{
		barWidth = value;
		regenerateClips();
		return value;
	}

	private function set_barHeight(value:Int)
	{
		barHeight = value;
		regenerateClips();
		return value;
	}
}