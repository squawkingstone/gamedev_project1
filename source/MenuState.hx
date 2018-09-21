package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.util.FlxSave;
import haxe.Serializer;
import haxe.Unserializer;

class MenuState extends FlxState
{
    var startButton : FlxButton;
    var background : FlxSprite;
    var instructionsButton : FlxButton;

    override public function create():Void
    {
        background = new FlxSprite();
        background.loadGraphic(AssetPaths.MenuImage__png);
        add(background);
        startButton = new FlxButton(20, 20, "START", clickPlay);
        startButton.screenCenter();
        add(startButton);
        instructionsButton = new FlxButton(280, 260, "INSTRUCTIONS", clickLearn);
        add(instructionsButton);
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
    function clickLearn():Void
    {
        FlxG.switchState(new LearnState());
    }
}