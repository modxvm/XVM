package net.wg.gui.lobby.quests.events
{
    import flash.events.Event;
    
    public class ChainProgressEvent extends Event
    {
        
        public function ChainProgressEvent(param1:String, param2:Number = -1)
        {
            super(param1,true,true);
            this.awardVehicleID = param2;
        }
        
        public static var SHOW_VEHICLE_INFO:String = "showVehicleInfo";
        
        public static var SHOW_VEHICLE_IN_HANGAR:String = "showVehicleInHangar";
        
        public var awardVehicleID:Number = -1;
    }
}
