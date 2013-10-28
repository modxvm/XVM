package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ConditionElementVO extends DAAPIDataClass
   {
          
      public function ConditionElementVO(param1:Object) {
         this._vehicles = [];
         super(param1);
      }

      private var _descr:String = "";

      private var _vehicles:Array;

      public function get descr() : String {
         return this._descr;
      }

      public function set descr(param1:String) : void {
         this._descr = param1;
      }

      public function get vehicles() : Array {
         return this._vehicles;
      }

      public function set vehicles(param1:Array) : void {
         this._vehicles = param1;
      }
   }

}