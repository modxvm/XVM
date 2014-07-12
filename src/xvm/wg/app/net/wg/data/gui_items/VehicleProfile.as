package net.wg.data.gui_items
{
   public class VehicleProfile extends Vehicle
   {
      
      public function VehicleProfile(param1:int) {
         super(param1);
      }
      
      private var _markOfMastery:int;
      
      private var _battlesCount:int;
      
      private var _wins:int;
      
      private var _winsEfficiency:Number;
      
      private var _winsEfficiencyStr:String;
      
      private var _avgExperience:int = 0;
      
      private var _avgExperienceStr:String;
      
      public function get battlesCount() : int {
         return this._battlesCount;
      }
      
      public function get wins() : int {
         return this._wins;
      }
      
      public function get markOfMastery() : int {
         return this._markOfMastery;
      }
      
      public function set markOfMastery(param1:int) : void {
         this._markOfMastery = param1;
      }
      
      public function set battlesCount(param1:int) : void {
         this._battlesCount = param1;
      }
      
      public function set wins(param1:int) : void {
         this._wins = param1;
      }
      
      public function get typeIconPath() : String {
         return "../maps/icons/filters/tanks/" + type + ".png";
      }
      
      public function get masteryIconPath() : String {
         if(this._markOfMastery > 0)
         {
            return "../maps/icons/achievement/markOfMastery" + this._markOfMastery + ".png";
         }
         return null;
      }
      
      public function get nationIconPath() : String {
         return App.utils.nations.getNationIcon(nationID);
      }
      
      public function get winsEfficiency() : Number {
         return this._winsEfficiency;
      }
      
      public function set winsEfficiency(param1:Number) : void {
         this._winsEfficiency = param1;
         this.winsEfficiencyStr = ItemsUtils.formatIntegerStr(param1) + "%";
      }
      
      public function get winsEfficiencyStr() : String {
         return this._winsEfficiencyStr;
      }
      
      public function set winsEfficiencyStr(param1:String) : void {
         this._winsEfficiencyStr = param1;
      }
      
      public function get avgExperience() : int {
         return this._avgExperience;
      }
      
      public function set avgExperience(param1:int) : void {
         this._avgExperience = param1;
         this.avgExperienceStr = ItemsUtils.formatIntegerStr(param1);
      }
      
      public function get avgExperienceStr() : String {
         return this._avgExperienceStr;
      }
      
      public function set avgExperienceStr(param1:String) : void {
         this._avgExperienceStr = param1;
      }
   }
}
