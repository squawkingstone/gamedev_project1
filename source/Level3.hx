package;

import flixel.math.FlxPoint;

class Level3 extends Level
{
    override public function create():Void
    {
        _file = "assets/map/Brain Map.tmx";
        _tilemap = AssetPaths.BrainTilesheet__png;
        _player_start_position = new FlxPoint(1800, 1100);
        
        _monster_start_positions = new Array();
        _monster_start_positions.push(new FlxPoint(70, 48));
        _monster_start_positions.push(new FlxPoint(200, 150));
        _monster_start_positions.push(new FlxPoint(300, 250));
        _monster_start_positions.push(new FlxPoint(400, 350));
        _monster_start_positions.push(new FlxPoint(500, 450));
        _monster_start_positions.push(new FlxPoint(600, 550));
        _monster_start_positions.push(new FlxPoint(700, 650));
        _monster_start_positions.push(new FlxPoint(800, 750));
        _monster_start_positions.push(new FlxPoint(900, 850));
        _monster_start_positions.push(new FlxPoint(100, 950));
        _monster_start_positions.push(new FlxPoint(1100, 1050));
        _monster_start_positions.push(new FlxPoint(70, 100));
        _monster_start_positions.push(new FlxPoint(200, 200));
        _monster_start_positions.push(new FlxPoint(300, 300));
        _monster_start_positions.push(new FlxPoint(400, 400));
        _monster_start_positions.push(new FlxPoint(500, 500));
        _monster_start_positions.push(new FlxPoint(600, 600));
        _monster_start_positions.push(new FlxPoint(700, 700));
        _monster_start_positions.push(new FlxPoint(800, 800));
        _monster_start_positions.push(new FlxPoint(900, 900));
        _monster_start_positions.push(new FlxPoint(100, 1000));
        _monster_start_positions.push(new FlxPoint(1100, 1100));


        _cache_start_positions = new Array();
        _cache_start_positions.push(new FlxPoint(16, 192));

        _next_level = new MovementState();
        _level_time = 60000;

        super.create();
    }
}