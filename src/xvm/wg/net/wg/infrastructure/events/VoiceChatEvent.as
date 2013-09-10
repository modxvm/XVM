package net.wg.infrastructure.events 
{
    import flash.events.*;
    
    public class VoiceChatEvent extends flash.events.Event
    {
        public function VoiceChatEvent(arg1:String, arg2:uint, arg3:Boolean)
        {
            super(arg1);
            this._accountDBID = arg2;
            this._himself = arg3;
            return;
        }

        public function getAccountDBID():uint
        {
            return this._accountDBID;
        }

        public function isHimself():Boolean
        {
            return this._himself;
        }

        public static const START_SPEAKING:String="startSpeaking";

        public static const STOP_SPEAKING:String="stopSpeaking";

        internal var _accountDBID:uint;

        internal var _himself:Boolean;
    }
}
