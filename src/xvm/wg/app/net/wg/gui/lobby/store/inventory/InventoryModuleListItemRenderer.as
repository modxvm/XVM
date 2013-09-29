package net.wg.gui.lobby.store.inventory 
{
    import flash.text.*;
    import net.wg.data.VO.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.lobby.store.inventory.base.*;
    import scaleform.clik.utils.*;
    
    public class InventoryModuleListItemRenderer extends net.wg.gui.lobby.store.inventory.base.InventoryListItemRenderer
    {
        public function InventoryModuleListItemRenderer()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints.addElement(this.moduleIcon.name, this.moduleIcon, scaleform.clik.utils.Constraints.LEFT);
            constraints.addElement(this.count.name, this.count, scaleform.clik.utils.Constraints.RIGHT);
            return;
        }

        protected override function update():void
        {
            var loc1:*=null;
            super.update();
            if (data) 
            {
                loc1 = net.wg.data.VO.StoreTableData(data);
                this.updateModuleIcon(loc1);
                getHelper().updateCountFields(this.count, this.vehCount, loc1);
            }
            else 
            {
                visible = false;
                getHelper().initModuleIconAsDefault(this.moduleIcon);
            }
            return;
        }

        internal function updateModuleIcon(arg1:net.wg.data.VO.StoreTableData):void
        {
            if (this.moduleIcon) 
            {
                this.moduleIcon.setValuesWithType(arg1.requestType, arg1.type, arg1.level);
                this.moduleIcon.extraIconSource = arg1.extraModuleInfo;
            }
            return;
        }

        public var moduleIcon:net.wg.gui.components.advanced.ExtraModuleIcon=null;

        public var vehCount:flash.text.TextField=null;

        public var count:flash.text.TextField=null;
    }
}
