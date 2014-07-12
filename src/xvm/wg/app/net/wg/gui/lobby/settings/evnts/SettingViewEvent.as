package net.wg.gui.lobby.settings.evnts
{
   import flash.events.Event;
   
   public class SettingViewEvent extends Event
   {
      
      public function SettingViewEvent(param1:String, param2:String, param3:String = "", param4:* = null, param5:Boolean = true, param6:Boolean = false) {
         super(param1,param5,param6);
         this.viewId = param2;
         this.controlId = param3;
         this.controlValue = param4;
      }
      
      public static var ON_CONTROL_CHANGED:String = "on_control_changed";
      
      public static var ON_AUTO_DETECT_QUALITY:String = "on_auto_detect_quality";
      
      public static var ON_VIVOX_TEST:String = "on_vivox_test";
      
      public static var ON_UPDATE_CAPTURE_DEVICE:String = "on_update_capture_device";
      
      public static var ON_VOICE_CHAT_ENABLED:String = "on_voice_chat_enabled";
      
      public static var ON_PTT_CONTROL_CHANGED:String = "on_relate_control_changed";
      
      public var viewId:String;
      
      public var controlId:String;
      
      public var controlValue;
      
      override public function clone() : Event {
         return new SettingViewEvent(type,this.viewId,this.controlId,this.controlValue,bubbles,cancelable);
      }
      
      override public function toString() : String {
         return formatToString("SettingViewEvent","type","viewId","controlId","controlValue","bubbles","cancelable","eventPhase");
      }
   }
}
