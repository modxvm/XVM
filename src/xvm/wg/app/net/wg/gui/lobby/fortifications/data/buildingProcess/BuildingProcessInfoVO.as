package net.wg.gui.lobby.fortifications.data.buildingProcess
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.fortifications.data.OrderInfoVO;


   public class BuildingProcessInfoVO extends DAAPIDataClass
   {
          
      public function BuildingProcessInfoVO(param1:Object) {
         super(param1);
      }

      private static const ORDER_INFO:String = "orderInfo";

      public var orderInfo:OrderInfoVO = null;

      public var buildingName:String = "";

      public var buildingID:String = "";

      public var longDescr:String = "";

      public var buttonLabel:String = "";

      public var statusMsg:String = "";

      public var isVisibleBtn:Boolean = false;

      public var isEnableBtn:Boolean = false;

      public var buttonTooltip:Object = null;

      public var statusIconTooltip:String = "";

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         if(param1 == ORDER_INFO)
         {
            this.orderInfo = new OrderInfoVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }

      override protected function onDispose() : void {
         if(this.orderInfo)
         {
            this.orderInfo.dispose();
            this.orderInfo = null;
         }
         this.buildingName = null;
         this.buildingID = null;
         this.longDescr = null;
         this.buttonLabel = null;
         this.statusMsg = null;
         this.buttonTooltip = null;
         this.statusIconTooltip = null;
         super.onDispose();
      }
   }

}