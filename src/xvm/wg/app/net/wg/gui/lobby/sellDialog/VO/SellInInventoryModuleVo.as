package net.wg.gui.lobby.sellDialog.VO
{
    public class SellInInventoryModuleVo extends SellVehicleItemBaseVo
    {
        
        public function SellInInventoryModuleVo(param1:Object)
        {
            super(param1);
        }
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == "inventoryCount")
            {
                count = Number(param2);
                return false;
            }
            return this.hasOwnProperty(param1);
        }
    }
}
