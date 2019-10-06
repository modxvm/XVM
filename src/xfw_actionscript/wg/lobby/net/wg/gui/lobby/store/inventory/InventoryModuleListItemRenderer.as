package net.wg.gui.lobby.store.inventory
{
    import net.wg.gui.lobby.store.inventory.base.InventoryListItemRenderer;
    import net.wg.gui.components.advanced.ExtraModuleIcon;
    import flash.text.TextField;
    import flash.display.Sprite;
    import scaleform.clik.utils.Constraints;
    import scaleform.gfx.TextFieldEx;
    import net.wg.data.VO.StoreTableData;
    import org.idmedia.as3commons.util.StringUtils;

    public class InventoryModuleListItemRenderer extends InventoryListItemRenderer
    {

        public var moduleIcon:ExtraModuleIcon = null;

        public var vehCount:TextField = null;

        public var count:TextField = null;

        public var icoBg:Sprite = null;

        public var icoDisabled:Sprite = null;

        public var notForSaleTf:TextField = null;

        private var _constraintsAdded:Boolean = false;

        private var _notForSale:Boolean = false;

        public function InventoryModuleListItemRenderer()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this.moduleIcon != null)
            {
                this.moduleIcon.dispose();
                this.moduleIcon = null;
            }
            this.notForSaleTf = null;
            this.vehCount = null;
            this.count = null;
            this.icoBg = null;
            this.icoDisabled = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            constraints.addElement(this.moduleIcon.name,this.moduleIcon,Constraints.LEFT);
            constraints.addElement(this.count.name,this.count,Constraints.RIGHT);
            constraints.addElement(this.icoBg.name,this.icoBg,Constraints.LEFT);
            TextFieldEx.setVerticalAutoSize(this.notForSaleTf,TextFieldEx.VAUTOSIZE_CENTER);
        }

        override protected function update() : void
        {
            var _loc1_:StoreTableData = null;
            var _loc2_:String = null;
            super.update();
            if(data)
            {
                _loc1_ = StoreTableData(data);
                this.updateModuleIcon(_loc1_);
                getHelper().updateCountFields(this.count,this.vehCount,_loc1_);
                _loc2_ = _loc1_.notForSaleText;
                this._notForSale = StringUtils.isNotEmpty(_loc2_);
                if(this._notForSale)
                {
                    this.notForSaleTf.text = _loc2_;
                }
                this.notForSaleTf.visible = this._notForSale;
                credits.visible = !this._notForSale;
            }
            else
            {
                visible = false;
                getHelper().initModuleIconAsDefault(this.moduleIcon);
            }
        }

        override protected function changedState() : void
        {
            super.changedState();
            if(this.icoDisabled != null && this._constraintsAdded)
            {
                constraints.addElement(this.icoDisabled.name,this.icoDisabled,Constraints.LEFT);
                this._constraintsAdded = true;
            }
        }

        private function updateModuleIcon(param1:StoreTableData) : void
        {
            var _loc2_:String = null;
            if(this.moduleIcon)
            {
                this.moduleIcon.setValuesWithType(param1.requestType,param1.moduleLabel,param1.level);
                this.moduleIcon.extraIconSource = param1.extraModuleInfo;
                _loc2_ = param1.highlightType;
                this.moduleIcon.setHighlightType(_loc2_);
                this.moduleIcon.setOverlayType(_loc2_);
            }
        }
    }
}
