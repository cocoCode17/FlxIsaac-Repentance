package;

import flixel.FlxSprite;
import flixel.FlxState;
import repentance.util.Constants;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();

		var t = new FlxSprite().loadGraphic(AssetPaths.isaacExtraAnims__png, true, 48, 48);
		t.animation.add("like", [5], 12, true);
		t.animation.play("like");
		t.screenCenter();
		t.scale.set(Constants.GAME_SCALE_FACTOR,Constants.GAME_SCALE_FACTOR);
		t.updateHitbox();
		t.antialiasing = false;
		add(t);  
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
