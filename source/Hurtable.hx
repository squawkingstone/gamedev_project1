package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import haxe.Timer;

class Hurtable extends FlxSprite
{
    var _invincibility_countdown : Float = 0.0;
    var _invincibility_time : Float = 1.0;
    var _hurt_color = 0xFFFF8080;

    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
    }

    override public function hurt(damage:Float)
    {
        if (_invincibility_countdown <= 0.0)
        {
            super.hurt(damage);
            _invincibility_countdown = _invincibility_time;
            color = _hurt_color;
        }
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        if (_invincibility_countdown > 0.0) _invincibility_countdown -= elapsed;
        else color = 0xFFFFFFFF;
    }

}