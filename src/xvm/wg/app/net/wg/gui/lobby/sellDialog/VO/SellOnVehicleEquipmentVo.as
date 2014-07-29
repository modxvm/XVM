package net.wg.gui.lobby.sellDialog.VO
{
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    
    public class SellOnVehicleEquipmentVo extends SellVehicleItemBaseVo
    {
        
        public function SellOnVehicleEquipmentVo(param1:Object)
        {
            super(param1);
        }
        
        public var userName:String = "";
        
        public var action:Object = null;
        
        public var actionVo:ActionPriceVO = null;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
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
