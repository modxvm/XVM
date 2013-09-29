package net.wg.gui.prebattle.invites 
{
    import flash.events.*;
    
    public class SendInvitesEvent extends flash.events.Event
    {
        public function SendInvitesEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public static const INIT_COMPONENT:String="initComponent";

        public static const SEARCH_TOKEN:String="searchToken";

        public static const LIST_DOUBLE_CLICK:String="listItemDoubleClick";

        public static const SHOW_CONTEXT_MENU:String="showContextMenu";

        public var searchString:String;

        public var initItem:Object;
    }
}
