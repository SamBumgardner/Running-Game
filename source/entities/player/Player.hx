package entities.player;

import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite 
{
    private static var WIDTH(default, never):Int = 32;
    private static var HEIGHT(default, never):Int = 64;

    private static var MOVE_SPEED(default, never):Int = 100;

    public function new() {
        super();
        makeGraphic(WIDTH, HEIGHT);
    }

    override public function update(elapsed:Float) {
        setMoveSpeed();
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

        var verticalMovement:Int = 0;
        if (FlxG.keys.pressed.W || FlxG.keys.pressed.UP) {
            verticalMovement--;
        }

        if (FlxG.keys.pressed.S || FlxG.keys.pressed.DOWN) {
            verticalMovement++;
        }

        velocity.set(MOVE_SPEED * horizontalMovement, MOVE_SPEED * verticalMovement);
    }
}