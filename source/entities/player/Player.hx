package entities.player;

import flixel.FlxG;
import flixel.FlxSprite;

/**
    Main player-controlled entity. 
    Reacts to player inputs and handles a lot of fundamental interactions in the game.
**/
class Player extends FlxSprite 
{
    private static var WIDTH(default, never):Int = 32;
    private static var HEIGHT(default, never):Int = 64;

    private static var MOVE_SPEED(default, never):Float = 250;
    private static var JUMP_SPEED(default, never):Float = -300;
    private static var GRAVITY(default, never):Float = 250;
    private static var MAX_SPEED_X(default, never):Float = 200;
    private static var MAX_SPEED_Y(default, never):Float = 480;

    ////////////////////
    // INITIALIZATION //
    ////////////////////
    public function new() {
        super();
        makeGraphic(WIDTH, HEIGHT);
        configureSpeed();
    }

    /**
        Sets up player variables related to movement and speed.
    **/
    private function configureSpeed() {
        acceleration.set(0, GRAVITY);
        maxVelocity.set(MAX_SPEED_X, MAX_SPEED_Y);
    }

    ////////////
    // Update //
    ////////////
    override public function update(elapsed:Float) {
        setMoveSpeed();
        jump();
        // super.update() updates position, etc. so we typcially want to do it last.
        super.update(elapsed);
    }

    /**
        Simple WASD/Arrow-key movement. 
        Don't forget that negative values move up/left, while positive values move down/right.
    **/
    private function setMoveSpeed() {
        var horizontalMovement:Int = 0;
        if (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT) {
            horizontalMovement--;
        }

        if (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) {
            horizontalMovement++;
        }

        velocity.x = horizontalMovement * MOVE_SPEED;
    }

    /**
        Checks if player should jump, then jumps if needed.
    **/
    private function jump() {
        if (FlxG.keys.justPressed.SPACE) {
            velocity.y = JUMP_SPEED;
        }
    }
}