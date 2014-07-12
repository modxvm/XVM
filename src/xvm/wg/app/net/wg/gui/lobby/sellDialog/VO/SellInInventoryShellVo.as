package net.wg.gui.lobby.sellDialog.VO
{
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   
   public class SellInInventoryShellVo extends SellVehicleItemBaseVo
   {
      
      public function SellInInventoryShellVo(param1:Object) {
         super(param1);
      }
      
      public var userName:String = "";
      
      public var action:Object = null;
      
      public var actionVo:ActionPriceVO = null;
      
      public var kind:String = "";
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         if(param1 == "action")
         {
            this.action = param2;
            if(this.action)
            {
               this.actionVo = new ActionPriceVO(this.action);
               this.updateActionPrice();
            }
            return false;
         }
         if(param1 == "count" || param1 == "inventoryCount")
         {
            count = Number(param2);
            this.updateActionPrice();
            return false;
         }
         return this.hasOwnProperty(param1);
      }
      
      private function updateActionPrice() : void {
         if(this.actionVo)
         {
            this.actionVo.newPrices = [this.actionVo.newPriceBases[0] * count,this.actionVo.newPriceBases[1] * count];
            this.actionVo.oldPrices = [this.actionVo.oldPriceBases[0] * count,this.actionVo.oldPriceBases[1] * count];
         }
      }
   }
}
