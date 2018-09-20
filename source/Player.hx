package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

// TIME IN HAXE IS IN SECONDS

class Player extends FlxSprite
{
    /* STATIC PROPERTIES */
    var _walking_speed = 128.0;
    var _climbing_speed = 80.0;
    var _jump_speed = 100.0;
    var _gravity = 200.0;
    var _attack_cooldown = 1.0;
    var _damage = 1;

    /* DYNAMIC PROPERTIES */
    var _climbing:Bool = false;
    var _attack_countdown = 0.0;
    
    /* PUBLIC VARIABLES */
    public var _facing = FlxObject.LEFT;
    public var _points:Int = 0;

    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        loadGraphic("assets/images/player.png", true, 16, 16);
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);
        animation.add("walking", [0], 1, true, false, false);
        animation.add("climbing", [1], 1, true, false, false);
        animation.play("walking");
        acceleration.y = _gravity;
    }

    public function process_movement(climb_overlap:Bool):Void
    {   
        if (_climbing)
        {
            // do climbing controls
            var velx = 0.0;
            velx += (FlxG.keys.anyPressed(["RIGHT", "D"])) ? _climbing_speed : 0.0;
            velx -= (FlxG.keys.anyPressed(["LEFT", "A"])) ? _climbing_speed : 0.0;

            var vely = 0.0;
            vely += (FlxG.keys.anyPressed(["DOWN", "S"])) ? _climbing_speed : 0.0;
            vely -= (FlxG.keys.anyPressed(["UP", "W"])) ? _climbing_speed : 0.0;

            velocity.set(velx, vely);

            // check if we need to not overlap
            if (!climb_overlap) toggle_climbing(false, false);
            if (FlxG.keys.justPressed.SPACE) toggle_climbing(false, true);
        }
        if (!_climbing)
        {
            var velx = 0.0;
            velx += (FlxG.keys.anyPressed(["RIGHT", "D"])) ? _walking_speed : 0.0;
            velx -= (FlxG.keys.anyPressed(["LEFT", "A"])) ? _walking_speed : 0.0;
            if (velx > 0.0) // this is bad, fix it later
            { 
                facing = FlxObject.RIGHT;
            }
            if (velx < 0.0) 
            {
                facing = FlxObject.LEFT;
            }
            velocity.x = velx;
            if (FlxG.keys.justPressed.SPACE && isTouching(FlxObject.FLOOR)) velocity.y = -_jump_speed;
            if ((FlxG.keys.justPressed.UP || FlxG.keys.justPressed.W) && climb_overlap) toggle_climbing(true, false);
        }
    }

    // cache attack function
    public function process_attack(target:FlxSprite)
    {
        if (FlxG.keys.justPressed.F && _attack_countdown <= 0.0) 
        { 
            target.hurt(_damage);
            _attack_countdown = _attack_cooldown;
            trace(target.health);
        }
    }

    function toggle_climbing(on:Bool, jumping:Bool)
    {
        if (on)
        {
            acceleration.y = 0;
            velocity.set(0,0);
            _climbing = true;
        }
        else
        {
            acceleration.y = _gravity;
            _climbing = false;
            if (jumping) velocity.y -= _jump_speed;
        }
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        if (_attack_countdown > 0.0) _attack_countdown -= elapsed;
    }

}