package state;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import entities.player.Player;
import flixel.FlxState;

class PlayState extends FlxState {
	
	private var player:Player;

	private var entities:FlxGroup;

    ////////////////////
    // INITIALIZATION //
    ////////////////////
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

    ////////////
    // Update //
    ////////////
	override public function update(elapsed:Float):Void {
		screenWrap(player);
		super.update(elapsed);
	}

    /**
        Handles screen wrap if the specified entity ever goes off-screen.
        
        @param entity The FlxSprite-inheriting object to screen wrap.
    **/
    private function screenWrap(entity:FlxSprite) {
        // Handle horizontal screen wrap.
        if (entity.x > FlxG.width) {
            entity.x = -1 * entity.width;
        }
        if (entity.x + entity.height < 0) {
            entity.x = FlxG.width;
        }
        // Handle vertical screen wrap.
        if (entity.y > FlxG.height) {
            entity.y = -1 * entity.height;
        }
        if (entity.y + entity.height < 0) {
            entity.y = FlxG.height;
        }
    }
}
