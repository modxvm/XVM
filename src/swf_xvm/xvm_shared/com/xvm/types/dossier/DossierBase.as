/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.dossier
{
    import com.xvm.types.stat.*;
    import net.wg.data.daapi.base.*;

    public class DossierBase extends DAAPIDataClass
    {
        public function DossierBase(data:Object)
        {
            super(data);
        }

        public var accountDBID:int;

        // Total
        public var battles:int;
        public var totalBattles:int;
        public var wins:int;
        public var winrate:int;
        public var xp:int;
        public var losses:int;
        public var survived:int;
        public var shots:int;
        public var hits:int;
        public var hitPercent:int;
        public var spotted:int;
        public var frags:int;
        public var damageDealt:int;
        public var damageReceived:int;
        public var capture:int;
        public var defence:int;

        // Total2
        public var originalXP:int; // what is start point?
        public var damageAssistedTrack:int; // what is start point?
        public var damageAssistedRadio:int; // what is start point?
        public var shotsReceived:int; // what is start point?
        public var noDamageShotsReceived:int; // what is start point?
        public var piercedReceived:int; // what is start point?
        public var heHitsReceived:int; // what is start point?
        public var he_hits:int; // what is start point?
        public var pierced:int; // what is start point?

        // Max
        public var maxXP:int;
        public var maxFrags:int;
        public var maxDamage:int;

        // Global
        public var battleLifeTime:int;
        public var mileage:int;
        public var treesCut:int;

        // CALCULATIONS

        // Stat
        public var stat:StatData = null;

        // Values
        public function get deaths():Number { return battles - survived; }

        // Ratios
        public function get draws():int { return battles - wins - losses; }
        public function get winPercent():Number { return _ratio(wins, battles) * 100; }
        public function get lossPercent():Number { return _ratio(losses, battles) * 100; }
        public function get drawsPercent():Number { return _ratio(draws, battles) * 100; }
        public function get survivePercent():Number { return _ratio(survived, battles) * 100; }
        public function get hitsRatio():Number { return _ratio(hits, shots); }

        // Averages
        public function get avgXP():Number { return _ratio(xp, battles); }
        public function get avgDamageDealt():Number { return _ratio(damageDealt, battles); }
        public function get avgDamageReceived():Number { return _ratio(damageReceived, battles); }
        public function get avgFrags():Number { return _ratio(frags, battles); }
        public function get avgSpotted():Number { return _ratio(spotted, battles); }

        // Other
        public function get avgHits():Number { return _ratio(hits, battles); }
        public function get avgBattleLifeTime():Number { return _ratio(battleLifeTime, battles); }

        // PRIVATE

        private function _ratio(a:Number, b:Number):Number
        {
            return b <= 0 ? 0 : a / b;
        }
    }
}
