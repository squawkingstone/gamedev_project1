package;

import flixel.FlxState;
import flixel.FlxGame;
import flixel.FlxG;
import flixel.ui.FlxButton;

class LearnState extends FlxState
{
    var backButton : FlxButton;

    override public function create():Void
    {
        super.create();
        var text = new flixel.text.FlxText(0, 0, 400, "Controls\nW/up: Climb Up\nS/down: Climb Down\nA/Right: Move Right\nD/Left: Move Left\nSpace = Jump\nF = Attack\nThe main goal of each level is to dissect the caches, which give a large amount of research points. Killing viruses also rewards research points. Each cache is worth 250, each virus is worth 25. A minimum score of 1000 is required to save humanity.", 12);
        text.screenCenter();
        add(text);
        backButton = new FlxButton(280, 340, "BACK", clickBack);
        add(backButton);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
    function clickBack():Void
    {
        FlxG.switchState(new MenuState());
    }
}