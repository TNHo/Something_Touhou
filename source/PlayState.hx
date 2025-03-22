package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	var player:Player;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var walls2:FlxTilemap;
	var bgsel : Int = 0;

	override public function create()
	{
		// setup map
		if(bgsel == 0) {
			if (FlxG.sound.music == null) // don't restart the music if it's already playing
				{
					FlxG.sound.playMusic(AssetPaths.at_the_harbor_of_spring__ogg, 1, true);
				}
			map = new FlxOgmo3Loader("assets/data/touhou_tiles.ogmo", "assets/data/testlv1.json");
			walls = map.loadTilemap("assets/data/overworld_tileset.png", "walls");
			walls2 = map.loadTilemap("assets/data/overworld_tileset.png", "walls2");
			walls.follow();
			walls.setTileProperties(0, NONE);
			walls.setTileProperties(1, NONE);
			walls.setTileProperties(2, ANY);
			add(walls);
			walls2.follow();
			walls2.setTileProperties(1, ANY);
			walls2.setTileProperties(2, ANY);
			add(walls2);
		} else {
			if (FlxG.sound.music == null) // don't restart the music if it's already playing
				{
					FlxG.sound.playMusic(AssetPaths.backrooms_sfx__ogg, 1, true);
				}
			map = new FlxOgmo3Loader("assets/data/backrooms_tiles.ogmo", "assets/data/bkrms1.json");
			walls = map.loadTilemap("assets/data/backrooms_tiles.png", "walls");
			walls2 = map.loadTilemap("assets/data/backrooms_tiles.png", "walls2");
			walls.follow();
			walls.setTileProperties(1, NONE);
			walls.setTileProperties(2, ANY);
			walls.setTileProperties(3, ANY);
			walls.setTileProperties(4, ANY);
			walls.setTileProperties(5, NONE);
			add(walls);
			walls2.follow();
			walls2.setTileProperties(1, ANY);
			walls2.setTileProperties(2, ANY);
			walls2.setTileProperties(3, ANY);
			add(walls2);
		}
		
		// setup player
		player = new Player(20, 20);
		add(player);
		map.loadEntities(placeEntities, "entities");
		FlxG.camera.follow(player, TOPDOWN, 1);
		super.create();
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			player.setPosition(entity.x, entity.y);
		}
	}

	override public function update(elapsed:Float)
	{
		FlxG.collide(player, walls2);
		super.update(elapsed);
	}
}
