import com.xvm.DataTypes.VStat;

class com.xvm.DataTypes.Stat
{
    // (*) for calculated items
    public var id:Number;           // player id
    public var name:String;         // player name
    public var vname:String;        // vehicle name
    public var b:Number;            // battles
    public var battles:Number;      // battles
    public var w:Number;            // wins
    public var r:Number;            // global win ratio
    public var e:Number;            // eff
    public var eff:Number;          // eff
    public var xeff:Number;         // xeff (*)
    public var wn:Number;           // WN
    public var xwn:Number;          // xwn (*)
    public var twr:Number;          // TWR
    public var lvl:Number;          // Average level

    public var status:String;       // status (always "ok"?)
    public var cr:Number;           // account created
    public var up:Number;           // account updated
    public var date:String;         // account stat updated
    public var dt:String;         // account stat updated
    
    public var cap:Number;          // tank capture points
    public var hip:Number;          // tank hits percent
    public var dmg:Number;          // tank damage points
    public var def:Number;          // tank defence points
    public var frg:Number;          // tank frags
    public var spo:Number;          // tank spotted points

    public var tr:Number;           // tank win ratio (*)
    
    public var te:Number;           // per-vehicle efficiency (http://www.koreanrandom.com/forum/topic/1643-)
    public var teff:Number;         // 
    public var tsb:Number;          // average number of spotted enemies per battle
    public var tdb:Number;          // average tank damage per battle
    public var tfb:Number;          // average tank frags per battle
    public var tdv:Number;          // average tank damage efficiency per battle
    
    public var v:VStat;
    
    public var tb;
    public var tw;
    public var avglvl;
}
