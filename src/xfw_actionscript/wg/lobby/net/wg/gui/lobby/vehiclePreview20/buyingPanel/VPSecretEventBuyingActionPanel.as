package net.wg.gui.lobby.vehiclePreview20.buyingPanel
{
    import net.wg.infrastructure.base.meta.impl.VehiclePreviewSecretEventBuyingActionPanelMeta;
    import net.wg.infrastructure.base.meta.IVehiclePreviewSecretEventBuyingActionPanelMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSecretEventBuyingActionPanelVO;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;

    public class VPSecretEventBuyingActionPanel extends VehiclePreviewSecretEventBuyingActionPanelMeta implements IVehiclePreviewSecretEventBuyingActionPanelMeta, IVPBottomPanel
    {

        public var txtOr:TextField;

        public var actionBtn:SoundButtonEx;

        private var _data:VPSecretEventBuyingActionPanelVO;

        public function VPSecretEventBuyingActionPanel()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.actionBtn.mouseEnabledOnDisabled = true;
            this.actionBtn.addEventListener(ButtonEvent.CLICK,this.onActionButtonClickHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.txtOr.htmlText = this._data.orLabel;
                VPSecretEventUtils.initButton(this.actionBtn,this._data.actionButtonLabel,this._data.actionButtonEnabled);
            }
        }

        override protected function onDispose() : void
        {
            this._data = null;
            this.txtOr = null;
            this.actionBtn.removeEventListener(ButtonEvent.CLICK,this.onActionButtonClickHandler);
            this.actionBtn.dispose();
            this.actionBtn = null;
            super.onDispose();
        }

        override protected function setActionData(param1:VPSecretEventBuyingActionPanelVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        private function onActionButtonClickHandler(param1:ButtonEvent) : void
        {
            onActionClickS();
        }
    }
}
