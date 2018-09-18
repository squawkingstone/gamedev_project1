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
    var _background : FlxTilemap;
    var _walls : FlxTilemap;
    var _climb : FlxTilemap;

    var _zoom_level = 2;

    override public function create():Void
    {
        FlxG.debugger.drawDebug = true;

        // LOAD THE MAP

        var tiled_map:TiledMap = new TiledMap("assets/maps/temp.tmx");
        FlxG.worldBounds.set(0, 0, tiled_map.fullWidth, tiled_map.fullHeight);

        _background = new FlxTilemap();
        var bg_layer:TiledTileLayer = cast(tiled_map.getLayer("Background"), TiledTileLayer);
        _background.loadMapFromArray(bg_layer.tileArray, bg_layer.width, bg_layer.height, AssetPaths.tiles__png, tiled_map.tileWidth, tiled_map.tileHeight, OFF, 1, 1, 1);        
        add(_background);

        _walls = new FlxTilemap();
        var wall_layer:TiledTileLayer = cast(tiled_map.getLayer("Walls"), TiledTileLayer);
        _walls.loadMapFromArray(wall_layer.tileArray, 32, 16, AssetPaths.tiles__png, tiled_map.tileWidth, tiled_map.tileHeight, OFF, 1, 1, 3);
        _walls.setTileProperties(2, FlxObject.ANY, null, null);
        add(_walls);

        _climb = new FlxTilemap();
        var climb_layer:TiledTileLayer = cast(tiled_map.getLayer("Climbable"), TiledTileLayer);
        _climb.loadMapFromArray(climb_layer.tileArray, climb_layer.width, climb_layer.height, AssetPaths.tiles__png, tiled_map.tileWidth, tiled_map.tileHeight, OFF, 1, 1, 1);
        add(_climb);      

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
        FlxG.collide(_walls, _player, null);
        FlxG.collide(_cache, _player, null);
        _player.process_movement(_climb.overlaps(_player, false, null));
        var diff = (_player._facing == FlxObject.LEFT) ? -_player.width : _player.width;
        _attack_object.setPosition(_player.x + diff, _player.y);
        
        //make a group of all the enemies and caches and use the attack as callback
        if (_attack_object.overlaps(_cache, false, null))
        {
            _player.process_attack(_cache);
        }
    }

}