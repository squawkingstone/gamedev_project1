package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import haxe.Timer;

enum AnimState
{
    IDLE;
    WALK;
    CLIMB;
    JUMP;
    FALL;
    ATTACK;
    JUMP_ATTACK;
    DEATH;
}

class Player extends Hurtable
{
    /* STATIC PROPERTIES */
    var _walking_speed = 200.0;
    var _climbing_speed = 80.0;
    var _jump_speed = 250.0;
    var _gravity = 350.0;
    var _attack_cooldown = 0.6;
    var _damage = 1;

    /* DYNAMIC PROPERTIES */
    var _climbing:Bool = false;
    var _attack_countdown = 0.0;
    var _attacking:Bool = false;
    var _jumping:Bool = false;

    var _anim_state : AnimState = IDLE;
	var jumpsound : FlxSound;
	
    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
        super(X, Y, SimpleGraphic);
        loadGraphic("assets/images/animation.png", true, 64, 64);
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);
        animation.add("jump", [0,1,2,3,4,5,6,7], 10, true, false, false); // maybe pause this???
        animation.add("jump_attack", [10,11,12,13,14,15,16,17], 10, false, false, false);
        animation.add("attack", [20,21,22,23,24,25], 10, false, false, false);
        animation.add("walk", [30,31,32,33,34,35,36,37,38,39], 10, true, false, false);
        animation.add("climb", [41,42,43,44,45,46], 10, true, false, false); // pause while still
        animation.add("idle", [50,51,52,53], 10, true, false, false);
        animation.add("death", [60,61,62], 10, false, false, false);
        animation.play("idle");
        health = 10;
        acceleration.y = _gravity;
		jumpsound = FlxG.sound.load(AssetPaths.Jump__wav);
    }

    public function process_movement(climb_overlap:Bool):Void
    {   
        if (_climbing)
        {
            // do climbing controls
            var velx = 0.0;
            velx += (FlxG.keys.anyPressed(["RIGHT", "D"])) ? _climbing_speed : 0.0;
            velx -= (FlxG.keys.anyPressed(["LEFT", "A"])) ? _climbing_speed : 0.0;

            if (velx > 0.0) { facing = FlxObject.RIGHT; }
            if (velx < 0.0) { facing = FlxObject.LEFT; }

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

            if (velx > 0.0) { facing = FlxObject.RIGHT; }
            if (velx < 0.0) { facing = FlxObject.LEFT; }

            velocity.x = velx;
            if (FlxG.keys.justPressed.SPACE && isTouching(FlxObject.FLOOR)) 
            {
                velocity.y = -_jump_speed;
                _jumping = true;
                animation.play("jump");
				jumpsound.play(true);
            }
            if ((FlxG.keys.justPressed.UP || FlxG.keys.justPressed.W) && climb_overlap) toggle_climbing(true, false);
        }
    }

    public function process_attack(target:FlxSprite)
    {
        if (FlxG.keys.justPressed.F && _attack_countdown <= 0.0) 
        { 
            target.hurt(_damage);
            _attack_countdown = _attack_cooldown;
            if (_jumping) 
            {
                animation.play("jump_attack");
            }
            else
            {
                animation.play("attack");
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
            if (jumping) {
				velocity.y -= _jump_speed;
				jumpsound.play(true);
			}
        }
    }

    override public function update(elapsed:Float):Void
    {
        if (_attack_countdown > 0.0) _attack_countdown -= elapsed;
        if (_attacking && _attack_countdown <= 0.0) _attacking = false;
        if (_jumping && isTouching(FlxObject.FLOOR)) _jumping = false;
        if (FlxG.keys.justPressed.F) 
        {
            animation.play("attack");
            _attacking = true;
            Timer.delay(function ()
            {
                _attacking = false;
            }, 600);
        }
        update_animation();
        super.update(elapsed);
    }

    public function update_animation()
    {
        var next_state : AnimState = IDLE;

        if (!_jumping && !_attacking)
        {
            if (Math.abs(velocity.x) <= 10 && Math.abs(velocity.y) <= 10)
            {
                if (!_climbing) { next_state = IDLE; }
                if (_climbing) { next_state = CLIMB; }
            }
            else
            {
                if (!_climbing) { next_state = WALK; }
                if (_climbing) { next_state = CLIMB; }
            }

            if (_anim_state != next_state)
            {
                _anim_state = next_state;
                switch(_anim_state)
                {
                    case IDLE:
                        animation.play("idle");
                    case WALK:
                        animation.play("walk");
                    case CLIMB:
                        animation.play("climb");
                    default:
                        animation.play("jump");
                }
            }
        }
        
        

    }   

    override public function kill():Void
    {
        animation.play("death");
        Timer.delay(function () 
        {
            super_kill();
        }, 300);
    }

    public function super_kill()
    {
        super.kill();
    }

}