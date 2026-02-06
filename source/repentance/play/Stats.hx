package repentance.play;

class Stats {
    public var coins:Int = 0;
    public var bombs:Int = 0;
    public var keys:Int = 0;

    public var hearths:Int = 3;

    /**
    # How Works?
     
    - so simple, if you wanna put a blue hearth just, set -1 to set that red rearth to an blue hearth
    in the order
    **/
    public var blueHearths:Array<Int> = [1,1,1];

    public function new(?customStats:Dynamic = null) {
        if (customStats == null){
            customStats = {coins:0,bombs:0,keys:0,hearths:3, blueHearths:[]}
        }else {
            coins = customStats.coins;
            bombs = customStats.bombs;
            keys = customStats.keys;
        }
    }

    public function getCoins() {
        return coins;
    }

    public function getBombs() {
        return bombs;
    }

    public function getKeys() {
        return keys;
    }

    public function getStats(){
        var comma = ", ";
        return 'Coins: ${coins}'+comma+'Bombs: ${bombs}'+comma+'Keys: ${keys}'+comma+'Hearths: ${hearths}';
    }
}