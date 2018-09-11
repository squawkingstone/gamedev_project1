package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.FlxCamera.FlxCameraFollowStyle;

class MovementState extends FlxState
{

    var _player : Player;
    var _level : FlxTilemap;

    override public function create():Void
    {
        FlxG.camera.bgColor = 0xFFFFA0A0;
        FlxG.debugger.drawDebug = true;

        var level_array:Array<Int> = [
            1,1,1,1,1,1,1,1,1,1,
            1,0,0,0,0,0,0,2,2,1,
            1,0,0,0,0,0,0,2,2,1,
            1,0,0,1,1,1,1,2,2,1,
            1,0,0,0,0,0,0,2,2,1,    
            1,0,0,0,0,0,0,2,2,1,
            1,0,0,0,0,0,0,2,2,1,
            1,1,1,0,0,0,0,2,2,1,
            1,1,1,1,1,1,1,1,1,1,
        ];

        _level = new FlxTilemap();
        _level.loadMapFromArray(level_array, 10, 9, AssetPaths.tiles__png, 16, 16, FlxTilemapAutoTiling.OFF, 0, 1, FlxObject.NONE);
        _level.setTileProperties(0, FlxObject.NONE, null, null, 1);
        _level.setTileProperties(1, FlxObject.ANY, null, null, 1);
        _level.setTileProperties(2, FlxObject.NONE, null, null, 1);
        add(_level);

        _player = new Player(24,24);
        add(_player);

        FlxG.camera.follow(_player, FlxCameraFollowStyle.PLATFORMER, 0.5);

        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        FlxG.collide(_player, _level, null);
        // check if the player has overlapped with any 2 tile and then pass that
        // bool to the process movement function  
        _player.process_movement();
        super.update(elapsed);
    }

}