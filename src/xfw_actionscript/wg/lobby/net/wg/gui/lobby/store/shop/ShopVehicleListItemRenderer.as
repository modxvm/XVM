package net.wg.gui.lobby.store.shop
{
    import net.wg.gui.lobby.store.shop.base.ShopTableItemRenderer;
    import net.wg.gui.components.advanced.TankIcon;
    import flash.text.TextField;
    import net.wg.gui.components.controls.AlertIco;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.utils.Constraints;
    import net.wg.data.VO.StoreTableData;
    import org.idmedia.as3commons.util.StringUtils;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
    import net.wg.gui.lobby.store.StoreEvent;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class ShopVehicleListItemRenderer extends ShopTableItemRenderer
    {

        private static const TRADE_IN_DISABLED_ALPHA:Number = 0.4;

        private static const RESTORE_INFO_TF_ORIGINAL_X:int = 161;

        private static const RESTORE_INFO_TF_ORIGINAL_WIDTH:int = 369;

        private static const RENT_OFFSET:int = 10;

        public var vehicleIcon:TankIcon = null;

        public var warnMessageTf:TextField = null;

        public var restoreInfoTf:TextField = null;

        public var tradeInPrice:TextField = null;

        public var tradeInAlert:AlertIco = null;

        public var tradeIcon:ShopIconText = null;

        public function ShopVehicleListItemRenderer()
        {
            super();
        }

        override protected function getVehicleIconWidth() : int
        {
            return this.vehicleIcon.width;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.warnMessageTf.autoSize = TextFieldAutoSize.RIGHT;
            mouseChildren = true;
            this.tradeIcon.visible = false;
            this.tradeIcon.mouseEnabled = true;
            this.tradeIcon.updateText(MENU.TRADE_IN);
            this.tradeInPrice.mouseEnabled = false;
            this.tradeInPrice.visible = false;
            this.tradeInAlert.visible = false;
            constraints.addElement(this.vehicleIcon.name,this.vehicleIcon,Constraints.ALL);
            constraints.addElement(this.restoreInfoTf.name,this.restoreInfoTf,Constraints.ALL);
        }

        override protected function onDispose() : void
        {
            this.warnMessageTf = null;
            this.restoreInfoTf = null;
            this.vehicleIcon.dispose();
            this.vehicleIcon = null;
            this.tradeInAlert.dispose();
            this.tradeInAlert = null;
            this.tradeInPrice = null;
            this.tradeIcon.dispose();
            this.tradeIcon = null;
            super.onDispose();
        }

        override protected function update() : void
        {
            var _loc1_:StoreTableData = null;
            super.update();
            if(data)
            {
                _loc1_ = StoreTableData(data);
                this.warnMessageTf.visible = StringUtils.isNotEmpty(_loc1_.warnMessage);
                if(this.warnMessageTf.visible)
                {
                    this.warnMessageTf.text = _loc1_.warnMessage;
                }
                this.restoreInfoTf.visible = StringUtils.isNotEmpty(_loc1_.restoreInfo);
                if(this.restoreInfoTf.visible)
                {
                    this.restoreInfoTf.htmlText = _loc1_.restoreInfo;
                    this.restoreInfoTf.y = descField.y + descField.textHeight ^ 0;
                }
                this.updateVehicleIcon(_loc1_);
                this.updateTradeIn(_loc1_);
            }
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.restoreInfoTf.x = RESTORE_INFO_TF_ORIGINAL_X / scaleX;
                this.restoreInfoTf.scaleX = 1 / scaleX;
                this.restoreInfoTf.width = RESTORE_INFO_TF_ORIGINAL_WIDTH;
            }
        }

        override protected function onRightButtonClick() : void
        {
            var _loc1_:StoreTableData = StoreTableData(data);
            if(_loc1_.isInTradeIn && _loc1_.canTradeIn)
            {
                App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.STORE_VEHICLE,this,{"id":StoreTableData(data).id});
            }
            else if(compareModeOn)
            {
                App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.STORE_VEHICLE,this,{"id":StoreTableData(data).id});
            }
            else
            {
                infoItem();
            }
        }

        override protected function showTooltip() : void
        {
            if(this.tradeIcon.visible && this.tradeIcon.hitTestPoint(App.stage.mouseX,App.stage.mouseY,true))
            {
                this.showTradeInTooltip();
            }
            else if(this.tradeInAlert.visible && this.tradeInAlert.hitTestPoint(App.stage.mouseX,App.stage.mouseY,true))
            {
                this.showTradeInNoDiscountTooltip();
            }
            else
            {
                super.showTooltip();
            }
        }

        override protected function buyItem() : void
        {
            var _loc1_:StoreTableData = StoreTableData(data);
            if(_loc1_.isInTradeIn && _loc1_.canTradeIn)
            {
                dispatchEvent(new StoreEvent(StoreEvent.BUY_WITH_TRADE_IN,StoreTableData(data).id));
            }
            else
            {
                super.buyItem();
            }
        }

        private function updateTradeIn(param1:StoreTableData) : void
        {
            this.tradeIcon.visible = param1.canTradeIn;
            this.tradeIcon.y = descField.y + descField.textHeight ^ 0;
            this.tradeIcon.buttonMode = enabled;
            this.tradeIcon.alpha = enabled?1:TRADE_IN_DISABLED_ALPHA;
            if(this.tradeIcon.visible)
            {
                rent.y = this.tradeIcon.y + this.tradeIcon.height - RENT_OFFSET;
            }
            if(StringUtils.isNotEmpty(param1.tradeInPrice))
            {
                this.tradeInPrice.visible = true;
                this.tradeInPrice.htmlText = param1.tradeInPrice;
                this.tradeInAlert.visible = false;
            }
            else
            {
                this.tradeInPrice.visible = false;
                this.tradeInAlert.visible = param1.isInTradeIn;
            }
        }

        private function updateVehicleIcon(param1:StoreTableData) : void
        {
            getHelper().initVehicleIcon(this.vehicleIcon,param1);
        }

        private function showTradeInTooltip() : void
        {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TRADE_IN,null,int(StoreTableData(data).id));
        }

        private function showTradeInNoDiscountTooltip() : void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.TRADEIN_NODISCOUNT);
        }
    }
}
