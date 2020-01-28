package entities.terrain;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class Ground extends FlxSprite {

    public static var WIDTH(default, never):Int = 32;
    public static var HEIGHT(default, never):Int = 32;

    public function new(X:Float = 0, Y:Float = 0) {
        super(X, Y);
        makeGraphic(WIDTH, HEIGHT, FlxColor.GRAY);
        immovable = true;
    }
}