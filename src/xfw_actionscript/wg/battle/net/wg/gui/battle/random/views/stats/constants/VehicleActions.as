package net.wg.gui.battle.random.views.stats.constants
{
    public class VehicleActions extends Object
    {

        private static const ACTIONS_MAP:Object = {"hunting":1};

        public function VehicleActions()
        {
            super();
        }

        public static function getActionName(param1:uint) : String
        {
            var _loc2_:String = null;
            for(_loc2_ in ACTIONS_MAP)
            {
                if(ACTIONS_MAP[_loc2_] != undefined && ACTIONS_MAP[_loc2_] == param1)
                {
                    return _loc2_;
                }
            }
            return null;
        }
    }
}
