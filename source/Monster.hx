package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxState;
import flixel.util.FlxSave;

class Monster extends Hurtable
{
    var scoreboard:FlxSave;
    var _walking_speed = 0;
    var _damage = 10;
    var velx = 0;
      
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        loadGraphic("assets/images/player.png", true, 16, 16);
        animation.add("walking", [0], 1, true, false, false);
        animation.play("walking");
        allowCollisions = FlxObject.ANY;
        velx = _walking_speed;
        health = 5;
        velocity.set(velx, 0);
        acceleration.y = 200.0;
    }
    
    override public function update(elapsed:Float):Void
    {
        if (isTouching(FlxObject.WALL)) velx *= -1;
        velocity.set(velx, 0);
        super.update(elapsed);
    }
    override public function kill()
    {
        scoreboard = new FlxSave();
        scoreboard.bind("Save");
        scoreboard.data.score += 25;
        scoreboard.flush();
        trace("AWARD POINTS");
        super.kill();
    }
}
