package;

import flixel.math.FlxPoint;

class Level1 extends Level
{
    override public function create():Void
    {
        _file = "assets/maps/smallintestine.tmx";
        _tilemap = AssetPaths.guts__png;
        _player_start_position = new FlxPoint(1800, 1100);
        
        _monster_start_positions = new Array();
        _monster_start_positions.push(new FlxPoint(70, 48));

        _cache_start_positions = new Array();
        _cache_start_positions.push(new FlxPoint(16, 192));

        _next_level = new MovementState();
        _level_time = 60000;

        super.create();
    }
}