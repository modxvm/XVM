package net.wg.gui.events
{
    import flash.events.Event;
    
    public class MessengerBarEvent extends Event
    {
        
        public function MessengerBarEvent(param1:String, param2:Number = 0, param3:Boolean = true, param4:Boolean = false)
        {
            super(param1,param3,param4);
            this.clientID = param2;
        }
        
        public static var PIN_CAROUSEL_WINDOW:String = "pinCarouselWidow";
        
        public static var PIN_CHANNELS_WINDOW:String = "pinChannelsWidow";
        
        public static var PIN_CONTACTS_WINDOW:String = "pinContactsWidow";
        
        public var clientID:Number = 0;
        
        override public function clone() : Event
        {
            return new MessengerBarEvent(type,this.clientID,bubbles,cancelable);
        }
        
        override public function toString() : String
        {
            return formatToString("MessengerBarEvent","type","clientID","bubbles","cancelable");
        }
    }
}
