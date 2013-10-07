package com.xvm.types.stat
{
    import flash.utils.Dictionary;

    public class StatData
    {
        // received
        public var up:Number = NaN;            // updated (int)
        public var e:Number = NaN;             // eff (int)
        public var def:Number = NaN;           // defence (int)
        public var st:String = null;           // statud ("ok")
        public var nm:String = null;           // player name ("sirmax2")
        public var b:Number = NaN;             // battles (int)
        public var spo:Number = NaN;           // spotted (int)
        public var dmg:Number = NaN;           // damage (int)
        public var w:Number = NaN;             // wins (int)
        public var lvl:Number = NaN;           // average level (float)
        public var dt:String = null;           // XVM update date ("2013-09-02T01:21:20.080Z")
        public var frg:Number = NaN;           // frags (int)
        public var _id:Number = NaN;           // player account id (long int)
        public var cr:Number = NaN;            // created (int)
        public var hip:Number = NaN;           // hit percent (int)
        public var vn:String = null;           // internal vehicle name ("IS-3")
        public var cap:Number = NaN;           // capture (int)
        public var wn:Number = NaN;            // WN6 rating (int)
        public var vdata:Dictionary = null;    // vehicle stat data, key - vname
        public var v:VData = null;             // current vehicle stat data

        public var clan:String = null;         // clan name ("CLAN")
        public var name:String = null;         // player name in current game ("sirmax2_RU" for Common Test)
        public var team:Number = NaN;          // team (1 or 2)
        public var alive:Boolean = false;      // alive
        public var ready:Boolean = false;      // avatarReady
        public var vname:String = null;        // localized vehicle name ("ИС-3")
        public var icon:String = null;         // icon file name without path: "ussr-IS-3.png")
        public var maxHealth:Number = NaN;     // maximum health (int)
        public var vtype:String = null;        // vehicle type ("mediumTank")
        public var level:Number = NaN;         // vehicle level (int)

        // calculated
        public var r:Number = NaN;             // global win rate (int)
        public var xeff:Number = NaN;          // Eff in XVM Scale (int)
        public var xwn:Number = NaN;           // WN6 in XVM Scale (int)
    }
}
