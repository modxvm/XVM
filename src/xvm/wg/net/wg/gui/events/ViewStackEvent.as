package net.wg.gui.events 
{
    import flash.events.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class ViewStackEvent extends flash.events.Event
    {
        public function ViewStackEvent(arg1:String, arg2:net.wg.infrastructure.interfaces.IViewStackContent, arg3:String, arg4:Boolean=false, arg5:Boolean=false)
        {
            super(arg1, arg4, arg5);
            this.view = arg2;
            this.linkage = arg3;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.ViewStackEvent(type, this.view, this.linkage, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("ViewStackEvent", "view", "linkage", "type", "bubbles", "cancelable", "eventPhase");
        }

        
        {
            NEED_UPDATE = "need_update";
            VIEW_CHANGED = "view_changed";
        }

        public var view:net.wg.infrastructure.interfaces.IViewStackContent;

        public var linkage:String;

        public static var NEED_UPDATE:String="need_update";

        public static var VIEW_CHANGED:String="view_changed";
    }
}
