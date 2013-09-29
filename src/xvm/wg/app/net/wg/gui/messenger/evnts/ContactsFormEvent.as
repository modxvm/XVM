package net.wg.gui.messenger.evnts 
{
    import flash.events.*;
    
    public class ContactsFormEvent extends flash.events.Event
    {
        public function ContactsFormEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false, arg4:String=null, arg5:Number=-1, arg6:String=null)
        {
            super(arg1, arg2, arg3);
            this.searchValue = arg4;
            this.name = arg6;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.messenger.evnts.ContactsFormEvent(type, bubbles, cancelable, this.searchValue, this.uid, this.name);
        }

        public override function toString():String
        {
            return formatToString("ContactsFormEvent", "type", "cancelable", "eventPhase", "searchValue", "uid", "name");
        }

        public static const SEARCH:String="search";

        public static const ADD_TO_FRIENDS:String="addToFriends";

        public static const ADD_TO_IGNORED:String="addToIgnored";

        public var searchValue:String;

        public var uid:Number=-1;

        public var name:String;
    }
}
