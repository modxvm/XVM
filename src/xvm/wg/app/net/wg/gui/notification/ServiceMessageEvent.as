package net.wg.gui.notification 
{
    import flash.events.*;
    
    public class ServiceMessageEvent extends flash.events.Event
    {
        public function ServiceMessageEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false, arg4:String=null)
        {
            super(arg1, arg2, arg3);
            this.linkType = arg4;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.notification.ServiceMessageEvent(type, bubbles, cancelable, this.linkType);
        }

        public override function toString():String
        {
            return formatToString("ServiceMessageEvent", "type", "bubbles", "cancelable", "eventPhase", "linkType");
        }

        public static const MESSAGE_AREA_CLICKED:String="msgClicked";

        public static const MESSAGE_BUTTON_CLICKED:String="msgBtnClicked";

        public static const MESSAGE_LINK_CLICKED:String="msgLinkClicked";

        public var linkType:String;
    }
}
