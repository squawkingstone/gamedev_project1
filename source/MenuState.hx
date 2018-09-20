package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.FlxG;

class MenuState extends FlxState
{
    var startButton : FlxButton;
    var background : FlxSprite;

    override public function create():Void
    {
        background = new FlxSprite();
        background.loadGraphic(AssetPaths.MenuImage__png);
        add(background);
        startButton = new FlxButton(20, 20, "START", clickPlay);
        startButton.screenCenter();
        add(startButton);
        super.create();

    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    function clickPlay():Void
    {
        FlxG.switchState(new IntroState());
    }
}