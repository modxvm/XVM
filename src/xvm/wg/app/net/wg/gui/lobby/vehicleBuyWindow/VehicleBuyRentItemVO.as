package net.wg.gui.lobby.vehicleBuyWindow
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.utils.VO.PriceVO;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    
    public class VehicleBuyRentItemVO extends DAAPIDataClass
    {
        
        public function VehicleBuyRentItemVO(param1:Object)
        {
            super(param1);
        }
        
        public static var DEF_ITEM_ID:int = -1;
        
        public var label:String = "";
        
        public var itemId:int = -1;
        
        public var price:PriceVO = null;
        
        public var actionPriceDataVo:ActionPriceVO = null;
        
        public var enabled:Boolean = true;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == "actionPrice")
            {
                this.actionPriceDataVo = param2?new ActionPriceVO(param2):null;
                return false;
            }
            if(param1 == "price")
            {
                this.price = new PriceVO(param2 as Array);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
    }
}
