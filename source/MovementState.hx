package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.addons.editors.tiled.TiledMap;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.FlxObject;
import flixel.math.FlxRect;
import flixel.FlxSprite;

class MovementState extends FlxState
{

    var _player : Player;
    var _attack_object : FlxObject;
    var _cache : Cache;
    var _level : Level;

    var _zoom_level = 2;

    override public function create():Void
    {
        FlxG.debugger.drawDebug = true;

        // LOAD THE MAP

        _level = new Level("assets/maps/temp.tmx", AssetPaths.tiles__png);

        var tiled_map:TiledMap = new TiledMap("assets/maps/temp.tmx");
        FlxG.worldBounds.set(0, 0, tiled_map.fullWidth, tiled_map.fullHeight);

        add(_level.get_background());
        add(_level.get_walls());
        add(_level.get_climb());   

        _player = new Player(24,24);
        add(_player);

        _attack_object = new FlxObject(_player.x, _player.y, _player.width, _player.height);
        _attack_object.allowCollisions = FlxObject.NONE;
        add(_attack_object);

        _cache = new Cache(16, 192);
        add(_cache);

        FlxG.camera.follow(_player, FlxCameraFollowStyle.PLATFORMER, 0.5);

        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        FlxG.collide(_level.get_walls(), _player, null);
        FlxG.collide(_cache, _player, null);
        _player.process_movement(_level.get_climb().overlaps(_player, false, null));
        var diff = (_player._facing == FlxObject.LEFT) ? -_player.width : _player.width;
        _attack_object.setPosition(_player.x + diff, _player.y);
        
        //make a group of all the enemies and caches and use the attack as callback
        if (_attack_object.overlaps(_cache, false, null))
        {
            _player.process_attack(_cache);
        }
    }

}