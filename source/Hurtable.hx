package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import haxe.Timer;

// Make the flickering work

class Hurtable extends FlxSprite
{
    var _damage_flicker_countdown : Float = 0.0;
    var _damage_flicker_time : Float = 0.05;
    var _invincibility_time : Float = 1.0;
    var _hurt_color = 0xFFFF8080;
    var _flicker : Bool;
    var _flicker_timer : Timer;

    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
    }

    override public function hurt(damage:Float)
    {
        if (_damage_flicker_countdown <= 0.0)
        super.hurt(damage);
        _damage_flicker_countdown = _damage_flicker_time;
        color = _hurt_color;
        trace("OUCH");
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        if (_damage_flicker_countdown > 0.0) _damage_flicker_countdown -= elapsed;
        else color = 0xFFFFFFFF;
    }

}