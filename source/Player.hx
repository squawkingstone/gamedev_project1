package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends FlxSprite
{

    var _climbing:Bool = false;
    var _walking_speed = 128.0;
    var _jump_speed = 80.0;

    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        loadGraphic("assets/images/player.png", true, 16, 16);
        animation.add("walking", [0], 1, true, false, false);
        animation.add("climbing", [1], 1, true, false, false);
        animation.play("walking");
        acceleration.y = 80;
    }

    public function process_movement():Void
    {
        var velx = 0.0;
        velx += (FlxG.keys.anyPressed(["RIGHT", "D"])) ? _walking_speed : 0.0;
        velx -= (FlxG.keys.anyPressed(["LEFT", "A"])) ? _walking_speed : 0.0;
        velocity.x = velx;

        if (FlxG.keys.anyJustPressed(["UP", "W"])) velocity.y = -_jump_speed;
    }

}