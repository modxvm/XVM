package net.wg.gui.lobby.vehiclePreview20.buyingPanel
{
    import net.wg.infrastructure.base.meta.impl.VehiclePreviewSecretEventSoldPanelMeta;
    import net.wg.infrastructure.base.meta.IVehiclePreviewSecretEventSoldPanelMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSecretEventSoldPanelVO;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;

    public class VPSecretEventSoldPanel extends VehiclePreviewSecretEventSoldPanelMeta implements IVehiclePreviewSecretEventSoldPanelMeta, IVPBottomPanel
    {

        private static const FROM_TEXT_TO_BUTTON:int = 20;

        public var titleLabel:TextField;

        public var costLabel:TextField;

        public var restoreBtn:SoundButtonEx;

        private var _toolTipMgr:ITooltipMgr;

        private var _data:VPSecretEventSoldPanelVO;

        public function VPSecretEventSoldPanel()
        {
            this._toolTipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.titleLabel.autoSize = TextFieldAutoSize.CENTER;
            this.costLabel.autoSize = TextFieldAutoSize.RIGHT;
            this.restoreBtn.mouseEnabledOnDisabled = true;
            this.restoreBtn.addEventListener(ButtonEvent.CLICK,this.onRestoreButtonClickHandler);
            this.restoreBtn.addEventListener(MouseEvent.ROLL_OVER,this.onRestoreButtonRollOverHandler);
            this.restoreBtn.addEventListener(MouseEvent.ROLL_OUT,this.onRestoreButtonRollOutHandler);
        }

        override protected function setData(param1:VPSecretEventSoldPanelVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.titleLabel.htmlText = this._data.restoreButtonHeader;
                this.costLabel.htmlText = this._data.restoreCostLabel;
                VPSecretEventUtils.initButton(this.restoreBtn,this._data.restoreButtonLabel,this._data.restoreButtonEnabled);
                this.costLabel.x = this.restoreBtn.x - FROM_TEXT_TO_BUTTON - this.costLabel.width;
            }
        }

        override protected function onDispose() : void
        {
            this.titleLabel = null;
            this.costLabel = null;
            this._data = null;
            this.restoreBtn.removeEventListener(ButtonEvent.CLICK,this.onRestoreButtonClickHandler);
            this.restoreBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onRestoreButtonRollOverHandler);
            this.restoreBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onRestoreButtonRollOutHandler);
            this.restoreBtn.dispose();
            this.restoreBtn = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        public function getBtn() : SoundButtonEx
        {
            return this.restoreBtn;
        }

        public function getTotalHeight() : Number
        {
            return height;
        }

        private function onRestoreButtonClickHandler(param1:ButtonEvent) : void
        {
            onRestoreClick();
        }

        private function onRestoreButtonRollOverHandler(param1:MouseEvent) : void
        {
            if(this._data == null || StringUtils.isEmpty(this._data.buttonTooltip))
            {
                return;
            }
            if(this._data.isShowSpecialTooltip)
            {
                this._toolTipMgr.showSpecial(this._data.buttonTooltip,null);
            }
            else
            {
                this._toolTipMgr.showComplex(this._data.buttonTooltip);
            }
        }

        private function onRestoreButtonRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
