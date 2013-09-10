package net.wg.gui.lobby.techtree 
{
    import flash.events.*;
    
    public class TechTreeEvent extends flash.events.Event
    {
        public function TechTreeEvent(arg1:String, arg2:int=-1, arg3:int=-1, arg4:uint=0, arg5:Boolean=true, arg6:Boolean=false)
        {
            super(arg1, arg5, arg6);
            this.primary = arg2;
            this.index = arg3;
            this.entityType = arg4;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.lobby.techtree.TechTreeEvent(type, this.primary, this.index, this.entityType, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("TTEventTypes", "type", "primary", "index", "entityType", "bubbles", "cancelable");
        }

        public static const DATA_BUILD_COMPLETE:String="buildComplete";

        public static const RETURN_2_TECHTREE:String="techTree";

        public static const STATE_CHANGED:String="stateChanged";

        public static const CLICK_2_OPEN:String="clickToOpen";

        public static const CLICK_2_UNLOCK:String="unlock";

        public static const CLICK_2_BUY:String="buy";

        public static const CLICK_2_SELL:String="sell";

        public static const CLICK_2_INSTALL:String="install";

        public static const CLICK_2_MODULE_INFO:String="moduleInfo";

        public static const CLICK_2_VEHICLE_INFO:String="vehicleInfo";

        public var primary:int=-1;

        public var index:int=-1;

        public var entityType:uint=0;
    }
}
