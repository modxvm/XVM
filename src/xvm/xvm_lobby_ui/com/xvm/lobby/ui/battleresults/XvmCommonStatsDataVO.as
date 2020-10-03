/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.battleresults
{
    import com.xfw.*;
    import net.wg.data.constants.*;
    import net.wg.data.daapi.base.*;

    public class XvmCommonStatsDataVO extends DAAPIDataClass
    {
        public var origXP:int = 0;
        public var premXP:int = 0;
        public var origCrewXP:int = 0;
        public var premCrewXP:int = 0;
        public var damageDealt:int = 0;
        public var damageAssisted:int = 0;
        public var damageAssistedCount:int = 0;
        public var damageAssistedRadio:int = 0;
        public var damageAssistedTrack:int = 0;
        public var damageAssistedStun:int = 0;
        public var damageBlockedByArmor:int = 0;
        public var shots:int = 0;
        public var hits:int = 0;
        public var piercings:int = 0;
        public var kills:int = 0;
        public var spotted:int = 0;
        public var stunNum:int = 0;
        public var stunDuration:Number = 0;
        public var critsCount:int = 0;
        public var ricochetsCount:int = 0;
        public var nonPenetrationsCount:int = 0;

        // calculated

        public var creditsNoPremTotalStr:String = Values.EMPTY_STR;
        public var creditsPremTotalStr:String = Values.EMPTY_STR;

        public function XvmCommonStatsDataVO(data:Object)
        {
            super(data);
        }
    }
}
