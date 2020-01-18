package state;

import flixel.group.FlxGroup;
import entities.player.Player;
import flixel.FlxState;

class PlayState extends FlxState {
	
	private var player:Player;

	private var entities:FlxGroup;

	override public function create():Void {
		entities = loadEntities();

		add(entities);
	}

	/**
		Loads all entities used in the state.
		
		@return FlxGroup containing all entities, unsorted.
	**/
	public function loadEntities():FlxGroup {
		var loaded:FlxGroup = new FlxGroup();

		player = new Player();
		loaded.add(player);
		
		return loaded;
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
