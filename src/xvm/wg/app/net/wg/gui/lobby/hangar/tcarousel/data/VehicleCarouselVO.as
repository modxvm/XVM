package net.wg.gui.lobby.hangar.tcarousel.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    
    public class VehicleCarouselVO extends DAAPIDataClass
    {
        
        public function VehicleCarouselVO(param1:Object)
        {
            super(param1);
        }
        
        public var id:Number = 0;
        
        public var inventoryId:Number = -1;
        
        public var label:String = "";
        
        public var image:String = "";
        
        public var nation:Number = 0;
        
        public var level:Number = 0;
        
        public var stat:String = "";
        
        public var statStr:String = "";
        
        public var stateLevel:String = "";
        
        public var tankType:String = "";
        
        public var exp:Number = 0;
        
        public var doubleXPReceived:Number = 0;
        
        public var compactDescr:Number = 0;
        
        public var favorite:Boolean = false;
        
        public var canSell:Boolean = false;
        
        public var elite:Boolean = false;
        
        public var premium:Boolean = false;
        
        public var clanLock:Number = -1;
        
        public var current:Number = 0;
        
        public var enabled:Boolean = false;
        
        public var rentLeft:String = "";
        
        public var empty:Boolean = false;
        
        public var buyTank:Boolean = false;
        
        public var buySlot:Boolean = false;
        
        public var slotPriceActionData:ActionPriceVO = null;
        
        public var slotPrice:Number = 0;
        
        public var availableSlots:Number = 0;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == "slotPriceActionData" && (param2))
            {
                this.slotPriceActionData = new ActionPriceVO(param2);
                return false;
            }
            return true;
        }
    }
}
