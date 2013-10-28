package net.wg.gui.cyberSport.controls.events
{
   import flash.events.Event;


   public class NavigationEvent extends Event
   {
          
      public function NavigationEvent(param1:String, param2:Boolean=true, param3:Boolean=true, param4:Boolean=false) {
         super(param1,param3,param4);
         this.isInCoolDown = param2;
      }

      public static const NAVIGATION_IN_COOL_DOWN:String = "navInCoolDown";

      public var isInCoolDown:Boolean;

      override public function clone() : Event {
         return new NavigationEvent(type,this.isInCoolDown,bubbles,cancelable);
      }

      override public function toString() : String {
         return formatToString("TTEventTypes","type","isInCoolDown","bubbles","cancelable");
      }
   }

}