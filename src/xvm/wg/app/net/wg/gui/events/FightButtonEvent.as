package net.wg.gui.events
{
   import flash.events.Event;


   public class FightButtonEvent extends Event
   {
          
      public function FightButtonEvent(param1:String, param2:String=null, param3:int=undefined) {
         super(param1,true,true);
         this.option = param2;
         this.mapID = param3;
      }

      public static const FIGHT_CLICK:String = "fightClick";

      public static const SELECT_CLICK:String = "selectClick";

      public static const SELECT_TOGGLE:String = "selectToggle";

      public var option:String;

      public var mapID:Number;

      override public function clone() : Event {
         return new FightButtonEvent(type,this.option);
      }
   }

}