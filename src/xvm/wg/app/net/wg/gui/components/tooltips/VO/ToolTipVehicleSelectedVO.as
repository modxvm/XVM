package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ToolTipVehicleSelectedVO extends DAAPIDataClass
   {
          
      public function ToolTipVehicleSelectedVO(param1:Object) {
         super(param1);
      }

      private var _typeCompDescr:int = 0;

      public function get typeCompDescr() : int {
         return this._typeCompDescr;
      }

      public function set typeCompDescr(param1:int) : void {
         this._typeCompDescr = param1;
      }
   }

}