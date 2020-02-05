package state;

import entities.terrain.Ground;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import entities.player.Player;
import flixel.FlxState;

class PlayState extends FlxState {

    private var PLATFORM_START_X_1(default, never):Int = 0;
    private var PLATFORM_START_Y_1(default, never):Int = 448;
    private var PLATFORM_LENGTH_1(default, never):Int = 3;

    private var PLATFORM_START_X_2(default, never):Int = 320;
    private var PLATFORM_START_Y_2(default, never):Int = 384;
    private var PLATFORM_LENGTH_2(default, never):Int = 4;

    private var PLATFORM_START_X_3(default, never):Int = 500;
    private var PLATFORM_START_Y_3(default, never):Int = 448;
    private var PLATFORM_LENGTH_3(default, never):Int = 3;

    private var PLATFORM_START_X_4(default, never):Int = 440;
    private var PLATFORM_START_Y_4(default, never):Int = 280;
    private var PLATFORM_LENGTH_4(default, never):Int = 4;

    private var PLATFORM_START_X_5(default, never):Int = 0;
    private var PLATFORM_START_Y_5(default, never):Int = 180;
    private var PLATFORM_LENGTH_5(default, never):Int = 10;

    private var player:Player;

    private var groundTiles:FlxGroup;

    ////////////////////
    // INITIALIZATION //
    ////////////////////
    override public function create():Void {
        player = loadPlayer();
        add(player);

        groundTiles = new FlxGroup();
        groundTiles.add(loadPlatform(PLATFORM_START_X_1, PLATFORM_START_Y_1, PLATFORM_LENGTH_1));
        groundTiles.add(loadPlatform(PLATFORM_START_X_2, PLATFORM_START_Y_2, PLATFORM_LENGTH_2));
        groundTiles.add(loadPlatform(PLATFORM_START_X_3, PLATFORM_START_Y_3, PLATFORM_LENGTH_3));
        groundTiles.add(loadPlatform(PLATFORM_START_X_4, PLATFORM_START_Y_4, PLATFORM_LENGTH_4));
        groundTiles.add(loadPlatform(PLATFORM_START_X_5, PLATFORM_START_Y_5, PLATFORM_LENGTH_5));

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
        Creates a platform for use in the state.

        @return FlxGroup containing all Ground objects, unsorted.
    **/
    public function loadPlatform(startX:Float, startY:Float, length:Int):FlxGroup {
        var platform:FlxGroup = new FlxGroup();

        for (i in 0...length) {
            var groundX:Float = startX + i * Ground.WIDTH;
            var ground:Ground = new Ground(groundX, startY);

            platform.add(ground);
        }
        return platform;
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
