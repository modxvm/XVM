import com.xvm.DataTypes.*;

class com.xvm.DataTypes.StatData
{
        public var _id:Number = NaN;           // player account id (long int)
        public var st:String = null;           // status ("ok")
        public var dt:String = null;           // XVM update date ("2013-09-02T01:21:20.080Z")
        public var cr:Number = NaN;            // created (int)
        public var up:Number = NaN;            // updated (int)
        public var nm:String = null;           // player name ("sirmax2")
        public var b:Number = NaN;             // battles (int)
        public var w:Number = NaN;             // wins (int)
        public var spo:Number = NaN;           // spotted (int)
        public var hip:Number = NaN;           // hit percent (int)
        public var cap:Number = NaN;           // capture (int)
        public var dmg:Number = NaN;           // damage (int)
        public var frg:Number = NaN;           // frags (int)
        public var def:Number = NaN;           // defence (int)
        public var lvl:Number = NaN;           // average level (float)
        public var e:Number = NaN;             // eff (int)
        public var wn6:Number = NaN;           // WN6 rating (int)
        public var wn8:Number = NaN;           // WN8 rating (int)

        public var cid:Number = NaN;           // clanId
        public var emblem:String = null;       // url for clan icon

        public var v:VData = null;             // current vehicle stat data
        public var vehicles:Object = null;     // vehicles stat data, key - vId

        public var clan:String = null;         // clan name ("CLAN")
        public var name:String = null;         // player name in current game ("sirmax2_RU" for Common Test)
        public var team:Number = NaN;          // team (1 or 2)
        public var alive:Boolean = false;      // alive
        public var ready:Boolean = false;      // avatarReady
        public var maxHealth:Number = NaN;     // max health
        public var turretType:Number = NaN;    // turret type

        // calculated
        public var r:Number = NaN;             // global win rate (int)
        public var xeff:Number = NaN;          // Eff in XVM Scale (int)
        public var xwn6:Number = NaN;          // WN6 in XVM Scale (int)
        public var xwn8:Number = NaN;          // WN8 in XVM Scale (int)
}
