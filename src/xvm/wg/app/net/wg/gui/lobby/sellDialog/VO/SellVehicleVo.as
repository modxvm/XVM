package net.wg.gui.lobby.sellDialog.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ActionPriceVO;


   public class SellVehicleVo extends DAAPIDataClass
   {
          
      public function SellVehicleVo(param1:Object) {
         super(param1);
      }

      public var userName:String = "";

      public var icon:String = "";

      public var level:Number = 0;

      public var isElite:Boolean = false;

      public var isPremium:Boolean = false;

      public var type:String = "";

      public var nationID:Number = 0;

      public var sellPrice:Array = null;

      public var action:Object = null;

      public var actionVo:ActionPriceVO = null;

      public var hasCrew:Boolean = false;

      public var intCD:Number = 0;

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         if(param1 == "action")
         {
            this.action = param2;
            if(this.action)
            {
               this.actionVo = new ActionPriceVO(this.action);
            }
            return false;
         }
         return this.hasOwnProperty(param1);
      }
   }

}