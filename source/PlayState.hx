package;

import flixel.math.FlxPoint;
import flixel.group.FlxGroup.FlxTypedGroup;
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
	var enemies:FlxTypedGroup<Enemy>;

	override public function create()
	{
		// setup map
		if(bgsel == 0) {
			if (FlxG.sound.music == null) // don't restart the music if it's already playing
				{
					FlxG.sound.playMusic(AssetPaths.at_the_harbor_of_spring__ogg, 1, true);
				}
			map = new FlxOgmo3Loader(AssetPaths.touhou_tiles__ogmo, AssetPaths.testlv1__json);
			walls = map.loadTilemap(AssetPaths.overworld_tileset__png, "walls");
			walls2 = map.loadTilemap(AssetPaths.overworld_tileset__png, "walls2");
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
			map = new FlxOgmo3Loader(AssetPaths.backrooms_tiles__ogmo, AssetPaths.bkrms1__json);
			walls = map.loadTilemap(AssetPaths.backrooms_tiles__png, "walls");
			walls2 = map.loadTilemap(AssetPaths.backrooms_tiles__png, "walls2");
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
		
		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);

		// setup player
		player = new Player(20, 20);
		add(player);
		map.loadEntities(placeEntities, "entities");
		FlxG.camera.follow(player, TOPDOWN, 1);
		super.create();
	}

	function placeEntities(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;

		switch (entity.name)
		{
			case "player":
				player.setPosition(x, y);

			case "fairy":
				enemies.add(new Enemy(x + 4, y, REGULAR));

			case "boss":
				enemies.add(new Enemy(x + 4, y, BOSS));
		}
	}

	override public function update(elapsed:Float)
	{
		FlxG.collide(player, walls2);
		FlxG.collide(enemies, walls);
		enemies.forEachAlive(checkEnemyVision);
		super.update(elapsed);
	}

	function checkEnemyVision(enemy:Enemy)
	{
		if (walls.ray(enemy.getMidpoint(), player.getMidpoint()))
		{
			enemy.seesPlayer = true;
			enemy.playerPosition = player.getMidpoint();
		}
		else
		{
			enemy.seesPlayer = false;
		}
	}
}
