package;

import flixel.FlxState;
import flixel.FlxGame;
import haxe.Timer;
import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.ui.FlxButton;

class GameOverState extends FlxState
{
    var scoreboard:FlxSave;
    var newgameButton : FlxButton;

    override public function create():Void
    {
        
        super.create();
		var text;
        text = new flixel.text.FlxText(0, 0, 400, "Pilot! Your bot has been fatally damaged and cannot continue!\nWithout its vital research, humanity is doomed!", 16);
        text.screenCenter();
        add(text);
        newgameButton = new FlxButton(280, 280, "Play Again?", clickNewGame);
        add(newgameButton);

    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
    function clickNewGame():Void
    {
        FlxG.switchState(new MenuState());
    }
}