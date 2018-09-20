package;

import flixel.FlxState;
import flixel.FlxGame;
import haxe.Timer;
import flixel.FlxG;

class IntroState extends FlxState
{
    override public function create():Void
    {
        super.create();
        var text = new flixel.text.FlxText(0, 0, 400, "You are the last hope of humanity. An unknown virus has turned 99% of humans into zombies, the walking dead. We still have no idea how this virus works, and that is what you are here to find out. We have captured a zombie and developed a prototype nanobot which you must pilot in order to obtain information about this virus, and hopefully create a vaccine! We will inject you into the intestines and you must make your way through there into the stomach and then into the brain for extraction. There are certain key infection zones in each area which you must analyze to find a cure. Good luck pilot!
", 16);
        text.screenCenter();
        add(text);
        Timer.delay(function () {
            FlxG.switchState(new MovementState());
        }, 15000);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}