package net.wg.gui.lobby.messengerBar
{
   import net.wg.infrastructure.base.DefaultWindowGeometry;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.infrastructure.interfaces.IAbstractWindowView;
   import net.wg.gui.events.MessengerBarEvent;
   
   public class WindowGeometryInBar extends DefaultWindowGeometry
   {
      
      public function WindowGeometryInBar(param1:String, param2:Number = 0) {
         super();
         this.eventType = param1;
         this.clientID = param2;
      }
      
      private var eventType:String;
      
      private var clientID:Number;
      
      private var doPositionOnce:Boolean = true;
      
      override public function setPosition(param1:IWindow) : Boolean {
         var _loc2_:IAbstractWindowView = param1.windowContent;
         if((_loc2_) && (this.doPositionOnce))
         {
            _loc2_.dispatchEvent(new MessengerBarEvent(this.eventType,this.clientID));
            this.doPositionOnce = false;
         }
         return false;
      }
   }
}
