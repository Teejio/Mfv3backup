package substates;

import backend.WeekData;
import backend.Highscore;
import backend.Song;
import backend.CartridgeHandler;
import flixel.addons.transition.FlxTransitionableState;
import flixel.util.FlxStringUtil;
import states.StoryMenuState;
import states.FreeplayState;
import options.OptionsState;
import objects.FreeplayText;

class FreeplaySubState extends MusicBeatSubstate
{
	var grpText:FlxTypedSpriteGroup<FreeplayText>;

	var alphaGroup:FlxTypedSpriteGroup<FlxSprite>;

	var songList:Array<Array<String>>;

	static var curDifficulty = 2;

	var diffText:FlxText;
	var scoreText:FlxText;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;
	var beeg:FlxSprite;
	var scoreBG:FlxSprite;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var cartName:String;

	var trans:FlxSprite;
	var swirl:FlxSprite;
	var circle:FlxSprite;

	var overlay:FlxSprite;
	var targetSelected:Int = 0;
	var oldSelected:Int = 0;
	var curSelected:Float = 0;

	var canClick:Bool = false;

	var time:Float = 0;

	public function new(songs:Array<Array<String>>,name:String)
	{
		super();
		cartName = name;
		songList = songs;
		var tv:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('freeplay/pauseTV'));
		tv.antialiasing = ClientPrefs.data.antialiasing;
		tv.scrollFactor.set(0, 0);
		tv.scale.y = tv.scale.x = 1 / FlxG.camera.zoom;
		tv.updateHitbox();
		tv.screenCenter();
		// tv.y += 10;
		add(tv);

		alphaGroup = new FlxTypedSpriteGroup<FlxSprite>();
		alphaGroup.alpha = 0;
		alphaGroup.visible = false;
		add(alphaGroup);
		alphaGroup.scrollFactor.set(0, 0);

		grpText = new FlxTypedSpriteGroup<FreeplayText>();

		alphaGroup.add(grpText);

		var i = 0;
		for (array in songs)
		{
			var freeplayText = new FreeplayText(array, 500, 200, 0, array[0], 32);
			if (CartridgeHandler.data.songNotis.contains(array[0]))
			{
				freeplayText.setFormat(Paths.font("opening.ttf"), 32, FlxColor.YELLOW, RIGHT, OUTLINE, FlxColor.BLACK);
			}
			else
			{
				freeplayText.setFormat(Paths.font("opening.ttf"), 32, FlxColor.WHITE, RIGHT, OUTLINE, FlxColor.BLACK);
			}
			freeplayText.alpha = 0;
			grpText.add(freeplayText);
			freeplayText.scrollFactor.set(0, 0);

			freeplayText.screenCenter();
			freeplayText.y += (i * 55);
			i++;
		}

		diffText = new FlxText(0, 260, 0, "", 24);

		diffText.scrollFactor.set(0, 0);
		diffText.setFormat(Paths.font("vcr.ttf"), 26);
		diffText.screenCenter(X);

		scoreText = new FlxText(FlxG.width, 230, 0, "suck ma balls", 24);
		scoreText.setFormat(Paths.font("vcr.ttf"), 30);
		scoreText.scrollFactor.set(0, 0);
		scoreText.screenCenter(X);

		scoreBG = new FlxSprite(0, 220).makeGraphic(1, 66, 0xFF000000);
		scoreBG.scrollFactor.set(0, 0);
		scoreBG.screenCenter(X);
		scoreBG.alpha = 0.6;
		alphaGroup.add(scoreBG);
		alphaGroup.add(diffText);
		alphaGroup.add(scoreText);

		changeDifficulty(0);
		changeSong(0);

		// trace(scoreBG);
		trans = new FlxSprite(0, 70);
		trans.frames = Paths.getSparrowAtlas('transition');
		trans.animation.addByPrefix('start', 'intro', 24, false);
		trans.antialiasing = false;
		trans.alpha = 0.01;
		trans.color = FlxColor.BLUE;
		trans.setGraphicSize(895 / 2, 616 / 2);
		trans.updateHitbox();
		trans.screenCenter(X);
		add(trans);


		swirl = new FlxSprite(0,70);
		swirl.frames = Paths.getSparrowAtlas('EBencounter');
		swirl.animation.addByPrefix('start', 'intro', 24, false);
		swirl.antialiasing = false;
		swirl.alpha = 0.01;
		swirl.color = FlxColor.fromString('#0000ce');
		swirl.setGraphicSize(460, 320);
		swirl.updateHitbox();
		swirl.screenCenter(X);
		swirl.x -= 10;
		add(swirl);


		circle = new FlxSprite(0,60);
		circle.frames = Paths.getSparrowAtlas('BGencounter');
		circle.animation.addByPrefix('start', 'intro', 24, false);
		circle.antialiasing = false;
		circle.alpha = 0.01;
		circle.color = FlxColor.fromString('#0000ce');
		circle.setGraphicSize(470, 320);
		circle.updateHitbox();
		circle.screenCenter(X);
		add(circle);

		overlay = new FlxSprite(0, 225).makeGraphic(1, 1, FlxColor.BLACK);
		overlay.alpha = 0.01;
		overlay.scale.set(895 / 2, 700 / 2);
		overlay.screenCenter(X);
		add(overlay);
		var tvFront:FlxSprite = new FlxSprite(tv.x, tv.y).loadGraphic(Paths.image('freeplay/pauseTVFront'));
		tvFront.antialiasing = ClientPrefs.data.antialiasing;
		tvFront.scrollFactor.set(0, 0);
		tvFront.scale.y = tvFront.scale.x = tv.scale.y;
		tvFront.updateHitbox();
		add(tvFront);

