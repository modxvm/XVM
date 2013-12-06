package net.wg.gui.lobby.GUIEditor
{
   import flash.events.Event;


   public class ChangePropertyEvent extends Event
   {
          
      public function ChangePropertyEvent(param1:String, param2:String, param3:String) {
         super(param1,true,true);
         this._property = param2;
         this._newValue = param3;
      }

      public static const CHANGE_PROPERTY:String = "onChangeProperty";

      private var _property:String;

      private var _newValue:String;

      public function get property() : String {
         return this._property;
      }

      public function get newValue() : String {
         return this._newValue;
      }
   }

}