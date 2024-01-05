function onCreatePost()
    addHaxeLibrary("FlxTrail", "flixel.addons.effects")
    runHaxeCode([[

    var numTrails:Int = 6;
    var trailSpacing:Float = 1.0;
    var trailColors:Array<Int> = [
        0xFF8B0040, // Indigo (Shifted towards red)
        0xFF000080, // Blue (Shifted towards red)
        0xFF00A000, // A shade of green
        0xFFFF8000, // Yellow
        0xFFC00000  // A shade of red (less intense)
    ];

    // Pre-calculated x and y components for each angle
    var angleComponents:Array<{ x: Float, y: Float }> = [
        { x: 0, y: -1 }, // Up
        { x: 1, y: -1 }, // Up right
        { x: 1, y: 0 }, // Right
        { x: 1, y: 1 }, // Down right
        { x: 0, y: 1 }, // Down
        { x: -1, y: 1 }, // Down left
        { x: -1, y: 0 }, // Left
        { x: -1, y: -1 } // Up left
    ];

    var trails:Array<FlxTrail> = [];
    var trails2:Array<FlxTrail> = [];
    for (i in 0...numTrails) {
        var fadeAmount:Float = 1.0   - (0.1 * i);

        var trail:FlxTrail = new FlxTrail(game.dad, null, 10, 4, fadeAmount, 0.1);
        trail.color = trailColors[i % trailColors.length];
        var angleIndex:Int = i % angleComponents.length;
        trail.velocity.x = angleComponents[angleIndex].x * 400;
        trail.velocity.y = angleComponents[angleIndex].y * 400;
        trail.blend = 8;
        trails.push(trail);
        game.addBehindDad(trail);
        trail.x += i * trailSpacing;
    }
    ]])
end
