package net.wg.gui.lobby.settings.evnts 
{
    import flash.events.*;
    
    public class SettingViewEvent extends flash.events.Event
    {
        public function SettingViewEvent(arg1:String, arg2:String, arg3:String="", arg4:*=null, arg5:Boolean=true, arg6:Boolean=false)
        {
            super(arg1, arg5, arg6);
            this.viewId = arg2;
            this.controlId = arg3;
            this.controlValue = arg4;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.lobby.settings.evnts.SettingViewEvent(type, this.viewId, this.controlId, this.controlValue, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("SettingViewEvent", "type", "viewId", "controlId", "controlValue", "bubbles", "cancelable", "eventPhase");
        }

        
        {
            ON_CONTROL_CHANGED = "on_control_changed";
            ON_AUTO_DETECT_QUALITY = "on_auto_detect_quality";
            ON_VIVOX_TEST = "on_vivox_test";
            ON_UPDATE_CAPTURE_DEVICE = "on_update_capture_device";
            ON_VOICE_CHAT_ENABLED = "on_voice_chat_enabled";
            ON_PTT_CONTROL_CHANGED = "on_relate_control_changed";
        }

        public var viewId:String;

        public var controlId:String;

        public var controlValue:*;

        public static var ON_CONTROL_CHANGED:String="on_control_changed";

        public static var ON_AUTO_DETECT_QUALITY:String="on_auto_detect_quality";

        public static var ON_VIVOX_TEST:String="on_vivox_test";

        public static var ON_UPDATE_CAPTURE_DEVICE:String="on_update_capture_device";

        public static var ON_VOICE_CHAT_ENABLED:String="on_voice_chat_enabled";

        public static var ON_PTT_CONTROL_CHANGED:String="on_relate_control_changed";
    }
}
