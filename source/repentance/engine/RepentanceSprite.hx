package repentance.engine;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxTimer;
import repentance.util.Constants;

class RepentanceSprite extends FlxSprite{
    public var dyn:Dynamic = {};
    public var timer:FlxTimer;

    public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y);
		if (SimpleGraphic != null)
			loadGraphic(SimpleGraphic);


        antialiasing = false;
        timer = new FlxTimer();
	}

    public function adjustSize(?forceScale:Float=null, ?absoluteSizeX:Float=null, ?absoluteSizeY:Float=null) {
        var rescale = Constants.GAME_SCALE_FACTOR;
        if (forceScale != null)rescale=forceScale;

        if (absoluteSizeX != null){
            setGraphicSize(absoluteSizeX,0);
        }else if (absoluteSizeY != null){
            setGraphicSize(0, absoluteSizeY);
        }else if (absoluteSizeX != null && absoluteSizeY != null){
            setGraphicSize(absoluteSizeX, absoluteSizeY);
        }else{
            setGraphicSize(Std.int(width*rescale));
        }
        updateHitbox();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (dyn.update != null){
            dyn.update(elapsed);
        }
    }
}