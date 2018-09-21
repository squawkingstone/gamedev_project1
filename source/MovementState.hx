package;

import flixel.math.FlxPoint;

class MovementState extends Level
{
    override public function create():Void
    {
        _file = "assets/maps/temp.tmx";
        _tilemap = AssetPaths.tiles__png;
        _player_start_position = new FlxPoint(24, 24);
        
        _monster_start_positions = new Array();
        _monster_start_positions.push(new FlxPoint(70, 48));

        _cache_start_positions = new Array();
        _cache_start_positions.push(new FlxPoint(16, 192));

        _next_level = new MovementState();
        _level_time = 5000;

        super.create();
    }
}