		FlxTween.tween(alphaGroup, {alpha: 1}, 0.5, {
			ease: FlxEase.quadOut,
			onComplete: function(tween:FlxTween)
			{
				canClick = true;

				trace("poopoo");
			},
			onUpdate: function(tween:FlxTween)
			{
				scoreBG.alpha = alphaGroup.alpha * 0.6;

				var i = 0;
				grpText.forEach(function(leCart:FreeplayText)
				{
					leCart.alpha = 1 / (Math.abs(i) + 1);
					leCart.alpha *= 0.8 * alphaGroup.alpha;

					i++;

					if (alphaGroup.alpha > 0.1)
					{
						alphaGroup.visible = true;
					}
				});
			}
		});
	}

	override function update(elapsed:Float)
	{
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, FlxMath.bound(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, FlxMath.bound(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(CoolUtil.floorDecimal(lerpRating * 100, 2)).split('.');
		if (ratingSplit.length < 2)
		{ // No decimals, add an empty space
			ratingSplit.push('');
		}

		while (ratingSplit[1].length < 2)
		{ // Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		scoreText.text = 'HIGHSCORE: ' + lerpScore + ' ( ' + ratingSplit.join('.') + '% )';
		scoreText.screenCenter(X);

		scoreBG.scale.x = scoreText.width + 6;
		scoreBG.screenCenter(X);

		time += elapsed * 1.2;

		var func = Math.exp(0 - time);

		curSelected = ((1 - func) * targetSelected) + (func * curSelected);

		var i = 0;
		grpText.forEach(function(leCart:FreeplayText)
		{
			leCart.screenCenter();
			leCart.y += (i - curSelected) * (55);
			leCart.alpha = 1 / (Math.abs(i - curSelected) + 1);
			leCart.alpha *= 0.8;

			i++;
		});

		if (canClick)
		{
			if (controls.BACK)
			{
				canClick = false;

				FlxTween.tween(alphaGroup, {alpha: 0}, 0.3, {
					ease: FlxEase.expoOut,
					onComplete: function(tween:FlxTween)
					{
						trace("faggot");
						close();
					}
				});
			}
			if (controls.UI_DOWN_P)
			{
				changeSong(1);
			}
			else if (controls.UI_UP_P)
			{
				changeSong(-1);
			}
			else if (controls.UI_RIGHT_P)
			{
				changeDifficulty(1);
			}
			else if (controls.UI_LEFT_P)
			{
				changeDifficulty(-1);
			}
			else if (controls.ACCEPT)
			{
				trace(cartName);
				var wait:Float = 0;
				var songLowercase:String = Paths.formatToSongPath(songList[targetSelected][0]);
				var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
				PlayState.SONG = Song.loadFromJson(poop, songLowercase);
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = curDifficulty;

				canClick = false;
				persistentUpdate = false;
				FlxG.sound.music.volume = 0;
				switch (cartName)
				{
					case 'Mother3Songs':
						trans.alpha = 0.7;
						trans.animation.play('start', true);
						FlxG.sound.play(Paths.sound('M3encounter'), 0.7);
						wait = 2;
						if (songList[targetSelected][0] == 'Warforged') trans.color = FlxColor.RED;
					case 'Mother2Songs':
						swirl.alpha = 0.7;
						swirl.animation.play('start', true);
						FlxG.sound.play(Paths.sound('EBencounter'), 1);
						wait = 1.8;
					case 'MotherSongs':
						circle.alpha = 0.9;
						circle.animation.play('start', true);
						FlxG.sound.play(Paths.sound('BGencounter'), 1);
						wait = 1;	
				}

				new FlxTimer().start(wait, function(tmr:FlxTimer)
				{
					FlxTween.tween(FlxG.camera, {zoom: 4}, 0.75, {
						ease: FlxEase.backIn,
						startDelay: 0,
						onComplete: function(tween:FlxTween)
						{
						}
					});
					FlxTween.tween(overlay, {alpha: 1}, 0.25);
				});

				new FlxTimer().start(wait + 0.75, function(tmr:FlxTimer)
				{
					FlxG.camera.visible = false;
					LoadingState.loadAndSwitchState(new PlayState());
				});
			}
		}
		super.update(elapsed);
	}

	function updateFreeplayText():Void
	{
		intendedScore = Highscore.getScore(songList[targetSelected][0], curDifficulty);
		intendedRating = Highscore.getRating(songList[targetSelected][0], curDifficulty);
	}

	function changeSong(change:Int):Void
	{
		time = 0;
		FlxG.sound.play(Paths.sound('scrollMenu'));
		targetSelected += change;
		targetSelected = targetSelected % songList.length;
		if (targetSelected < 0)
		{
			targetSelected = songList.length + targetSelected;
		}
		updateFreeplayText();
	}

	function fadeSongs(name:String):Void {
		
	}
	function changeDifficulty(?change = 0):Void
	{
		curDifficulty += change;
		curDifficulty = curDifficulty % 3;
		if (curDifficulty < 0)
		{
			curDifficulty = 3 + curDifficulty;
		}
		updateFreeplayText();
		diffText.text = '< ' + Difficulty.defaultList[curDifficulty] + ' >';
		diffText.screenCenter(X);
	}
}
