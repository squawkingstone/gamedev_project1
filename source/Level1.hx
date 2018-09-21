package;

import flixel.math.FlxPoint;

class Level1 extends Level
{
    override public function create():Void
    {
        _file = "assets/maps/smallintestine.tmx";
        _tilemap = AssetPaths.guts__png;
        _player_start_position = new FlxPoint(580, 2800);
        
        _monster_start_positions = new Array();
        _monster_start_positions.push(new FlxPoint(1152, 1536));
        _monster_start_positions.push(new FlxPoint(1344, 1790));
        _monster_start_positions.push(new FlxPoint(2432, 1472));
        _monster_start_positions.push(new FlxPoint(2816, 1728));
        _monster_start_positions.push(new FlxPoint(2368, 1984));
        _monster_start_positions.push(new FlxPoint(1152, 2304));
        _monster_start_positions.push(new FlxPoint(1408, 2816));
        _monster_start_positions.push(new FlxPoint(1472, 3072));
        _monster_start_positions.push(new FlxPoint(2304, 2560));
        _monster_start_positions.push(new FlxPoint(2752, 2560));

        _cache_start_positions = new Array();
        _cache_start_positions.push(new FlxPoint(1856, 2560));
        _cache_start_positions.push(new FlxPoint(2560, 2560));
        _cache_start_positions.push(new FlxPoint(2560, 1984));
        _cache_start_positions.push(new FlxPoint(1152, 2304));
        _cache_start_positions.push(new FlxPoint(960, 1920));
        
    

        _next_level = new Level2();
        _level_time = 60000;

        super.create();
    }
}
