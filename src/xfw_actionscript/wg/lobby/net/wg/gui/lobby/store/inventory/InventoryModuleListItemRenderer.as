package net.wg.gui.lobby.store.inventory
{
    import net.wg.gui.lobby.store.inventory.base.InventoryListItemRenderer;
    import net.wg.gui.components.advanced.ExtraModuleIcon;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.universalBtn.UniversalBtn;
    import flash.display.Stage;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.lobby.store.data.UpgradeModuleVO;
    import scaleform.clik.utils.Constraints;
    import scaleform.gfx.TextFieldEx;
    import net.wg.data.constants.UniversalBtnStylesConst;
    import net.wg.data.VO.StoreTableData;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.gui.events.DeviceEvent;
    import flash.events.MouseEvent;

    public class InventoryModuleListItemRenderer extends InventoryListItemRenderer
    {

        private static const UPGRADE_BUTTON_VGAP:int = 6;

        public var moduleIcon:ExtraModuleIcon = null;

        public var vehCount:TextField = null;

        public var count:TextField = null;

        public var icoBg:Sprite = null;

        public var icoDisabled:Sprite = null;

        public var notForSaleTf:TextField = null;

        public var upgradeButton:UniversalBtn = null;

        private var _constraintsAdded:Boolean = false;

        private var _notForSale:Boolean = false;

        private var _stage:Stage = null;

        private var _tooltipMgr:ITooltipMgr = null;

        private var _upgradeModuleVO:UpgradeModuleVO = null;

        public function InventoryModuleListItemRenderer()
        {
            super();
            this._tooltipMgr = App.toolTipMgr;
            this._stage = App.stage;
        }

        override protected function configUI() : void
        {
            super.configUI();
            constraints.addElement(this.moduleIcon.name,this.moduleIcon,Constraints.LEFT);
            constraints.addElement(this.count.name,this.count,Constraints.RIGHT);
            constraints.addElement(this.icoBg.name,this.icoBg,Constraints.LEFT);
            TextFieldEx.setVerticalAutoSize(this.notForSaleTf,TextFieldEx.VAUTOSIZE_CENTER);
            App.utils.universalBtnStyles.setStyle(this.upgradeButton,UniversalBtnStylesConst.STYLE_SLIM_GREEN);
            this.upgradeButton.focusable = false;
            this.upgradeButton.visible = false;
            this.upgradeButton.x = textField.x;
            this.upgradeButton.y = textField.y + this.upgradeButton.height + UPGRADE_BUTTON_VGAP | 0;
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
                this.upgradeButton.visible = false;
                this._upgradeModuleVO = _loc1_.upgradeModuleVO;
                if(this._upgradeModuleVO && this._upgradeModuleVO.btnVisible)
                {
                    this.upgradeButton.visible = this._upgradeModuleVO.btnVisible;
                    this.upgradeButton.label = this._upgradeModuleVO.btnLabel;
                    this.upgradeButton.tooltip = this._upgradeModuleVO.btnTooltip;
                }
                descField.visible = !this.upgradeButton.visible;
            }
            else
            {
                visible = false;
                getHelper().initModuleIconAsDefault(this.moduleIcon);
            }
        }

        override protected function showTooltip() : void
        {
            if(this.upgradeButton != null && this.upgradeButton.visible && this.upgradeButton.hitTestPoint(this._stage.mouseX,this._stage.mouseY,true))
            {
                this._tooltipMgr.showComplex(this.upgradeButton.tooltip);
            }
            else
            {
                super.showTooltip();
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

        override protected function onDispose() : void
        {
            if(this.moduleIcon != null)
            {
                this.moduleIcon.dispose();
                this.moduleIcon = null;
            }
            this.upgradeButton.dispose();
            this.upgradeButton = null;
            this.notForSaleTf = null;
            this.vehCount = null;
            this.count = null;
            this.icoBg = null;
            this.icoDisabled = null;
            this._tooltipMgr = null;
            this._stage = null;
            this._upgradeModuleVO = null;
            super.onDispose();
        }

        override protected function onLeftButtonClick(param1:Object) : void
        {
            if(this._upgradeModuleVO && param1 == this.upgradeButton)
            {
                dispatchEvent(new DeviceEvent(DeviceEvent.DEVICE_UPGRADE,this._upgradeModuleVO.moduleId));
            }
            else
            {
                super.onLeftButtonClick(param1);
            }
        }

        private function updateModuleIcon(param1:StoreTableData) : void
        {
            if(this.moduleIcon)
            {
                this.moduleIcon.setValuesWithType(param1.requestType,param1.moduleLabel,param1.level);
                this.moduleIcon.extraIconSource = param1.extraModuleInfo;
                this.moduleIcon.setHighlightType(param1.highlightType);
                this.moduleIcon.setOverlayType(param1.overlayType);
            }
        }

        override public function set selected(param1:Boolean) : void
        {
            if(this.upgradeButton == null || !this.upgradeButton.hitTestPoint(this._stage.mouseX,this._stage.mouseY,true))
            {
                super.selected = param1;
            }
        }

        override protected function handleMouseRelease(param1:MouseEvent) : void
        {
            if(param1.target != this.upgradeButton)
            {
                super.handleMouseRelease(param1);
            }
        }

        override protected function handleMousePress(param1:MouseEvent) : void
        {
            if(param1.target != this.upgradeButton)
            {
                hideTooltip();
                super.handleMousePress(param1);
            }
        }
    }
}
