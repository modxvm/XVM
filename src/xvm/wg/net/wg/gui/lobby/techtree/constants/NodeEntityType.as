package net.wg.gui.lobby.techtree.constants 
{
    public class NodeEntityType extends Object
    {
        public function NodeEntityType()
        {
            super();
            return;
        }

        public static function isVehicleType(arg1:uint):Boolean
        {
            return arg1 == NATION_TREE || arg1 == RESEARCH_ROOT || arg1 == TOP_VEHICLE || arg1 == NEXT_VEHICLE;
        }

        public static function isModuleType(arg1:uint):Boolean
        {
            return arg1 == RESEARCH_ITEM;
        }

        public static const UNDEFINED:uint=0;

        public static const NATION_TREE:uint=1;

        public static const RESEARCH_ROOT:uint=2;

        public static const RESEARCH_ITEM:uint=3;

        public static const TOP_VEHICLE:uint=4;

        public static const NEXT_VEHICLE:uint=5;
    }
}
