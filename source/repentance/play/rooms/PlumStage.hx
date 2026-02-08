package repentance.play.rooms;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import repentance.engine.RepentanceSprite;
import repentance.util.Constants;
import repentance.util.Utils;

class PlumStage extends Room {

    public var isaacPortraitBasePosition:Float = 0;
    public function new() {
        super("basement", BLOOD, {x: 300, y: 400}, true, function(){
            var black = new FlxSprite().makeGraphic(FlxG.width+10,FlxG.height+10,FlxColor.BLACK);
            black.screenCenter();
            black.cameras = [introCamera];
            add(black);

            var isaac = new RepentanceSprite(0,0);
            var bplum = new RepentanceSprite(0,0);
            var isaacTag = new RepentanceSprite(0,0);
            var bplumTag = new RepentanceSprite(0,0);
            var vsTag = new RepentanceSprite(0,0);
            var isaacFloor = new RepentanceSprite(0,0);
            var bplumFloor = new RepentanceSprite(0,0);

            bplum.loadGraphic(AssetPaths.img("portraits/baby plum"));
            bplum.adjustSize();
            bplum.setPosition(FlxG.width-(bplum.width+20),(FlxG.height*0.5)-30);
            bplum.y-=141;
            bplum.x -= 204;
            bplum.cameras = [introCamera];

            var bplumFloorScale = Constants.GAME_SCALE_FACTOR+1.35;
            bplumFloor.loadGraphic(AssetPaths.img("boss_intro/floors/basement"));
            bplumFloor.adjustSize(bplumFloorScale);
            bplumFloor.cameras = [introCamera];
            bplumFloor.x = bplum.x - ((bplumFloor.width-bplum.width)/2);
            bplumFloor.y = bplum.y + (bplum.height-(bplumFloor.height));
            bplumFloor.x += 10;
            bplumFloor.y += 32;
            add(bplumFloor);
            add(bplum);

            bplumFloor.dyn.update = elapsed->{
                bplumFloor.x = bplum.x - ((bplumFloor.width-bplum.width)/2)+10;
                bplumFloor.y = bplum.y + (bplum.height-(bplumFloor.height))+32;
            }

            var isaacScale = 2.5;
            isaac.loadGraphic(AssetPaths.img("portraits/isaac"));
            isaac.adjustSize(isaacScale);
            isaac.setPosition(20,(FlxG.height*0.5)-30);
            isaac.x+=125;
            isaac.y+=160;
            isaacPortraitBasePosition = isaac.x;
            isaac.cameras = [introCamera];
            var random_positions = [-4,4];
            var randomID:Int=0;
            // for isaac cry!
            isaac.dyn.update = elapsed ->{
                isaacPortraitBasePosition = isaac.x;
            }
            var isaacTimer = new FlxTimer().start(0.065, tmr->{
                if (isaac == null)return;
                // isaac.x = isaacPortraitBasePosition+FlxG.random.int(-20,20);
                randomID ^= 1;
                isaac.x = isaacPortraitBasePosition+random_positions[randomID];
            },0);

            isaacFloor.loadGraphic(AssetPaths.img("boss_intro/floors/basement"));
            isaacFloor.adjustSize(2.5);
            isaacFloor.x = isaac.x - ((isaacFloor.width-isaac.width)/2);
            isaacFloor.y = isaac.y + (isaac.height-(isaacFloor.height));
            isaacFloor.x += 10;
            isaacFloor.y += 22;
            isaacFloor.cameras = [introCamera];
            add(isaacFloor);
            add(isaac);
            isaacFloor.dyn.update = elapsed->{
                isaacFloor.x = isaac.x - ((isaacFloor.width-isaac.width)/2)+10;
                isaacFloor.y = isaac.y + (isaac.height-(isaacFloor.height))+22;
            }

            isaacTag.loadGraphic(AssetPaths.img("tags/isaac"));
            isaacTag.adjustSize(Constants.GAME_SCALE_FACTOR-0.4);
            isaacTag.cameras = [introCamera];
            isaacTag.setPosition(100, 70);
            add(isaacTag);

            bplumTag.loadGraphic(AssetPaths.img("tags/baby plum"));
            bplumTag.adjustSize();
            bplumTag.cameras = [introCamera];
            bplumTag.setPosition((FlxG.width-bplumTag.width)-40, 30);
            add(bplumTag);

            vsTag.loadGraphic(AssetPaths.img("tags/vs_tag"));
            vsTag.adjustSize();
            vsTag.cameras = [introCamera];
            vsTag.setPosition(0, 50);
            vsTag.screenCenter(X);
            vsTag.x -= vsTag.width/3;
            add(vsTag);

            
            var isaacTag = new RepentanceSprite(0,0);
            var bplumTag = new RepentanceSprite(0,0);
            var vsTag = new RepentanceSprite(0,0);

            var isaacPortraitFinalPositions = {
                x: isaac.x,
                y: isaac.y
            }
            var babyPlumPortraitFinalPositions = {
                x: bplum.x,
                y: bplum.y
            }
            var isaacFloorFinalPositions = {
                x: isaacFloor.x,
                y: isaacFloor.y
            }
            var babyPlumFloorFinalPositions = {
                x: bplumFloor.x,
                y: bplumFloor.y
            }
            var isaacTagFinalPositions = {
                x: isaacTag.x,
                y: isaacTag.y
            }
            var babyPlumTagFinalPositions = {
                x: bplumTag.x,
                y: bplumTag.y
            }
            var vsTagFinalPositions = {
                x: vsTag.x,
                y: vsTag.y
            }

            //repositioning for start anim

            // ISAAC
            isaac.x = -isaac.width;
            isaac.scale.y =Constants.GAME_SCALE_FACTOR* 0.5;
            FlxTween.tween(isaac, {x: isaacPortraitFinalPositions.x, y: isaacPortraitFinalPositions.y, "scale.y":Constants.GAME_SCALE_FACTOR}, 0.35, {ease: FlxEase.linear});
            
            FlxTween.tween(isaac, {x: isaacPortraitFinalPositions.x, y: isaacPortraitFinalPositions.y, "scale.y":Constants.GAME_SCALE_FACTOR}, 0.35, {ease: FlxEase.linear, 
                onComplete: twn->{
                    var bunceTwn = FlxTween.tween(isaac, {"scale.y":isaacScale+0.25}, 0.2, {ease: FlxEase.linear, type: PINGPONG});
                    new FlxTimer().start(0.5, tmr->{
                        bunceTwn.cancel();
                        FlxTween.tween(isaac, {"scale.y":isaacScale}, 0.1, {ease: FlxEase.linear});
                        FlxTween.tween(isaac, {x: isaacPortraitFinalPositions.x+40}, 2.2, {ease: FlxEase.linear});
                        FlxTween.tween(isaac, {"scale.y":isaacScale+0.5,"scale.x":isaacScale-0.7}, 0.1, {ease: FlxEase.linear, startDelay: 2});
                        FlxTween.tween(isaac, {"scale.y":isaacScale-0.9,"scale.x":isaacScale+0.5}, 0.15, {ease: FlxEase.linear, startDelay: 2.1});
                        FlxTween.tween(bplumFloor, {"scale.y":bplumFloorScale+0.5,"scale.x":isaacScale-0.7}, 0.1, {ease: FlxEase.linear, startDelay: 2});
                        FlxTween.tween(bplumFloor, {"scale.y":bplumFloorScale-0.9,"scale.x":bplumFloorScale+0.5}, 0.15, {ease: FlxEase.linear, startDelay: 2.1});
                        FlxTween.tween(isaac, {alpha: 0,x:-20}, 0.2, {ease: FlxEase.linear, startDelay: 2.2});
                        FlxTween.tween(bplumFloor, {alpha: 0}, 0.2, {ease: FlxEase.linear, startDelay: 2.2});
                    });
                }
            });
            // BABY PLUMM!
            bplum.x = FlxG.width+bplum.width;
            bplum.scale.y = Constants.GAME_SCALE_FACTOR* 0.5;
            FlxTween.tween(bplum, {x: babyPlumPortraitFinalPositions.x, y: babyPlumPortraitFinalPositions.y, "scale.y":Constants.GAME_SCALE_FACTOR}, 0.35, {ease: FlxEase.linear, 
                onComplete: twn->{
                    var bunceTwn = FlxTween.tween(bplum, {"scale.y":Constants.GAME_SCALE_FACTOR+0.25}, 0.2, {ease: FlxEase.linear, type: PINGPONG});
                    new FlxTimer().start(0.5, tmr->{
                        bunceTwn.cancel();
                        FlxTween.tween(bplum, {"scale.y":Constants.GAME_SCALE_FACTOR}, 0.1, {ease: FlxEase.linear});
                        FlxTween.tween(bplum, {x: babyPlumPortraitFinalPositions.x-100}, 2.2, {ease: FlxEase.linear});
                        FlxTween.tween(bplum, {"scale.y":Constants.GAME_SCALE_FACTOR+0.5,"scale.x":Constants.GAME_SCALE_FACTOR-0.7}, 0.1, {ease: FlxEase.linear, startDelay: 2});
                        FlxTween.tween(bplum, {"scale.y":Constants.GAME_SCALE_FACTOR-0.9,"scale.x":Constants.GAME_SCALE_FACTOR+0.5}, 0.15, {ease: FlxEase.linear, startDelay: 2.1});
                        FlxTween.tween(bplumFloor, {"scale.y":bplumFloorScale+0.5,"scale.x":bplumFloorScale-0.7}, 0.1, {ease: FlxEase.linear, startDelay: 2});
                        FlxTween.tween(bplumFloor, {"scale.y":bplumFloorScale-0.9,"scale.x":bplumFloorScale+0.5}, 0.15, {ease: FlxEase.linear, startDelay: 2.1});
                        FlxTween.tween(bplum, {alpha: 0,x:FlxG.width-20}, 0.2, {ease: FlxEase.linear, startDelay: 2.2});
                        FlxTween.tween(bplumFloor, {alpha: 0}, 0.2, {ease: FlxEase.linear, startDelay: 2.2});
                    });
                }
            });

            new FlxTimer().start(3, tmr->{
                FlxTween.tween(black, {alpha: 0}, 0.4, {ease: FlxEase.backIn,
                    onComplete: twn->{
                        black.kill();
                        remove(black);
                        isaacTimer.cancel();
                        isaacTimer.destroy();

                        inIntro = false;
                        player.canUpdate = true;
                    }
                });
            });
        });

        currentLevel = "Baby Plum (Boos Fight)";        
    }

