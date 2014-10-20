package net.wg.gui.lobby.fortifications.intelligence
{
    import net.wg.infrastructure.exceptions.InfrastructureException;
    import net.wg.data.constants.Time;
    import net.wg.gui.lobby.fortifications.data.IntelligenceClanFilterVO;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.infrastructure.exceptions.LifecycleException;
    
    public class FortIntelligenceWindowHelper extends Object
    {
        
        public function FortIntelligenceWindowHelper()
        {
            super();
            if(App.instance)
            {
                App.utils.asserter.assertNull(ms_instance,"FortIntelligenceClanFilterPopoverHelper already created.",LifecycleException);
            }
        }
        
        private static var ms_instance:FortIntelligenceWindowHelper = null;
        
        public static function getInstance() : FortIntelligenceWindowHelper
        {
            if(ms_instance == null)
            {
                ms_instance = new FortIntelligenceWindowHelper();
            }
            return ms_instance;
        }
        
        public function assertHandlerTarget(param1:Boolean, param2:Object) : void
        {
            App.utils.asserter.assert(param1,"Unknown ui element: " + param2,InfrastructureException);
        }
        
        public function isDecrease(param1:int, param2:int) : Boolean
        {
            if(param1 == Time.HOURS_IN_DAY - 1 && param2 == 0)
            {
                return false;
            }
            if(param2 == Time.HOURS_IN_DAY - 1 && param1 == 0)
            {
                return true;
            }
            return param1 > param2;
        }
        
        public function getDefaultFilterData(param1:Boolean) : IntelligenceClanFilterVO
        {
            var _loc2_:Object = {};
            _loc2_.minClanLevel = int(FORTIFICATION_ALIASES.CLAN_FILTER_MIN_LEVEL);
            _loc2_.maxClanLevel = int(FORTIFICATION_ALIASES.CLAN_FILTER_MAX_LEVEL);
            _loc2_.startDefenseHour = int(FORTIFICATION_ALIASES.CLAN_FILTER_DEFAULT_HOUR);
            _loc2_.isDefault = param1;
            var _loc3_:IntelligenceClanFilterVO = new IntelligenceClanFilterVO(_loc2_);
            return _loc3_;
        }
    }
}
