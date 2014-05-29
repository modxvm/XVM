package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class SortieDivisionVO extends DAAPIDataClass
   {
          
      public function SortieDivisionVO(param1:Object) {
         super(param1);
      }

      private var _middleDivisLevels:String = "";

      private var _middleDivisBonus:String = "";

      private var _champDivisLevels:String = "";

      private var _champDivisBonus:String = "";

      private var _absoluteDivisLevels:String = "";

      private var _absoluteDivisBonus:String = "";

      public function get middleDivisLevels() : String {
         return this._middleDivisLevels;
      }

      public function set middleDivisLevels(param1:String) : void {
         this._middleDivisLevels = param1;
      }

      public function get middleDivisBonus() : String {
         return this._middleDivisBonus;
      }

      public function set middleDivisBonus(param1:String) : void {
         this._middleDivisBonus = param1;
      }

      public function get champDivisLevels() : String {
         return this._champDivisLevels;
      }

      public function set champDivisLevels(param1:String) : void {
         this._champDivisLevels = param1;
      }

      public function get champDivisBonus() : String {
         return this._champDivisBonus;
      }

      public function set champDivisBonus(param1:String) : void {
         this._champDivisBonus = param1;
      }

      public function get absoluteDivisLevels() : String {
         return this._absoluteDivisLevels;
      }

      public function set absoluteDivisLevels(param1:String) : void {
         this._absoluteDivisLevels = param1;
      }

      public function get absoluteDivisBonus() : String {
         return this._absoluteDivisBonus;
      }

      public function set absoluteDivisBonus(param1:String) : void {
         this._absoluteDivisBonus = param1;
      }
   }

}