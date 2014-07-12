package net.wg.data.VO
{
   import net.wg.infrastructure.interfaces.IWalletStatusVO;
   
   public class WalletStatusVO extends Object implements IWalletStatusVO
   {
      
      public function WalletStatusVO() {
         super();
      }
      
      private var _goldStatus:uint;
      
      private var _freeXpStatus:uint;
      
      public function dispose() : void {
      }
      
      public function set goldStatus(param1:uint) : void {
         this._goldStatus = param1;
      }
      
      public function get goldStatus() : uint {
         return this._goldStatus;
      }
      
      public function set freeXpStatus(param1:uint) : void {
         this._freeXpStatus = param1;
      }
      
      public function get freeXpStatus() : uint {
         return this._freeXpStatus;
      }
      
      public function update(param1:Object) : void {
         if(param1 != null)
         {
            if(param1.hasOwnProperty("gold"))
            {
               this.goldStatus = param1.gold;
            }
            if(param1.hasOwnProperty("freeXP"))
            {
               this.freeXpStatus = param1.freeXP;
            }
         }
         else
         {
            this.goldStatus = 1;
            this.freeXpStatus = 1;
         }
      }
   }
}
