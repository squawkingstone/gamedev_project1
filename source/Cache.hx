package;

import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Cache extends Hurtable
{

    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        /* REPLACE WITH ACTUAL GRPAHIC */
        makeGraphic(32, 32, 0xFFFFFFFF, false, null);
        setSize(32, 32);
        allowCollisions = FlxObject.ANY;
        immovable = true;
        health = 10;
    }

    override public function kill()
    {
        trace("AWARD POINTS");
        super.kill();
    }

}