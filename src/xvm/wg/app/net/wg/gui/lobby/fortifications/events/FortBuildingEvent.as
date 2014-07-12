package net.wg.gui.lobby.fortifications.events
{
   import flash.events.Event;
   import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
   
   public class FortBuildingEvent extends Event
   {
      
      public function FortBuildingEvent(param1:String) {
         super(param1,true,true);
      }
      
      public static const BUY_BUILDINGS:String = "buyBuildings";
      
      public static const BUILDING_SELECTED:String = "buildingSelected";
      
      public static const FIRST_TRANSPORTING_STEP:String = "step1";
      
      public static const NEXT_TRANSPORTING_STEP:String = "step2";
      
      public var isOpenedCtxMenu:Boolean = false;
      
      private var _position:int = -1;
      
      private var _direction:int = -1;
      
      private var _uid:String = "";
      
      public function get uid() : String {
         return this._uid;
      }
      
      public function set uid(param1:String) : void {
         this._uid = param1;
      }
      
      public function get position() : int {
         return this._position;
      }
      
      public function set position(param1:int) : void {
         this._position = param1;
      }
      
      public function get direction() : int {
         return this._direction;
      }
      
      public function set direction(param1:int) : void {
         this._direction = param1;
      }
   }
}
