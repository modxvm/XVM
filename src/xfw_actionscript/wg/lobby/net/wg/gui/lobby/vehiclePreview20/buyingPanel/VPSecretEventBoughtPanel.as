package net.wg.gui.lobby.vehiclePreview20.buyingPanel
{
    import net.wg.infrastructure.base.meta.impl.VehiclePreviewSecretEventBoughtPanelMeta;
    import net.wg.infrastructure.base.meta.IVehiclePreviewSecretEventBoughtPanelMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSecretEventBoughtPanelVO;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;

    public class VPSecretEventBoughtPanel extends VehiclePreviewSecretEventBoughtPanelMeta implements IVehiclePreviewSecretEventBoughtPanelMeta, IVPBottomPanel
    {

        public var titleLabel:TextField;

        public var showBtn:SoundButtonEx;

        private var _data:VPSecretEventBoughtPanelVO;

        public function VPSecretEventBoughtPanel()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.titleLabel.autoSize = TextFieldAutoSize.CENTER;
            this.showBtn.addEventListener(ButtonEvent.CLICK,this.onShowButtonClickHandler);
        }

        override protected function setData(param1:VPSecretEventBoughtPanelVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.titleLabel.htmlText = this._data.showButtonHeader;
                VPSecretEventUtils.initButton(this.showBtn,this._data.showButtonLabel,this._data.showButtonEnabled);
            }
        }

        override protected function onDispose() : void
        {
            this.titleLabel = null;
            this._data = null;
            this.showBtn.removeEventListener(ButtonEvent.CLICK,this.onShowButtonClickHandler);
            this.showBtn.dispose();
            this.showBtn = null;
            super.onDispose();
        }

        private function onShowButtonClickHandler(param1:ButtonEvent) : void
        {
            onShowInHangarClickS();
        }

        public function getBtn() : SoundButtonEx
        {
            return this.showBtn;
        }

        public function getTotalHeight() : Number
        {
            return height;
        }
    }
}
