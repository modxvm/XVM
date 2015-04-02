package com.xvm.events
{
    import com.xvm.*;
    import flash.events.*;

    public class XfwCmdReceivedEvent extends Event
    {
        public var cmd:String;
        public var args:Array;
        public var retValue:*;

        public function XfwCmdReceivedEvent(cmd:String, args:Array, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(Defines.XFW_EVENT_CMD_RECEIVED, bubbles, cancelable);
            this.cmd = cmd;
            this.args = args;
            this.retValue = null;
        }

        public override function clone():Event
        {
            var copy:XfwCmdReceivedEvent = new XfwCmdReceivedEvent(cmd, args, bubbles, cancelable);
            copy.retValue = this.retValue;
            return copy;
        }
    }
}
