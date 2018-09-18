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
    var _dissect_time = 20.0;

    /* DYNAMIC PROPERTIES */
    var _climbing:Bool = false;
    var _dissecting:Bool = false;
    var _attack_countdown = 0.0;
    var _dissect_countdown = 0.0;
    
    /* PUBLIC VARIABLES */
    public var _facing = FlxObject.LEFT;

    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        loadGraphic("assets/images/player.png", true, 16, 16);
        animation.add("walking_right", [0], 1, true, false, false);
        animation.add("walking_left", [0], 1, true, true, false);
        animation.add("climbing", [1], 1, true, false, false);
        animation.play("walking_right");
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
                animation.play("walking_right"); 
                _facing = FlxObject.RIGHT;
            }
            if (velx < 0.0) 
            {
                animation.play("walking_left");
                _facing = FlxObject.LEFT;
            }
            velocity.x = velx;
            if (FlxG.keys.justPressed.SPACE && isTouching(FlxObject.FLOOR)) velocity.y = -_jump_speed;
            if ((FlxG.keys.justPressed.UP || FlxG.keys.justPressed.W) && climb_overlap) toggle_climbing(true, false);
        }
    }

    // function assumes overlap, otherwise it's not called
    public function process_attack(enemy:FlxObject)
    {
        // do some amount of damage to the enemy, then wait for a cooldown so you can't just spam the
        // attack button and do infinite damage
        
        /*
            check if I've just pressed the button and the cooldown is zero. cooldown will get decremented
            in update
        */
        if (FlxG.keys.justPressed.F && _attack_countdown <= 0.0) 
        { 
            trace("ATTACK");
            _attack_countdown = _attack_cooldown;
        }
    }

    /*  This is lightly correct. Ultimately, I'll want to make a cache object later with it's own 
        behavior. It should store it's own "health" and the dissection should be done with damage and
        timing. Maybe I should just not have a time and just have it take damage and then call that
        good, might be fine.... we should probably have different sprites with a damage progression...
        then it can just not take damage if it's been "killed"
     */
    public function process_dissect(overlapping:Bool, elapsed:Float, cache:FlxSprite) 
    {
        if (overlapping && (FlxG.keys.pressed.F || FlxG.keys.justPressed.F))
        {
            if (!_dissecting)
            {
                _dissecting = true;
                _dissect_countdown = _dissect_time;
            }
            else
            {
                _dissect_countdown -= elapsed;
                if (_dissect_countdown <= 0.0)
                {
                    trace("DONE DISSECTING"); // destroy cache and add points
                    cache.kill(); // make sure to disable collision or overlap here, because currently
                                  // overlap call still returns true after kill() or destroy()
                    _dissecting = false;
                }
            } 
        }
        else 
        {
            if (_dissecting)
            {
                _dissecting = false;
                _dissect_countdown = 0.0;
            }
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
        trace(_dissect_countdown);
    }

}