package;

import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxTilemapGraphicAsset;

class Level
{
    var _background : FlxTilemap;
    var _walls : FlxTilemap;
    var _climb : FlxTilemap;

    public function new(file:String, tilemap:FlxTilemapGraphicAsset)
    {
        var tiled_map:TiledMap = new TiledMap(file);
        FlxG.worldBounds.set(0, 0, tiled_map.fullWidth, tiled_map.fullHeight);

        _background = new FlxTilemap();
        var bg_layer:TiledTileLayer = cast(tiled_map.getLayer("Background"), TiledTileLayer);
        _background.loadMapFromArray(bg_layer.tileArray, bg_layer.width, bg_layer.height, tilemap, tiled_map.tileWidth, tiled_map.tileHeight, OFF, 1, 1, 1);

        _walls = new FlxTilemap();
        var wall_layer:TiledTileLayer = cast(tiled_map.getLayer("Walls"), TiledTileLayer);
        _walls.loadMapFromArray(wall_layer.tileArray, wall_layer.width, wall_layer.height, tilemap, tiled_map.tileWidth, tiled_map.tileHeight, OFF, 1, 1, 3);
        _walls.setTileProperties(2, FlxObject.ANY, null, null);

        _climb = new FlxTilemap();
        var climb_layer:TiledTileLayer = cast(tiled_map.getLayer("Climbable"), TiledTileLayer);
        _climb.loadMapFromArray(climb_layer.tileArray, climb_layer.width, climb_layer.height, tilemap, tiled_map.tileWidth, tiled_map.tileHeight, OFF, 1, 1, 1);    
    }

    public function get_background():FlxTilemap { return _background; }
    public function get_walls():FlxTilemap { return _walls; }
    public function get_climb():FlxTilemap { return _climb; }

}