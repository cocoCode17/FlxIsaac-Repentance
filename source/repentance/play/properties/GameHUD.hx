package repentance.play.properties;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import repentance.engine.RepentanceSprite;

class GameHUD extends FlxTypedSpriteGroup<FlxSprite>{
    public var coinsIcon:RepentanceSprite;
    public var bombsIcon:RepentanceSprite;
    public var keysIcon:RepentanceSprite;

    public var coinsTxt:FlxText;
    public var bombsTxt:FlxText;
    public var keysTxt:FlxText;

    public var hearths:Array<Hearth> = [];
    public var currentHearth:Int = -1;

    public var room:Room;

    var positions = {
        coin: [27, 136],
        bomb: [22, 169],
        key: [27, 205]
    }

    public function new(x=0.,y=0., room:Room) {
        super();

        this.room = room;

        coinsIcon = new RepentanceSprite(x+positions.coin[0],y+positions.coin[1]);
        coinsIcon.loadGraphic(AssetPaths.img("hud/hud_icons"), true, 15, 13);
        coinsIcon.animation.add("coin", [0],0,true);
        coinsIcon.animation.play("coin");
        coinsIcon.adjustSize(3);
        add(coinsIcon);
        
        bombsIcon = new RepentanceSprite(x+positions.bomb[0],y+positions.bomb[1]);
        bombsIcon.loadGraphic(AssetPaths.img("hud/hud_icons"), true, 15, 13);
        bombsIcon.animation.add("bomb", [1],0,true);
        bombsIcon.animation.play("bomb");
        bombsIcon.adjustSize(3);
        add(bombsIcon);
           
        keysIcon = new RepentanceSprite(x+positions.key[0],y+positions.key[1]);
        keysIcon.loadGraphic(AssetPaths.img("hud/hud_icons"), true, 15, 13);
        keysIcon.animation.add("key", [2],0,true);
        keysIcon.animation.play("key");
        keysIcon.adjustSize(3);
        add(keysIcon);

        coinsTxt = new FlxText(0,0,-1,"00",27);
        coinsTxt.setFormat(null, 27, FlxColor.WHITE, RIGHT, OUTLINE, FlxColor.BLACK);
        coinsTxt.borderSize = 3;
        add(coinsTxt);
        coinsTxt.text = StringTools.lpad(Std.string(room.stats.coins), "0", 2);
        coinsTxt.x = 36+(coinsIcon.x + 6);
        coinsTxt.y = coinsIcon.y + 3;
        
        bombsTxt = new FlxText(0,0,-1,"00",27);
        bombsTxt.setFormat(null, 27, FlxColor.WHITE, RIGHT, OUTLINE, FlxColor.BLACK);
        bombsTxt.borderSize = 3;
        add(bombsTxt);
        bombsTxt.text = StringTools.lpad(Std.string(room.stats.bombs), "0", 2);
        bombsTxt.x = 36+(bombsIcon.x + 11);
        bombsTxt.y = bombsIcon.y + 3;

        keysTxt = new FlxText(0,0,-1,"00",27);
        keysTxt.setFormat(null, 27, FlxColor.WHITE, RIGHT, OUTLINE, FlxColor.BLACK);
        keysTxt.borderSize = 3;
        add(keysTxt);
        keysTxt.text = StringTools.lpad(Std.string(room.stats.keys), "0", 2);
        keysTxt.x = 36+(keysIcon.x + 6);
        keysTxt.y = keysIcon.y + 3;

        for (i in 0...room.stats.hearths){
            var hearth = new Hearth(x+124, y+57);
            hearth.loadGraphic(AssetPaths.img("hud/ui"), true, 16,16);
            hearth.animation.add("red_hearth", [0],0,true);
            hearth.animation.add("red_hearth_half", [1],0,true);

            hearth.animation.add("blank_hearth", [2],0,true);

            hearth.animation.add("white_hearth_half", [3],0,true);

            hearth.animation.add("white_hearth_dot", [4],0,true);

            hearth.animation.add("coin", [5],0,true);
            hearth.animation.add("coin_blank", [6],0,true);
            
            hearth.animation.add("blue_hearth", [7],0,true);
            hearth.animation.add("blue_hearth_half", [8],0,true);
            
            hearth.animation.add("dark_hearth", [9],0,true);
            hearth.animation.add("dark_hearth_half", [10],0,true);

            hearth.animation.play("red_hearth");
            hearth.adjustSize(3);
            hearth.ID = i;
            // hearth.setPosition(x+144, y+26);
            hearth.x += (hearth.width-9)*i;
            add(hearth);
            hearths.push(hearth);
        }
        if (hearths.length>0)
        currentHearth = hearths.length;
        trace(currentHearth);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        coinsTxt.text = StringTools.lpad(Std.string(room.stats.coins), "0", 2);
        bombsTxt.text = StringTools.lpad(Std.string(room.stats.bombs), "0", 2);
        keysTxt.text = StringTools.lpad(Std.string(room.stats.keys), "0", 2);

        if (FlxG.keys.justPressed.P){
            updateHearth(true);
        }
    }

    /**
        * This update the status of the lastHearth
    **/
    public function updateHearth(hurt:Bool=true) {
        var lastHearth = hearths[currentHearth-1];
        if (hurt){
            if (lastHearth != null){
                if (!lastHearth.half){
                    lastHearth.half = true;
                }else{
                    lastHearth.animation.play("blank_hearth",true);
                    currentHearth-=1;
                }
            }
        }else{
            if (lastHearth != null){
                if (!lastHearth.half){
                    lastHearth.half = true;
                }else{
                    lastHearth.animation.play("blank_hearth",true);
                    currentHearth+=1;
                }
            }
        }
    }
}

class Hearth extends RepentanceSprite {
    public var half(default, set):Bool = false;
    private function set_half(v){
        if (v){
        animation.play("red_hearth_half",true);
        }else{
        animation.play("red_hearth",true);
        }
        half = v;
        return v;
    }
    public function new(X=0.,Y=0.) {
        super(X,Y);
    }
}