package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.fortifications.data.OrderVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class OrdersPanelMeta extends BaseDAAPIComponent
   {
      
      public function OrdersPanelMeta() {
         super();
      }
      
      public var getOrderTooltipBody:Function = null;
      
      public function getOrderTooltipBodyS(param1:String) : String {
         App.utils.asserter.assertNotNull(this.getOrderTooltipBody,"getOrderTooltipBody" + Errors.CANT_NULL);
         return this.getOrderTooltipBody(param1);
      }
      
      public function as_updateOrder(param1:Object) : void {
         var _loc2_:OrderVO = new OrderVO(param1);
         this.updateOrder(_loc2_);
      }
      
      protected function updateOrder(param1:OrderVO) : void {
         var _loc2_:String = "as_updateOrder" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
