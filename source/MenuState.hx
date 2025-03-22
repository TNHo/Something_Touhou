package;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	var titleText:FlxText;
	var playButton:FlxButton;
	var optionsButton:FlxButton;
	#if desktop
	var exitButton:FlxButton;
	#end

	override public function create()
	{
		// placeholder title, will change later
		titleText = new FlxText(20, 0, 0, "Untitled\nTouhou\nFan-Game", 22); 
		titleText.alignment = CENTER;
		titleText.screenCenter(X);
		add(titleText);

		playButton = new FlxButton(0, 0, "Play", clickPlay);
		playButton.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		playButton.x = (FlxG.width / 2) - 10 - playButton.width;
		playButton.y = FlxG.height - playButton.height - 10;
		add(playButton);

		optionsButton = new FlxButton(0, 0, "Options", clickOptions);
		optionsButton.x = (FlxG.width / 2) + 10;
		optionsButton.y = FlxG.height - optionsButton.height - 10;
		add(optionsButton);

		#if desktop
		exitButton = new FlxButton(FlxG.width - 28, 8, "X", clickExit);
		exitButton.loadGraphic(AssetPaths.button__png, true, 20, 20);
		add(exitButton);
		#end

		if (FlxG.sound.music == null) // don't restart the music if it's already playing
			{
				FlxG.sound.playMusic(AssetPaths.lunatic_eyes__ogg, 1, true);
			}
		super.create();
	}

	function clickPlay()
	{
		// Kill the menu music
		FlxG.sound.pause();
		FlxG.sound.music = null;
		// Start the real game
		FlxG.switchState(new PlayState());
	}

	function clickOptions()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			FlxG.switchState(OptionsState.new);
		});
	}
	
	#if desktop
	function clickExit()
	{
		Sys.exit(0);
	}
	#end
}
