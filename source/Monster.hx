package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxState;

class Monster extends FlxSprite
{
    var _walking_speed = 200;
    var _damage = 10;
    var _life = 50;
      
public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
{
    super(X, Y, SimpleGraphic);
    loadGraphic("assets/images/player.png", true, 16, 16);
    animation.add("walking", [0], 1, true, false, false);
    animation.play("walking");
    allowCollisions = FlxObject.ANY;
    var velx = _walking_speed;
    velocity.set(velx, 0);
}
override public function update(elapsed:Float):Void
{
    super.update(elapsed);
    var velx = velocity.x;
    if (isTouching(FlxObject.WALL)) velx = velocity.x * -1;
    velocity.set(velx, 0);
}
}
