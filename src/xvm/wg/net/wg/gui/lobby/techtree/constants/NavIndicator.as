package net.wg.gui.lobby.techtree.constants 
{
    public class NavIndicator extends Object
    {
        public function NavIndicator()
        {
            super();
            return;
        }

        public static function isDraw(arg1:uint):Boolean
        {
            return arg1 == net.wg.gui.lobby.techtree.constants.NodeEntityType.TOP_VEHICLE || arg1 == net.wg.gui.lobby.techtree.constants.NodeEntityType.NEXT_VEHICLE;
        }

        public static function getSource(arg1:uint):String
        {
            var loc1:*=NEXT_NAV_INDICATOR_SOURCE;
            if (arg1 == net.wg.gui.lobby.techtree.constants.NodeEntityType.TOP_VEHICLE) 
            {
                loc1 = TOP_NAV_INDICATOR_SOURCE;
            }
            return loc1;
        }

        public static const TOP_NAV_INDICATOR_SOURCE:String="TopNavIndicator";

        public static const NEXT_NAV_INDICATOR_SOURCE:String="NextNavIndicator";
    }
}
