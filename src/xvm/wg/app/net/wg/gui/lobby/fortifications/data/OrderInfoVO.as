package net.wg.gui.lobby.fortifications.data
{
   public class OrderInfoVO extends BuildingPopoverBaseVO
   {
      
      public function OrderInfoVO(param1:Object) {
         super(param1);
      }
      
      public var infoIconSource:String = "";
      
      public var infoIconToolTipData:Object = null;
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var iconSource:String = "";
      
      public var iconLevel:int = -1;
      
      public var ordersCount:int = -1;
      
      public var isPermanent:Boolean = false;
   }
}
