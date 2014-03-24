package net.wg.gui.lobby.profile.pages.technique.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.data.gui_items.ItemsUtils;


   public class TechniqueListVehicleVO extends DAAPIDataClass
   {
          
      public function TechniqueListVehicleVO(param1:Object) {
         super(param1);
      }

      public var id:int;

      public var inventoryID:int;

      public var nationID:int;

      public var isInHangar:Boolean;

      public var shortUserName:String = "";

      public var userName:String = "";

      public var battlesCount:int;

      public var winsEfficiency:Number;

      private var _winsEfficiencyStr:String = "";

      public var avgExperience:Number;

      public var nationIndex:int;

      public var typeIconPath:String = "";

      public var tankIconPath:String = "";

      public var typeIndex:int;

      public var markOfMastery:int;

      public var level:int;

      public function get winsEfficiencyStr() : String {
         return ItemsUtils.formatIntegerStr(Math.round(this.winsEfficiency)) + "%";
      }

      public function set winsEfficiencyStr(param1:String) : void {
         this._winsEfficiencyStr = param1;
      }

      public function get nationIconPath() : String {
         return App.utils.nations.getNationIcon(this.nationID);
      }
   }

}