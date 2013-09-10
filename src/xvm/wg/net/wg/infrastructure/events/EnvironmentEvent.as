package net.wg.infrastructure.events 
{
    import flash.events.*;
    
    public class EnvironmentEvent extends flash.events.Event
    {
        public function EnvironmentEvent(arg1:String, ... rest)
        {
            this._args = rest;
            super(arg1);
            return;
        }

        public function getArgs():Array
        {
            return this._args;
        }

        public static const LOGOFF:String="WoTLogoff";

        public static const QIUT:String="WoTQuit";

        internal var _args:Array=null;
    }
}
