package net.wg.gui.messenger.evnts 
{
    import flash.events.*;
    
    public class ChannelsFormEvent extends flash.events.Event
    {
        public function ChannelsFormEvent(arg1:String, arg2:Boolean=true, arg3:Boolean=false, arg4:String="", arg5:String=null, arg6:String=null, arg7:Number=-1)
        {
            super(arg1, arg2, arg3);
            this.channelName = arg4;
            this.channelPass = arg5;
            this.channelRetypePass = arg6;
            this.index = arg7;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.messenger.evnts.ChannelsFormEvent(type, bubbles, cancelable, this.channelName, this.channelPass, this.channelRetypePass, this.index);
        }

        public override function toString():String
        {
            return formatToString("ChannelsFormEvent", "type", "cancelable", "eventPhase", "channelName", "channelPass", "channelRetypePass", "index");
        }

        
        {
            ON_SEARCH_CHANNEL_CLICK = "on_search_channel_click";
            ON_JOIN = "on_join";
            ON_CREATE_CHANNEL = "on_create_channel";
        }

        public var channelName:String="";

        public var channelPass:String=null;

        public var channelRetypePass:String=null;

        public var index:Number=-1;

        public static var ON_SEARCH_CHANNEL_CLICK:String="on_search_channel_click";

        public static var ON_JOIN:String="on_join";

        public static var ON_CREATE_CHANNEL:String="on_create_channel";
    }
}
