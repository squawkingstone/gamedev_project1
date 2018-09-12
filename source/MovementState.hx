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

class MovementState extends FlxState
{

    var _player : Player;
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

        // DO THE PLAYER THING        

        _player = new Player(24,24);
        add(_player);

        FlxG.camera.follow(_player, FlxCameraFollowStyle.PLATFORMER, 0.5);

        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        FlxG.collide(_walls, _player, null);
        _player.process_movement(false);
        super.update(elapsed);
    }

}