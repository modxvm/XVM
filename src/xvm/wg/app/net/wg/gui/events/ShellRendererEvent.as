package net.wg.gui.events
{
   import flash.events.Event;
   import net.wg.gui.lobby.hangar.maintenance.data.ShellVO;


   public class ShellRendererEvent extends Event
   {
          
      public function ShellRendererEvent(param1:String, param2:ShellVO=null, param3:ShellVO=null) {
         super(param1,true,true);
         this.shell = param2;
         this.shellToReplace = param3;
      }

      public static const USER_COUNT_CHANGED:String = "userCountChanged";

      public static const TOTAL_PRICE_CHANGED:String = "totalPriceChanged";

      public static const CHANGE_ORDER:String = "changeOrder";

      public var shell:ShellVO = null;

      public var shellToReplace:ShellVO = null;

      override public function clone() : Event {
         return new ShellRendererEvent(type,this.shell,this.shellToReplace);
      }
   }

}