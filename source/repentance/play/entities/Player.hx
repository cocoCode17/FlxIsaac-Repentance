package repentance.play.entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxTimer;
import repentance.engine.RepentanceSprite;
import repentance.util.Constants;

using StringTools;
typedef PlayerStats = {
    var speed:Int;
    var hearths:Int;
    var hability:Bool;
    var habilityOnPreCreate:Void->Void;
    var habilityOnCreate:Void->Void;
    var habilityOnPreUpdate:Float->Void;
    var habilityOnUpdate:Float->Void;
}

class Player extends FlxTypedSpriteGroup<RepentanceSprite> {
    public var head:RepentanceSprite;
    public var body:RepentanceSprite;

    public var skin:String = Constants.DEFAULT_PLAYER_SKIN;
    public var player_stats:PlayerStats = {
        speed: 210,
        hearths: 3,
        hability: false,
        habilityOnCreate: null,
        habilityOnUpdate: null,
        habilityOnPreCreate: null,
        habilityOnPreUpdate: null
    };

    public var shootTimer:FlxTimer;
    public var shooting:Bool = false;
    public var shoot_interval:Float = 0.5;
    public var currentShootDirection:String = "down";

    public var canUpdate:Bool = true;
    
    public function new(x=0.,y=0.,skin:String="isaac") {
        super();

        var powerup = "default";

        if (player_stats.habilityOnPreCreate != null)
            player_stats.habilityOnPreCreate();

        body = new RepentanceSprite(x,y);
        body.loadGraphic(AssetPaths.img("entities/"+skin+"/"+powerup+"/isaac_body"), true, 18, 15);
        body.animation.add("idle_front", [0], 12, true);
        // body.animation.add("walk_down", [4,0,1,2,3], 12, true);
        body.animation.add("walk_down", [3,2,1,0,4], 12, true);
        body.animation.add("idle_up", [5], 12, true);
        // body.animation.add("walk_up", [9,5,6,7,8], 12, true);
        body.animation.add("walk_up", [8,7,6,5,9], 12, true);
        // body.animation.add("walk_side", for(i in 10...19)[i], 12, true);
        body.animation.add("walk_side", [10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 12, true);
        body.animation.play("idle_front",true);
        body.drag.x = body.drag.y = player_stats.speed*6;
        add(body);

        head = new RepentanceSprite(body.x-5,body.y-20);
        head.loadGraphic(AssetPaths.img("entities/"+skin+"/"+powerup+"/isaac_head"), true, 28, 26);
        head.animation.add("head_down", [0], 12, true);
        head.animation.add("head_tear_down", [1], 12, false);
        head.animation.add("head_right", [2], 12, true);
        head.animation.add("head_tear_right", [3], 12, false);
        head.animation.add("head_up", [4], 12, true);
        head.animation.add("head_tear_up", [5], 12, false);
        head.animation.add("head_left", [6], 12, true);
        head.animation.add("head_tear_left", [7], 12, false);
        head.animation.play("head_down",true);
        head.drag.x = head.drag.y = player_stats.speed*6;
        head.animation.onFinish.add(function(animName) {
            if (animName.startsWith("head_tear")){
                head.animation.play("head_"+currentShootDirection);
            }
        });
        add(head);

        adjust();

        shootTimer = new FlxTimer().start(shoot_interval,tmr->{
            if (!shooting)return;
            head.animation.play("head_tear_"+currentShootDirection);
            trace("shoot");
        },0);
        
        if (player_stats.habilityOnCreate != null)
            player_stats.habilityOnCreate();
    }

    public function adjust() {
        body?.adjustSize();
        head?.adjustSize();
        head.x = body.x - (5*Constants.GAME_SCALE_FACTOR);
        head.y = body.y - (20*Constants.GAME_SCALE_FACTOR); 
    }

    public function attachHeadToBody() {
        head.x = body.x - (5*Constants.GAME_SCALE_FACTOR);
        head.y = body.y - (20*Constants.GAME_SCALE_FACTOR); 
        // head.velocity.x = body.velocity.x;
        // head.velocity.y = body.velocity.y;
    }

    var toIdleAnim:String = "down";
    override function update(elapsed:Float) {
        if (!canUpdate)return;

        if (player_stats.habilityOnPreUpdate != null)    
            player_stats.habilityOnPreUpdate(elapsed);
        
        attachHeadToBody();

        super.update(elapsed);

        if (FlxG.keys.pressed.A){
            body.flipX = true;
            
            body.velocity.x = -player_stats.speed;
        }
        if (FlxG.keys.pressed.D){
            body.flipX = false;
            
            body.velocity.x = player_stats.speed;
        }
        if (FlxG.keys.pressed.W){
            toIdleAnim = "up";
            body.velocity.y = -player_stats.speed;
        }
        if (FlxG.keys.pressed.S){
            body.velocity.y = player_stats.speed;
            toIdleAnim = "down";
        }

        if (FlxG.keys.pressed.LEFT){
            // head.animation.play("head_tear_left");
            shootTimer.active = true;
            shooting = true;
            currentShootDirection = "left";
        }else if (FlxG.keys.justReleased.LEFT){
            // head.animation.play("head_left");
            shootTimer.active = false;
            shooting = false;
        }

        if (FlxG.keys.pressed.RIGHT){
            // head.animation.play("head_tear_right");
            shootTimer.active = true;
            shooting = true;
            currentShootDirection = "right";
        }else if (FlxG.keys.justReleased.RIGHT){
            // head.animation.play("head_right");
            shootTimer.active = false;
            shooting = false;
        }
        
        if (FlxG.keys.pressed.DOWN){
            // head.animation.play("head_tear_down");
            shootTimer.active = true;
            shooting = true;
            currentShootDirection = "down";
        }else if (FlxG.keys.justReleased.DOWN){
            // head.animation.play("head_down");
            shootTimer.active = false;
            shooting = false;
        }
        
        if (FlxG.keys.pressed.UP){
            // head.animation.play("head_tear_up");
            shootTimer.active = true;
            shooting = true;
            currentShootDirection = "up";
        }else if (FlxG.keys.justReleased.UP){
            // head.animation.play("head_up");
            shootTimer.active = false;
            shooting = false;
        }

        if (body.velocity.x != 0){
            if (shooting){
                if (currentShootDirection == "left" && body.velocity.x > 0){
                    body.flipX = true;
                    body.animation.play("walk_side", false, true);    
                }else if (currentShootDirection == "right" && body.velocity.x < 0){
                    body.flipX = false;
                    body.animation.play("walk_side", false, true);    
                }else{
                    body.animation.play("walk_side");    
                }
            }else{
                body.animation.play("walk_side");
            }
            if (body.flipX){
                if (shooting){
                    if (!head?.animation?.curAnim?.name.startsWith("head_tear") && currentShootDirection == "left")
                    head.animation.play("head_left");
                }else{
                    head.animation.play("head_left");
                } 
            }else{
                if (shooting){
                    if (!head?.animation?.curAnim?.name.startsWith("head_tear") && currentShootDirection == "right")
                        head.animation.play("head_right");
                }else{
                        head.animation.play("head_right");
                }
            }
        }else if (body.velocity.y != 0){
            if (body.velocity.y < 0){
                body.animation.play("walk_up");
                if (shooting){
                    if (!head?.animation?.curAnim?.name.startsWith("head_tear") && currentShootDirection == "up")
                    head.animation.play("head_up");
                }else{
                    head.animation.play("head_up");
                }
            }else{
                body.animation.play("walk_down");
                if (shooting){
                    if (!head?.animation?.curAnim?.name.startsWith("head_tear") && currentShootDirection == "down")
                    head.animation.play("head_down");
                }else{
                    head.animation.play("head_down");
                }
            }
        }else{
            if (toIdleAnim == "up"){
            body.animation.play("idle_up");
            // head.animation.play("head_up");
            }
            if (toIdleAnim == "down"){
            body.animation.play("idle_front");
            // head.animation.play("head_down");
            }
        }

        if (player_stats.habilityOnUpdate != null)
            player_stats.habilityOnUpdate(elapsed);
    }

    public function getPlayer() {
        return this;
    }
}