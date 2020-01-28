package entities.player;

import flixel.FlxObject;
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

    private static var JUMP_SPEED(default, never):Float = -400;
    private static var FAST_FALL_SPEED(default, never):Float = 0;
    private static var GRAVITY(default, never):Float = 600;
    private static var MAX_SPEED_Y(default, never):Float = 450;

    private static var MAX_SPEED_X(default, never):Float = 200;
    private static var MIN_SPEED_X(default, never):Float = 50;
    private static var DEFAULT_SPEED_X(default, never):Float = 100;

    ////////////////////
    // INITIALIZATION //
    ////////////////////
    public function new(startingDirection:Int = FlxObject.RIGHT) {
        super();
        makeGraphic(WIDTH, HEIGHT);
        configureSpeed();

        facing = startingDirection;
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
        setMoveSpeed(getInputDirection());
        jump();
        // super.update() updates position, etc. so we typcially want to do it last.
        super.update(elapsed);
    }

    /**
        Given a direction of input, determines and sets player speed.
        @param inputDirection Integer representing direction of input currently held. Should have
            value of FlxObject.LEFT, FlxObject.RIGHT, or FlxObject.NONE
    **/
    private function setMoveSpeed(inputDirection:Int) {
        // Determine what speed player is moving at: max, default, or min
        var speed:Float = 0;
        if (inputDirection == facing) {
            speed = MAX_SPEED_X;
        } else if (inputDirection == FlxObject.NONE) {
            speed = DEFAULT_SPEED_X;
        } else { // Assumes that only other possible input direction is opposite of facing.
            speed = MIN_SPEED_X;
        }

        // Determine what direction the player is moving in. Left is negative, right is positive.
        var direction:Int = 0;
        if (facing == FlxObject.LEFT) {
            direction = -1;
        } else { // Assumes player can only face left or right.
            direction = 1;
        }

        velocity.x = speed * direction;
    }

    /**
        Determines the direction of input, returns int representing the appropriate direction.
        @see <http://api.haxeflixel.com/flixel/FlxObject.html> for info about directional values.
    **/
    private function getInputDirection():Int {
        var horizontalMovement:Int = 0;
        if (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT) {
            horizontalMovement--;
        } 
        
        if (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) {
            horizontalMovement++;
        } 
        
        switch (horizontalMovement) {
            case -1: return FlxObject.LEFT;
            case 1: return FlxObject.RIGHT;
            default: return FlxObject.NONE;
        }
    }

    /**
        Handles logic around jumping, including initiation and stopping one early.
    **/
    private function jump() {
        if (touching == FlxObject.DOWN && FlxG.keys.justPressed.SPACE) {
            velocity.y = JUMP_SPEED;
        }
        if (FlxG.keys.justReleased.SPACE && velocity.y < FAST_FALL_SPEED) {
            velocity.y = FAST_FALL_SPEED;
        }
    }
}