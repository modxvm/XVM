package net.wg.gui.events 
{
    import flash.events.*;
    
    public class ContextMenuEvent extends flash.events.Event
    {
        public function ContextMenuEvent(arg1:String, arg2:String="", arg3:Object=null, arg4:Object=null, arg5:Boolean=false, arg6:Boolean=false)
        {
            this.data = new Object();
            this.memberItemData = new Object();
            super(arg1, arg5, arg6);
            this.id = arg2;
            this.data = arg3;
            this.memberItemData = arg4;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.ContextMenuEvent(type, this.id, this.data, this.memberItemData, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("ContextMenuEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const ON_ITEM_SELECT:String="on_item_select";

        public static const ON_MENU_RELEASE_OUTSIDE:String="on_menu_release_outside";

        public var id:String="";

        public var data:Object;

        public var memberItemData:Object;
    }
}
