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
        _monster_start_positions.push(new FlxPoint(1000, 1000));
        _monster_start_positions.push(new FlxPoint(1200, 1150));
        _monster_start_positions.push(new FlxPoint(1300, 1250));
        _monster_start_positions.push(new FlxPoint(1400, 1350));
        _monster_start_positions.push(new FlxPoint(1500, 1450));
        _monster_start_positions.push(new FlxPoint(1600, 1550));
        _monster_start_positions.push(new FlxPoint(1700, 1650));
        _monster_start_positions.push(new FlxPoint(1800, 1750));
        _monster_start_positions.push(new FlxPoint(1900, 1850));
        _monster_start_positions.push(new FlxPoint(2000, 1950));
        _monster_start_positions.push(new FlxPoint(1100, 1050));
        _monster_start_positions.push(new FlxPoint(1170, 1100));
        _monster_start_positions.push(new FlxPoint(1200, 1200));
        _monster_start_positions.push(new FlxPoint(1300, 1300));
        _monster_start_positions.push(new FlxPoint(1400, 1400));
        _monster_start_positions.push(new FlxPoint(1500, 1500));
        _monster_start_positions.push(new FlxPoint(1600, 1600));
        _monster_start_positions.push(new FlxPoint(1700, 1700));
        _monster_start_positions.push(new FlxPoint(1800, 1800));
        _monster_start_positions.push(new FlxPoint(1900, 1900));
        _monster_start_positions.push(new FlxPoint(2000, 2000));
        _monster_start_positions.push(new FlxPoint(2100, 2100));

        _cache_start_positions = new Array();
        _cache_start_positions.push(new FlxPoint(16, 192));

        _next_level = new Level2();
        _level_time = 60000;

        super.create();
    }
}