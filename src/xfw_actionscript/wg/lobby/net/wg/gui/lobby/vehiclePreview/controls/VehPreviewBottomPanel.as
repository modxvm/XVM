package net.wg.gui.lobby.vehiclePreview.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewBottomPanel;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.TradeIco;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewBuyingPanel;
    import net.wg.gui.lobby.modulesPanel.interfaces.IModulesPanel;
    import net.wg.utils.ICommons;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewBottomPanelVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Values;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewBuyingPanelDataVO;

    public class VehPreviewBottomPanel extends UIComponentEx implements IVehPreviewBottomPanel
    {

        private static const RULERS_GAP:int = 15;

        private static const TRADE_LEFT_GAP:int = 11;

        private static const TRADE_TOP_GAP:int = -1;

        private static const MODULES_RIGHT_PADDING:int = -30;

        private static const INVALIDATE_LAYOUT:String = "invalidateLayout";

        private static const INVALIDATE_DATA:String = "invalidateData";

        public var statusInfoTf:TextField;

        public var background:Sprite;

        public var messengerBg:Sprite;

        public var tradeLabelTf:TextField;

        public var tradeIcon:TradeIco = null;

        private var _buyingPanel:IVehPreviewBuyingPanel;

        private var _modules:IModulesPanel;

        private var _commons:ICommons;

        private var _showStatusInfoTooltip:Boolean = false;

        private var _panelData:VehPreviewBottomPanelVO;

        private var _toolTipMgr:ITooltipMgr;

        public function VehPreviewBottomPanel()
        {
            this._commons = App.utils.commons;
            this._toolTipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabled = false;
            this.background.mouseEnabled = this.background.mouseChildren = false;
            this._buyingPanel.addEventListener(Event.RESIZE,this.onBuyingPanelResizeHandler);
            this.statusInfoTf.addEventListener(MouseEvent.ROLL_OVER,this.onStatusInfoTfRollOverHandler);
            this.statusInfoTf.addEventListener(MouseEvent.ROLL_OUT,this.onStatusInfoTfRollOutHandler);
        }

        override protected function onBeforeDispose() : void
        {
            this._buyingPanel.removeEventListener(Event.RESIZE,this.onBuyingPanelResizeHandler);
            this.statusInfoTf.removeEventListener(MouseEvent.ROLL_OVER,this.onStatusInfoTfRollOverHandler);
            this.statusInfoTf.removeEventListener(MouseEvent.ROLL_OUT,this.onStatusInfoTfRollOutHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this._modules = null;
            this._buyingPanel.dispose();
            this._buyingPanel = null;
            this.tradeLabelTf = null;
            this.background = null;
            this.messengerBg = null;
            this.statusInfoTf = null;
            this._panelData = null;
            this._commons = null;
            this.tradeIcon.dispose();
            this.tradeIcon = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            super.draw();
            if(this._panelData && isInvalid(INVALIDATE_DATA))
            {
                if(this._panelData.isCanTrade && this._panelData.vehicleId != Values.DEFAULT_INT)
                {
                    this.tradeLabelTf.visible = false;
                    this.tradeIcon.visible = true;
                    this.tradeIcon.setData(this._panelData.vehicleId,this._panelData.buyingLabel);
                }
                else
                {
                    this.tradeIcon.visible = false;
                    this.tradeLabelTf.htmlText = this._panelData.buyingLabel;
                    this.tradeLabelTf.visible = true;
                }
                this._showStatusInfoTooltip = this._panelData.showStatusInfoTooltip;
                this._buyingPanel.update(this._panelData.vehCompareVO,this._panelData.vehCompareIcon,this._panelData.isBuyingAvailable);
                invalidate(INVALIDATE_LAYOUT);
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.messengerBg.width = width;
                invalidate(INVALIDATE_LAYOUT);
            }
            if(isInvalid(INVALIDATE_LAYOUT))
            {
                this.background.x = width - this.background.width >> 1;
                _loc1_ = width >> 1;
                _loc2_ = _loc1_ + RULERS_GAP;
                this._commons.updateTextFieldSize(this.tradeLabelTf,true,false);
                this._buyingPanel.x = _loc2_;
                this.tradeLabelTf.x = _loc2_;
                this.tradeIcon.x = this.tradeLabelTf.x + TRADE_LEFT_GAP + this._buyingPanel.buyBtn.x;
                this.tradeIcon.y = this.tradeLabelTf.y + (this.tradeLabelTf.height >> 1) + TRADE_TOP_GAP;
                this._modules.x = _loc1_ - this._modules.width + MODULES_RIGHT_PADDING | 0;
                this.statusInfoTf.x = this._modules.x;
            }
        }

        public function update(param1:Object) : void
        {
            this._panelData = VehPreviewBottomPanelVO(param1);
            invalidate(INVALIDATE_DATA);
        }

        public function updateBuyingPanel(param1:VehPreviewBuyingPanelDataVO) : void
        {
            this._buyingPanel.updateData(param1);
            invalidate(INVALIDATE_LAYOUT);
        }

        public function updateVehicleStatus(param1:String) : void
        {
            this.statusInfoTf.htmlText = param1;
            this._commons.updateTextFieldSize(this.statusInfoTf);
        }

        public function get buyingPanel() : IVehPreviewBuyingPanel
        {
            return this._buyingPanel;
        }

        public function set buyingPanel(param1:IVehPreviewBuyingPanel) : void
        {
            this._buyingPanel = param1;
        }

        public function get modules() : IModulesPanel
        {
            return this._modules;
        }

        public function set modules(param1:IModulesPanel) : void
        {
            this._modules = param1;
        }

        private function onStatusInfoTfRollOverHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.showComplex(this._showStatusInfoTooltip?TOOLTIPS.VEHICLEPREVIEW_MODULS:TOOLTIPS.VEHICLEPREVIEW_MODULSNOMODULES);
        }

        private function onStatusInfoTfRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onBuyingPanelResizeHandler(param1:Event) : void
        {
            invalidate(INVALIDATE_LAYOUT);
        }
    }
}
