package net.wg.gui.lobby.techtree.constants
{
    public class NodeEntityType extends Object
    {
        
        public function NodeEntityType()
        {
            super();
        }
        
        public static var UNDEFINED:uint = 0;
        
        public static var NATION_TREE:uint = 1;
        
        public static var RESEARCH_ROOT:uint = 2;
        
        public static var RESEARCH_ITEM:uint = 3;
        
        public static var TOP_VEHICLE:uint = 4;
        
        public static var NEXT_VEHICLE:uint = 5;
        
        public static function isVehicleType(param1:uint) : Boolean
        {
            return param1 == NATION_TREE || param1 == RESEARCH_ROOT || param1 == TOP_VEHICLE || param1 == NEXT_VEHICLE;
        }
        
        public static function isModuleType(param1:uint) : Boolean
        {
            return param1 == RESEARCH_ITEM;
        }
    }
}
