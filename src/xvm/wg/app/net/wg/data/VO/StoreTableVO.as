package net.wg.data.VO
{
   public class StoreTableVO extends Object
   {
      
      public function StoreTableVO() {
         super();
      }
      
      private var _gold:Number = 0;
      
      private var _credits:Number = 0;
      
      public function get gold() : Number {
         return this._gold;
      }
      
      public function set gold(param1:Number) : void {
         this._gold = param1;
      }
      
      public function get credits() : Number {
         return this._credits;
      }
      
      public function set credits(param1:Number) : void {
         this._credits = param1;
      }
   }
}
