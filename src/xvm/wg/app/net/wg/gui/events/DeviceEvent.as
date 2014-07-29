package net.wg.gui.events
{
    import flash.events.Event;
    
    public class DeviceEvent extends Event
    {
        
        public function DeviceEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false)
        {
            super(param1,true,true);
            this.newDevice = param2;
            this.oldDevice = param3;
            this.useGold = param4;
        }
        
        public static var DEVICE_CHANGE:String = "deviceChange";
        
        public static var DEVICE_REMOVE:String = "deviceRemove";
        
        public var newDevice:Object;
        
        public var oldDevice:Object;
        
        public var useGold:Boolean;
        
        override public function clone() : Event
        {
            return new DeviceEvent(type,this.newDevice,this.oldDevice,this.useGold);
        }
    }
}
