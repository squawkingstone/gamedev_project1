package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Cache extends FlxSprite
{

    public var _max_health = 10;

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

    override public function kill()
    {
        trace("AWARD POINTS");
        super.kill();
    }

}