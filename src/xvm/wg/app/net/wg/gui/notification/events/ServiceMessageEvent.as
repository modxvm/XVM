package net.wg.gui.notification.events
{
    import flash.events.Event;
    
    public class ServiceMessageEvent extends Event
    {
        
        public function ServiceMessageEvent(param1:String, param2:uint, param3:Number, param4:Boolean = false, param5:Boolean = false, param6:String = null)
        {
            super(param1,param4,param5);
            this.typeID = param2;
            this.entityID = param3;
            this.linkType = param6;
        }
        
        public static var MESSAGE_AREA_CLICKED:String = "msgClicked";
        
        public static var MESSAGE_BUTTON_CLICKED:String = "msgBtnClicked";
        
        public static var MESSAGE_LINK_CLICKED:String = "msgLinkClicked";
        
        public var linkType:String;
        
        public var typeID:uint;
        
        public var entityID:Number;
        
        public var action:String;
        
        override public function clone() : Event
        {
            var _loc1_:ServiceMessageEvent = new ServiceMessageEvent(type,this.typeID,this.entityID,bubbles,cancelable,this.linkType);
            _loc1_.action = this.action;
            return _loc1_;
        }
        
        override public function toString() : String
        {
            return formatToString("ServiceMessageEvent","type","bubbles","cancelable","eventPhase","typeID","entityID","action","linkType");
        }
    }
}
