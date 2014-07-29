package net.wg.gui.lobby.techtree
{
    import flash.events.Event;
    
    public class TechTreeEvent extends Event
    {
        
        public function TechTreeEvent(param1:String, param2:int = -1, param3:int = -1, param4:uint = 0, param5:Boolean = true, param6:Boolean = false)
        {
            super(param1,param5,param6);
            this.primary = param2;
            this.index = param3;
            this.entityType = param4;
        }
        
        public static var DATA_BUILD_COMPLETE:String = "buildComplete";
        
        public static var RETURN_2_TECHTREE:String = "techTree";
        
        public static var STATE_CHANGED:String = "stateChanged";
        
        public static var CLICK_2_OPEN:String = "clickToOpen";
        
        public static var CLICK_2_UNLOCK:String = "unlock";
        
        public static var CLICK_2_BUY:String = "buy";
        
        public static var CLICK_2_SELL:String = "sell";
        
        public static var CLICK_2_SELECT_IN_HANGAR:String = "selectInHangar";
        
        public static var CLICK_2_SHOW_VEHICLE_STATS:String = "showVehicleStats";
        
        public static var CLICK_2_INSTALL:String = "install";
        
        public static var CLICK_2_MODULE_INFO:String = "moduleInfo";
        
        public static var CLICK_2_VEHICLE_INFO:String = "vehicleInfo";
        
        public var primary:int = -1;
        
        public var index:int = -1;
        
        public var entityType:uint = 0;
        
        override public function clone() : Event
        {
            return new TechTreeEvent(type,this.primary,this.index,this.entityType,bubbles,cancelable);
        }
        
        override public function toString() : String
        {
            return formatToString("TTEventTypes","type","primary","index","entityType","bubbles","cancelable");
        }
    }
}
