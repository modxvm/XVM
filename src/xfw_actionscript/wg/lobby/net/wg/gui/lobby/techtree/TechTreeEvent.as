package net.wg.gui.lobby.techtree
{
    import flash.events.Event;

    public class TechTreeEvent extends Event
    {

        public static const DATA_BUILD_COMPLETE:String = "buildComplete";

        public static const STATE_CHANGED:String = "stateChanged";

        public static const CLICK_2_OPEN:String = "clickToOpen";

        public static const CLICK_2_UNLOCK:String = "unlock";

        public static const CLICK_2_BUY:String = "buy";

        public static const CLICK_2_RENT:String = "rent";

        public static const RESTORE_VEHICLE:String = "restoreVehicle";

        public static const GO_TO_VEHICLE_VIEW:String = "goToVehicleView";

        public static const CLICK_VEHICLE_COMPARE:String = "clickVehicleCompare";

        public static const GO_TO_BLUEPRINT_VIEW:String = "goToBluePrintView";

        public static const GO_TO_CHANGE_NATION_VIEW:String = "goToChangeNationView";

        public var nodeState:String = "";

        public var index:int = -1;

        public var entityType:uint = 0;

        public function TechTreeEvent(param1:String, param2:String = "", param3:int = -1, param4:uint = 0, param5:Boolean = true, param6:Boolean = false)
        {
            super(param1,param5,param6);
            this.nodeState = param2;
            this.index = param3;
            this.entityType = param4;
        }

        override public function clone() : Event
        {
            return new TechTreeEvent(type,this.nodeState,this.index,this.entityType,bubbles,cancelable);
        }

        override public function toString() : String
        {
            return formatToString("TTEventTypes","type","nodeState","index","entityType","bubbles","cancelable");
        }
    }
}
