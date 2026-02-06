package;

import flixel.FlxGame;
import flixel.FlxState;
import openfl.display.Sprite;
import repentance.play.Room;
import repentance.play.rooms.PlumStage;

typedef GameConfigs = {
	var width:Int;
	var height:Int;
	var initialState:Class<FlxState>;
	var FPS:Int;
	var skipSplash:Bool;
	var startFullscreen:Bool;
}

class Main extends Sprite
{
	var gameConfig:GameConfigs;

	function gameSetup(){
        gameConfig = {
			width: 0,
			height: 0,
			initialState: PlumStage,
			FPS: 60,
			skipSplash: true,
			startFullscreen: false
		}
	}

	public function new()
	{
		super();
		gameSetup();
		var daGame = new FlxGame(
			gameConfig.width,
			gameConfig.height, 
			gameConfig.initialState,
			gameConfig.FPS, 
			gameConfig.FPS, 
			gameConfig.skipSplash, 
			gameConfig.startFullscreen
		);
		addChild(daGame);
	}
}
