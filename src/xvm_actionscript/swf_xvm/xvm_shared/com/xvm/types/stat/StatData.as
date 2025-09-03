/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.stat
{
    public class StatData
    {
        public var vehicleID:Number = NaN;

        // received
        public var player_id:Number = NaN;     // player account id (long int)
        public var name_db:String = null;      // player name in DB
        public var ts:Number = NaN;            // XVM update timestamp (long)
        public var battles:Number = NaN;       // battles (int)
        public var wins:Number = NaN;          // wins (int)
        public var spo:Number = NaN;           // spotted (int)
        public var hip:Number = NaN;           // hit percent (int)
        public var cap:Number = NaN;           // capture (int)
        public var dmg:Number = NaN;           // damage (int)
        public var frg:Number = NaN;           // frags (int)
        public var def:Number = NaN;           // defence (int)
        public var avglvl:Number = NaN;        // average level (float)
        public var eff:Number = NaN;           // eff (int)
        public var wtr:Number = NaN;           // WTR rating (int)
        public var wn8:Number = NaN;           // WN8 rating (int)
        public var wgr:Number = NaN;           // WG rating (int)

        public var winrate:Number = NaN;       // global win rate (int)
        public var xte:Number = NaN;           // xTE (int)
        public var xeff:Number = NaN;          // Eff in XVM Scale (int)
        public var xwtr:Number = NaN;          // WTR in XVM Scale (int)
        public var xwn8:Number = NaN;          // WN8 in XVM Scale (int)
        public var xwgr:Number = NaN;          // WG rating in XVM Scale (int)
        public var xwr:Number = NaN;           // GWR in XVM Scale (int)

        public var emblem:String = null;       // url for clan icon
        public var x_emblem:String = null;     // local cache url for clan icon

        public var v:VData = null;             // current vehicle stat data
        public var vehicles:Object = null;     // vehicles stat data, key - vehCD

        public var clan:String = null;         // clan name ("CLAN")
        public var clan_id:Number = NaN;       // clan id
        public var badgeId:String = null;      // rank badge id
        public var badgeStage:String = null;   // battle pass stage
        public var rank:Number = NaN;          // clan rank (wGM)
        public var name:String = null;         // player name in current game ("sirmax2_RU" for Common Test)
        public var status:Number = NaN;        // XVM activation status
        public var flag:String = null;         // client flag
        public var team:Number = NaN;          // team (1 or 2)
        public var alive:Boolean = false;      // alive
        public var ready:Boolean = false;      // avatarReady
        public var maxHealth:Number = NaN;     // max health
        public var turretType:Number = NaN;    // turret type

        public var xvm_contact_data:Object = null;
    }
}
