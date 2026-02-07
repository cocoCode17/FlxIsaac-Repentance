package repentance.play;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import repentance.play.entities.Player;
import repentance.play.properties.GameHUD;
import repentance.util.Constants;

enum RoomType{
    DEFAULT;
    CRACKED;
    ROPES;
    BLOOD;
}
typedef PlayerPositions = {
    var x:Float;
    var y:Float;
}
class Room extends FlxState {
    public static var instance:Room = null;
    public var currentLevel:String = "?";
    public var room_id:String = Constants.DEFAULT_ROOM_ID;
    public var roomType:RoomType = DEFAULT;

    public var stats:Stats;

    public var hud:GameHUD;

    public var backGround:FlxSprite;

    public var hitboxes:FlxTypedGroup<FlxSprite>;

    public var player:Player;
    public var playerPositions:PlayerPositions = {
        x: 0.,
        y: 0.
    };

    public var roomIntro:Void->Void = null;
    public var hasIntro:Bool = false;
    public var inIntro:Bool = false;
    public var introCamera:FlxCamera;

    public function new(id:String = null, roomType:RoomType, playerPositions:PlayerPositions, hasIntro:Bool=false, ?roomIntro:Void->Void) {
        super();
        id ??= Constants.DEFAULT_ROOM_ID;
        room_id = id;
        this.roomType = roomType;
        this.playerPositions = playerPositions;
        this.hasIntro = hasIntro;
        this.roomIntro = roomIntro;
    }

    override function create() {
        super.create();

        instance = this;

        introCamera = new FlxCamera();
        introCamera.bgColor.alpha = 0;
        FlxG.cameras.add(introCamera, true);

        stats = new Stats();
        trace(stats.getStats());
 
        player = new Player(playerPositions.x, playerPositions.y);
        add(player);

        hitboxes = new FlxTypedGroup<FlxSprite>();
        add(hitboxes);

        hud = new GameHUD(backGround?.x,backGround?.y,this);
        add(hud);

        if (hasIntro){
            if (roomIntro != null)
                roomIntro();
            inIntro = true;
        }
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        hitboxes.forEachAlive(hitbox->{
           FlxG.collide(player.body, hitbox);
        });

            player.canUpdate = !inIntro;
    }
}