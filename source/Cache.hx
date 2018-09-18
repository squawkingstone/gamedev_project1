package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Cache extends FlxSprite
{
    var _max_health = 10;
    var _damage_anim_cooldown = 0.0;

    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        /* REPLACE WITH ACTUAL GRPAHIC */
        makeGraphic(32, 32, 0xFFFFFFFF, false, null);
        setSize(32, 32);
        allowCollisions = FlxObject.ANY;
        immovable = true;
        health = _max_health;
    }

    override public function hurt(damage:Float)
    {
        super.hurt(damage);
        _damage_anim_cooldown = 0.1;
        color = 0xFFFF8080;
    }

    override public function kill()
    {
        trace("AWARD POINTS");
        super.kill();
    }

    override public function update(elapsed:Float)
    {
        if (_damage_anim_cooldown > 0.0) _damage_anim_cooldown -= elapsed;
        else color = 0xFFFFFFFF;
    }

}