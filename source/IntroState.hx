package;

import flixel.FlxState;
import flixel.FlxGame;
import haxe.Timer;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.util.FlxSave;
import flixel.util.FlxColor;
import flixel.text.FlxText.FlxTextAlign;

class IntroState extends FlxState
{
    var playButton : FlxButton;
    override public function create():Void
    {
        super.create();
        var text = new flixel.text.FlxText(0, 0, 400, "You are the last hope of humanity. An unknown virus has turned 99% of humans into zombies, the walking dead. We still have no idea how this virus works, and that is what you are here to find out. We have captured a zombie and developed a prototype nanobot which you must pilot in order to obtain information about this virus, and hopefully create a vaccine! We will inject you into the intestines and you must make your way through there into the stomach and then into the brain for extraction. There are certain key infection zones in each area which you must analyze to find a cure. Good luck pilot!
", 16);
        text.setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.CENTER, null, FlxColor.WHITE, false);
        text.screenCenter();
        add(text);
        playButton = new FlxButton(280, 380, "Play", clickPlay);
        add(playButton);

        var save = new FlxSave();
        save.bind("Save");
        save.data.score = 0;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
    function clickPlay():Void
    {
        FlxG.switchState(new Level1());
    }

}