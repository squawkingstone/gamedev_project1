package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(160, 120, MenuState, 1.0, 60, 60, true, false));
	}
}
