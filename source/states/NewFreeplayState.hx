package states;

import backend.WeekData;
import backend.Highscore;
import backend.Song;
import backend.CartridgeHandler;

import lime.utils.Assets;
import flixel.math.FlxPoint;
import openfl.utils.Assets as OpenFlAssets;

import objects.HealthIcon;
import states.editors.ChartingState;

import substates.GameplayChangersSubstate;
import substates.ResetScoreSubState;

#if MODS_ALLOWED
import sys.FileSystem;
#end

import objects.Cartridge;
import substates.FreeplaySubState;
import flixel.FlxSubState;

class NewFreeplayState extends MusicBeatState
{
	var grpWeekCartridges:FlxTypedSpriteGroup<Cartridge>;
	var time:Float = 0;

	static var targetSelected:Int = 0;

	var oldSelected:Int = targetSelected;
	var curSelected:Float = targetSelected;
	var objSelected:Bool = false;
	var penis:Array<String> = Cartridge.getNames();
	var bg:FlxSprite;
	var clicked:Bool = false;
	var moving:Bool = true;

	public static var zoopyZop:Map<String, Float> = new Map<String, Float>();

	var objective:FlxText;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		time = 0;

		bg = new FlxSprite(-80).loadGraphic(Paths.image('bg'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scrollFactor.set(0, 0);
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		var tv:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('freeplay/tv'));
		tv.antialiasing = ClientPrefs.data.antialiasing;
		//	tv.scrollFactor.set(0, 0);
		tv.scale.y = tv.scale.x = 730 / 1447;
		tv.updateHitbox();
		tv.screenCenter();
		tv.y += 10;
		add(tv);

		grpWeekCartridges = new FlxTypedSpriteGroup<Cartridge>();
		add(grpWeekCartridges);

		trace(penis);
		for (weekName in penis)
		{
			var i = penis.indexOf(weekName);
			var cartridge:Cartridge = new Cartridge(0, i * 100, weekName, i);
			cartridge.scale.x = cartridge.scale.y = 0.5;
			cartridge.updateHitbox();
			cartridge.screenCenter();

			cartridge.x += i * 100;

			cartridge.y += 100;

			zoopyZop[weekName] = cartridge.y;
			trace(cartridge.y);

			grpWeekCartridges.add(cartridge);
		}

		objective = new FlxText(0, 100, 400, "", 24);
		objective.setFormat(Paths.font("opening.ttf"), 32, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
		add(objective);

		var tvFront:FlxSprite = new FlxSprite(tv.x, tv.y).loadGraphic(Paths.image('freeplay/tvFront'));
		tvFront.antialiasing = ClientPrefs.data.antialiasing;
		// tvFront.scrollFactor.set(0, 0);
		tvFront.scale.y = tvFront.scale.x = tv.scale.y;
		tvFront.updateHitbox();
		add(tvFront);
		objective.alpha = 0.8;
		changeSelection(0);
		super.create();
	}

	/*public function addWeek(songs:Array<String>, weekNum:Int, weekColor:Int, ?songCharacters:Array<String>)
		{
			if (songCharacters == null)
				songCharacters = ['bf'];

			var num:Int = 0;
			for (song in songs)
			{
				addSong(song, weekNum, songCharacters[num]);
				this.songs[this.songs.length-1].color = weekColor;

				if (songCharacters.length != 1)
					num++;
			}
	}*/
	override function update(elapsed:Float)
	{
		time += elapsed * 0.8;

		var varSelected = Std.int(mod(targetSelected, penis.length)); // hehe penis.length;

		if (varSelected == -1)
		{
			varSelected = penis.length - 1;
		}

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
		if (!objSelected)
		{
			if (controls.UI_LEFT_P && moving)
				changeSelection(-1);
			else if (controls.UI_RIGHT_P && moving)
				changeSelection(1);

			if (controls.BACK)
			{
				persistentUpdate = false;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}
			else if (controls.ACCEPT && moving)
			{
				moving = false;
				if (CartridgeHandler.data.catridgeUnlock[penis[varSelected]])
				{
					FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
					clicked = true;
				}
				else
				{
					FlxG.sound.play(Paths.sound('bruhv'), 0.7);
					FlxG.camera.shake(0.005, 0.5, true);
					FlxG.camera.flash(FlxColor.RED, 0.5, function()
					{
						moving = true;
						FlxG.camera.zoom = 1;
					}, true);
				}
			}

			if ((clicked == true) && (Math.abs(targetSelected - curSelected) < 0.01))
			{
				clicked = false;
				moving = true;

				objSelected = true;

				var dicks = grpWeekCartridges.members[Std.int(varSelected)];

				subStateClosed.add(function(state:FlxSubState)
				{
					grpWeekCartridges.alpha = 0;
					dicks.y = grpWeekCartridges.members[Std.int(varSelected)].y;
					FlxTween.tween(grpWeekCartridges.members[Std.int(varSelected)], {y: zoopyZop[dicks.name]}, 0.5, {
						ease: FlxEase.quadInOut,
						startDelay: 0.1,
						onComplete: function(tween:FlxTween)
						{
							trace("poopoo");
						}
					});

					FlxTween.tween(FlxG.camera, {zoom: 1}, 0.5, {
						ease: FlxEase.expoInOut,
						startDelay: 0.1,
						onComplete: function(tween:FlxTween)
						{
							// trace("poopoo");
						},
						onUpdate: function(tween:FlxTween)
						{
							FlxG.camera.scroll.y = (FlxG.camera.zoom - 1) * -150;
							objective.alpha = 1 - (FlxG.camera.zoom - 1);
							objective.alpha *= 0.8;

							grpWeekCartridges.alpha = 1 - (FlxG.camera.zoom - 1);
						}
					});
				});

				FlxTween.tween(grpWeekCartridges.members[Std.int(varSelected)], {y: 550 - (dicks.height * dicks.scale.y)}, 0.8, {
					ease: FlxEase.backInOut,
					onComplete: function(tween:FlxTween)
					{
						FlxTween.tween(FlxG.camera, {zoom: 2}, 2, {
							ease: FlxEase.expoInOut,
							startDelay: 0,
							onComplete: function(tween:FlxTween)
							{
								objSelected = false;
								trace("poopoo");

								var freeplay = new FreeplaySubState(Cartridge.cartFiles[dicks.name].songs, dicks.name);
								openSubState(freeplay);
							},
							onUpdate: function(tween:FlxTween)
							{
								FlxG.camera.scroll.y = (FlxG.camera.zoom - 1) * -150;
								objective.alpha = 1 - (FlxG.camera.zoom - 1);
								objective.alpha *= 0.8;
							}
						});

						trace("poopoo");
					}
				});

				trace(varSelected);
			}

			var func = Math.exp(0 - time);

			curSelected = ((1 - func) * targetSelected) + (func * curSelected);

			// trace(curSelected);

			grpWeekCartridges.forEach(function(leCart:Cartridge)
			{
				leCart.screenCenter();
				leCart.x += (leCart.idx - curSelected) * (1280 / (grpWeekCartridges.length / 2));

				leCart.x = mod(leCart.x + 1280, 1280 * 2) - 1280;

				leCart.y += 100;
			});
		}

		super.update(elapsed);
	}

	function changeSelection(change:Int)
	{
		time = 0;
		oldSelected = targetSelected;
		targetSelected += change;

		var varSelected = Std.int((mod(targetSelected, penis.length, true))); // hehe penis.length;
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		if (varSelected == -1)
		{
			varSelected = penis.length - 1;
		}

		var shitHead = grpWeekCartridges.members[Std.int(varSelected)].name;
		trace(Cartridge.hintText[shitHead]);

		objective.text = (CartridgeHandler.data.catridgeUnlock[penis[varSelected]]) ? "Press ACCEPT button to select song" : Cartridge.hintText[shitHead];

		objective.screenCenter();
		objective.y -= 120;
		// trace(targetSelected);
	}

	function mod(a:Float, b:Int, ?traceIt:Bool = false):Float
	{
		var r = a % b;
		if (traceIt)
		{
			trace(r);
		}

		if (r < 0)
		{
			r = b + r;
		}

		return r;
	}
}
