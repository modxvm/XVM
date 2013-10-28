package net.wg.gui.components.controls.achievements
{
   import flash.events.Event;


   public class AchievementEvent extends Event
   {
          
      public function AchievementEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }

      public static const REQUEST_RARE_ACHIEVEMENT:String = "requestRareAchievement";

      override public function clone() : Event {
         return new AchievementEvent(type,bubbles,cancelable);
      }

      override public function toString() : String {
         return formatToString("AchievementEvent","type","bubbles","cancelable","eventPhase");
      }
   }

}