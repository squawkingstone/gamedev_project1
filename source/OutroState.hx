package;

import flixel.FlxState;
import flixel.FlxGame;
import haxe.Timer;
import flixel.FlxG;
import flixel.util.FlxSave;

class OutroState extends FlxState
{
    var scoreboard:FlxSave;
    override public function create():Void
    {
        scoreboard = new FlxSave();
        scoreboard.bind("Save");
        var score = scoreboard.data.score;
        super.create();
        if (score >= 1000) var text = new flixel.text.FlxText(0, 0, 400, "Congratulations Pilot, you have saved humanity. I hereby declare you the savior of humanity!", 16);
        else var text = new flixel.text.FlxText(0, 0, 400, "You did not gather enough information for us to develop a vaccine. Humanity is doomed.", 16);
        text.screenCenter();
        add(text);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}