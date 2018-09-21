package;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxTilemapGraphicAsset;
import flixel.FlxCamera.FlxCameraFollowStyle;
import haxe.Timer;
import flixel.util.FlxSave;

class Level extends FlxState
{
    /* Map loading stuff */
    var _file : String;
    var _tilemap : FlxTilemapGraphicAsset;

    /* tilemap data */
    var _background : FlxTilemap;
    var _walls : FlxTilemap;
    var _climb : FlxTilemap;

    /* entity data */
    var _player_start_position : FlxPoint;
    var _monster_start_positions : Array<FlxPoint>;
    var _cache_start_positions : Array<FlxPoint>;

    /* entities */
    var _player : Player;
    var _attack_object : FlxObject;
    var _monsters : FlxGroup;
    var _caches : FlxGroup;

    /* level time */
    var _level_time : Int;

    var _next_level : FlxState;

    var scoreboard:FlxSave;
    var score = 0;

    override public function create():Void
    {
        FlxG.debugger.drawDebug = true;
        scoreboard = new FlxSave();
        scoreboard.bind("Save");
        //this part should go just before the level changes
        scoreboard.data.score = score;
        scoreboard.flush();
        var tiled_map:TiledMap = new TiledMap(_file);
        FlxG.worldBounds.set(0, 0, tiled_map.fullWidth, tiled_map.fullHeight);

        _background = new FlxTilemap();
        var bg_layer:TiledTileLayer = cast(tiled_map.getLayer("Background"), TiledTileLayer);
        _background.loadMapFromArray(bg_layer.tileArray, bg_layer.width, bg_layer.height, _tilemap, tiled_map.tileWidth, tiled_map.tileHeight, OFF, 1, 1, 1);
        add(_background);

        _walls = new FlxTilemap();
        var wall_layer:TiledTileLayer = cast(tiled_map.getLayer("Walls"), TiledTileLayer);
        _walls.loadMapFromArray(wall_layer.tileArray, wall_layer.width, wall_layer.height, _tilemap, tiled_map.tileWidth, tiled_map.tileHeight, OFF, 1, 1, 3);
        var wall_tiles = wall_layer.tileArray.copy().filter(function(i:Int){return i != 0;});
        wall_tiles.sort(function(i1:Int, i2:Int){ return i1-i2; });
        for(i in wall_tiles)
        {
           _walls.setTileProperties(i, FlxObject.ANY, null, null);
        }
        add(_walls);

        _climb = new FlxTilemap();
        var climb_layer:TiledTileLayer = cast(tiled_map.getLayer("Climbable"), TiledTileLayer);
        _climb.loadMapFromArray(climb_layer.tileArray, climb_layer.width, climb_layer.height, _tilemap, tiled_map.tileWidth, tiled_map.tileHeight, OFF, 1, 1, 1);    
        add(_climb);

        _player = new Player(_player_start_position.x, _player_start_position.y);
        add(_player);

        _attack_object = new FlxObject(_player.x, _player.y, _player.width, _player.height);
        _attack_object.allowCollisions = FlxObject.NONE;
        add(_attack_object);

        _monsters = new FlxGroup(32);
        for (pos in _monster_start_positions)
        {
            var m = new Monster(pos.x, pos.y);
            add(m);
            _monsters.add(m);
        }

        _caches = new FlxGroup(32);
        for (pos in _cache_start_positions)
        {
            var c = new Cache(pos.x, pos.y);
            add(c);
            _caches.add(c);
        }

        FlxG.camera.follow(_player, FlxCameraFollowStyle.PLATFORMER, 0.5);

        Timer.delay(function () 
        {
            FlxG.switchState(_next_level);
        }, _level_time);

        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        FlxG.collide(_walls, _player, null);
        FlxG.collide(_walls, _monsters, null);
        FlxG.collide(_caches, _player, null);
        _player.process_movement(_climb.overlaps(_player, false, null));
        var diff = (_player.facing == FlxObject.LEFT) ? -_player.width : _player.width;
        _attack_object.setPosition(_player.x + diff, _player.y);

        for (m in _monsters)
        {
            if (_attack_object.overlaps(m, false, null))
            {
                _player.process_attack(cast(m, FlxSprite));
            }
        }

        for (c in _caches)
        {
            if (_attack_object.overlaps(c, false, null))
            {
                _player.process_attack(cast(c, FlxSprite));
            }
        }
    }

}