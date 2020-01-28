package state;

import entities.terrain.Ground;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import entities.player.Player;
import flixel.FlxState;

class PlayState extends FlxState {

    private var PLATFORM_START_X(default, never):Int = 0;
    private var PLATFORM_START_Y(default, never):Int = 150;
    private var PLATFORM_LENGTH(default, never):Int = 10;
    
    private var player:Player;

    private var groundTiles:FlxGroup;

    ////////////////////
    // INITIALIZATION //
    ////////////////////
    override public function create():Void {
        player = loadPlayer();
        add(player);
        groundTiles = loadGroundTiles();
        add(groundTiles);
    }

    /**
        Loads player entity used in the state.
        
        @return Player object, initialzed and ready for use.
    **/
    public function loadPlayer():Player {
        player = new Player();
        
        return player;
    }
    
    /**
        Loads Ground used in the state.

        @return FlxGroup containing all Ground objects, unsorted.
    **/
    public function loadGroundTiles():FlxGroup {
        var loaded:FlxGroup = new FlxGroup();

        for (i in 0...PLATFORM_LENGTH) {
            var groundStartX:Int = PLATFORM_START_X + i * Ground.WIDTH;
            var ground:Ground = new Ground(groundStartX, PLATFORM_START_Y);

            loaded.add(ground);
        }
        return loaded;
    }

    ////////////
    // Update //
    ////////////
    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        // super.update() triggers updates for all entities in the FlxState.
        // The next frame is drawn after this function completes, so most state-controlled logic
        // should be taken care of here, after updating objects but before drawing the frame.
        FlxG.collide(player, groundTiles);
        screenWrap(player);
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
        if (entity.x + entity.width < 0) {
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
