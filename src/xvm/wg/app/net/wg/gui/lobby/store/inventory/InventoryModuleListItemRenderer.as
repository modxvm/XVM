package net.wg.gui.lobby.store.inventory
{
    import net.wg.gui.lobby.store.inventory.base.InventoryListItemRenderer;
    import net.wg.gui.components.advanced.ExtraModuleIcon;
    import flash.text.TextField;
    import scaleform.clik.utils.Constraints;
    import net.wg.data.VO.StoreTableData;
    
    public class InventoryModuleListItemRenderer extends InventoryListItemRenderer
    {
        
        public function InventoryModuleListItemRenderer() {
            super();
        }
        
        public var moduleIcon:ExtraModuleIcon = null;
        
        public var vehCount:TextField = null;
        
        public var count:TextField = null;
        
        override protected function configUI() : void {
            super.configUI();
            constraints.addElement(this.moduleIcon.name,this.moduleIcon,Constraints.LEFT);
            constraints.addElement(this.count.name,this.count,Constraints.RIGHT);
        }
        
        override protected function update() : void {
            var _loc1_:StoreTableData = null;
            super.update();
            if(data)
            {
                _loc1_ = StoreTableData(data);
                this.updateModuleIcon(_loc1_);
                getHelper().updateCountFields(this.count,this.vehCount,_loc1_);
            }
            else
            {
                visible = false;
                getHelper().initModuleIconAsDefault(this.moduleIcon);
            }
        }
        
        private function updateModuleIcon(param1:StoreTableData) : void {
            if(this.moduleIcon)
            {
                this.moduleIcon.setValuesWithType(param1.requestType,param1.type,param1.level);
                this.moduleIcon.extraIconSource = param1.extraModuleInfo;
            }
        }
    }
}
