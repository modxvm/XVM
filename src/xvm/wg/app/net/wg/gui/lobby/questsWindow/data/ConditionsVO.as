package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ConditionsVO extends DAAPIDataClass
   {
          
      public function ConditionsVO(param1:Object) {
         this._elements = [];
         super(param1);
      }

      private var _title:String = "";

      private var _elements:Array;

      public function get title() : String {
         return this._title;
      }

      public function set title(param1:String) : void {
         this._title = param1;
      }

      public function get elements() : Array {
         return this._elements;
      }

      public function set elements(param1:Array) : void {
         this._elements = param1;
      }
   }

}