package net.wg.gui.notification
{
   import flash.events.Event;


   public class ServiceMessageEvent extends Event
   {
          
      public function ServiceMessageEvent(param1:String, param2:Boolean=false, param3:Boolean=false, param4:String=null) {
         super(param1,param2,param3);
         this.linkType = param4;
      }

      public static const MESSAGE_AREA_CLICKED:String = "msgClicked";

      public static const MESSAGE_BUTTON_CLICKED:String = "msgBtnClicked";

      public static const MESSAGE_LINK_CLICKED:String = "msgLinkClicked";

      public var linkType:String;

      override public function clone() : Event {
         return new ServiceMessageEvent(type,bubbles,cancelable,this.linkType);
      }

      override public function toString() : String {
         return formatToString("ServiceMessageEvent","type","bubbles","cancelable","eventPhase","linkType");
      }
   }

}