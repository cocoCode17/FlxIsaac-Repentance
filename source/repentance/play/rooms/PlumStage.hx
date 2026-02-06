package repentance.play.rooms;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class PlumStage extends Room {
    public function new() {
        super("basement", BLOOD, {x: 300, y: 400});
        currentLevel = "Baby Plum (Boos Fight)";        
    }

    override function create() {
        backGround = new FlxSprite().loadGraphic(AssetPaths.img("rooms/basement/blooded"));
        backGround.setGraphicSize(0,FlxG.height);
        backGround.updateHitbox();
        backGround.antialiasing = false;
        backGround.screenCenter();
        add(backGround);

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

            var horizontalYPos = backGround.y+60;
            var verticalXPos = backGround.x+84;

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