    override function create() {
        backGround = new FlxSprite().loadGraphic(AssetPaths.img("rooms/basement/blooded"));
        backGround.setGraphicSize(0,FlxG.height);
        backGround.updateHitbox();
        backGround.antialiasing = false;
        backGround.screenCenter();
        add(backGround);
        trace(backGround.width+Utils.comma+backGround.height);

        super.create();
        FlxG.camera.zoom = 1.03;

        for (i in 0...4){

            var hitbox = new FlxSprite();
            trace(i);
            // odd id?
            var is_updown = i % 3 == 0;
            if (is_updown)trace(i+" true");

            if (is_updown)
            hitbox.makeGraphic(1016, 25, FlxColor.RED);
            else 
            hitbox.makeGraphic(25, 549, FlxColor.RED);

            var horizontalYPos = backGround.y+88;
            var verticalXPos = backGround.x+113;

            if (i == 3){
                horizontalYPos = FlxG.height-horizontalYPos-hitbox.height; 
            }
            if (i == 2){
                verticalXPos = FlxG.width-verticalXPos;
            }
            if (is_updown)
            hitbox.setPosition(132, horizontalYPos);
            else
            hitbox.setPosition(verticalXPos, 86);
            hitboxes.add(hitbox);
            hitbox.immovable = true;
            hitbox.visible = false;
            hitbox.ID = i;
            if (i == 1){
                hitbox.x -= hitbox.width/2;
                hitbox.x -= 11;
            }
        }
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.keys.justPressed.U){
            stats.coins++;
        }
    }
}