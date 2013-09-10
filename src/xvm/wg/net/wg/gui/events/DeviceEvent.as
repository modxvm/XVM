package net.wg.gui.events 
{
    import flash.events.*;
    
    public class DeviceEvent extends flash.events.Event
    {
        public function DeviceEvent(arg1:String, arg2:Object, arg3:Object=null, arg4:Boolean=false)
        {
            super(arg1, true, true);
            this.newDevice = arg2;
            this.oldDevice = arg3;
            this.useGold = arg4;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.DeviceEvent(type, this.newDevice, this.oldDevice, this.useGold);
        }

        public static const DEVICE_CHANGE:String="deviceChange";

        public static const DEVICE_REMOVE:String="deviceRemove";

        public var newDevice:Object;

        public var oldDevice:Object;

        public var useGold:Boolean;
    }
}
