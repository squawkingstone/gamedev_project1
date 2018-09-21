package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxState;
import flixel.util.FlxSave;
import haxe.Timer;

class Monster extends Hurtable
{
    var scoreboard:FlxSave;
    var _walking_speed = 48;
    var _damage = 10;
    var velx = 0;
      
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        loadGraphic("assets/images/enemymoveattack.png", true, 64, 64);
        setFacingFlip(FlxObject.LEFT, false, false);
        setFacingFlip(FlxObject.RIGHT, true, false);
        animation.add("walking", [0,1,2,3,4,5], 10, true, false, false);
        animation.add("hit", [6], 1, false, true, false);
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
        velocity.set(velx, velocity.y);
        if (velocity.x > 0) facing = FlxObject.RIGHT; 
        else facing = FlxObject.LEFT;
        super.update(elapsed);
    }

    override public function hurt(damage:Float):Void
    {
        animation.play("hit");
        Timer.delay(function () { animation.play("walking"); }, 1000);
        super.hurt(damage);
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
