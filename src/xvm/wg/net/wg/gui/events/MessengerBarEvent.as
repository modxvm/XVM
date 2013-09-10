package net.wg.gui.events 
{
    import flash.events.*;
    
    public class MessengerBarEvent extends flash.events.Event
    {
        public function MessengerBarEvent(arg1:String, arg2:Number=0, arg3:Boolean=true, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.clientID = arg2;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.MessengerBarEvent(type, this.clientID, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("MessengerBarEvent", "type", "clientID", "bubbles", "cancelable");
        }

        public static const PIN_CAROUSEL_WINDOW:String="pinCarouselWidow";

        public static const PIN_CHANNELS_WINDOW:String="pinChannelsWidow";

        public static const PIN_CONTACTS_WINDOW:String="pinContactsWidow";

        public static const PIN_RECEIVED_INVITES_WINDOW:String="pinReceivedInvitesWindow";

        public var clientID:Number=0;
    }
}
