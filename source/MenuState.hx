package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.util.FlxSave;
import haxe.Serializer;
import haxe.Unserializer;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
    var startButton : FlxButton;
    var background : FlxSprite;
    var instructionsButton : FlxButton;
	var jumpsound : FlxSound;

    override public function create():Void
    {
		if (FlxG.sound.music == null) {
			FlxG.sound.playMusic(AssetPaths.Music__wav, 1, true);
		}
        background = new FlxSprite();
        background.loadGraphic(AssetPaths.MenuImage__png);
        add(background);
        startButton = new FlxButton(20, 20, "START", clickPlay);
        startButton.screenCenter();
        add(startButton);
        instructionsButton = new FlxButton(280, 260, "INSTRUCTIONS", clickLearn);
        add(instructionsButton);
        var title = new FlxText(0, 10, 640, "OUTBREAK", 64, false);
        title.setFormat(null, 64, FlxColor.WHITE, FlxTextAlign.CENTER, null, FlxColor.WHITE, false);
        title.scrollFactor.set(0,0);
        add(title);
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