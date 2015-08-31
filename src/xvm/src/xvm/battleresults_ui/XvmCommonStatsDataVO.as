/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.battleresults_ui
{
    import net.wg.data.daapi.base.*;

    public dynamic class XvmCommonStatsDataVO extends DAAPIDataClass
    {
        public var origXP:int = 0;
        public var premXP:int = 0;
        public var shots:int = 0;
        public var hits:int = 0;
        public var damageDealt:int = 0;
        public var damageAssisted:int = 0;
        public var damageAssistedCount:int = 0;
        public var damageAssistedRadio:int = 0;
        public var damageAssistedTrack:int = 0;
        public var piercings:int = 0;
        public var kills:int = 0;
        public var origCrewXP:int = 0;
        public var premCrewXP:int = 0;
        public var spotted:int = 0;
        public var critsCount:int = 0;
        public var creditsNoPremTotalStr:String = "";
        public var creditsPremTotalStr:String = "";
        public var armorCount:int = 0;
        public var damageBlockedByArmor:int = 0;
        public var ricochetsCount:int = 0;
        public var nonPenetrationsCount:int = 0;

        public function XvmCommonStatsDataVO(data:Object)
        {
            super(data);
        }
    }
}
