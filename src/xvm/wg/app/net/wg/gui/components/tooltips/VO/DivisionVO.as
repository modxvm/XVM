package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DivisionVO extends DAAPIDataClass
   {
      
      public function DivisionVO(param1:Object) {
         super(param1);
      }
      
      private var _divisName:String = "";
      
      private var _divisLevels:String = "";
      
      private var _divisBonus:String = "";
      
      private var _divisPlayers:String = "";
      
      public function get divisName() : String {
         return this._divisName;
      }
      
      public function set divisName(param1:String) : void {
         this._divisName = param1;
      }
      
      public function get divisLevels() : String {
         return this._divisLevels;
      }
      
      public function set divisLevels(param1:String) : void {
         this._divisLevels = param1;
      }
      
      public function get divisBonus() : String {
         return this._divisBonus;
      }
      
      public function set divisBonus(param1:String) : void {
         this._divisBonus = param1;
      }
      
      public function get divisPlayers() : String {
         return this._divisPlayers;
      }
      
      public function set divisPlayers(param1:String) : void {
         this._divisPlayers = param1;
      }
   }
}
