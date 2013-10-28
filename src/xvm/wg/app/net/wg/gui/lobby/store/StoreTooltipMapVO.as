package net.wg.gui.lobby.store
{


   public class StoreTooltipMapVO extends Object
   {
          
      public function StoreTooltipMapVO(param1:String, param2:String, param3:String) {
         super();
         this._vehId = param1;
         this._shellId = param2;
         this._defaultId = param3;
      }

      private var _vehId:String = null;

      private var _shellId:String = null;

      private var _defaultId:String = null;

      public function get vehId() : String {
         return this._vehId;
      }

      public function get shellId() : String {
         return this._shellId;
      }

      public function get defaultId() : String {
         return this._defaultId;
      }
   }

}