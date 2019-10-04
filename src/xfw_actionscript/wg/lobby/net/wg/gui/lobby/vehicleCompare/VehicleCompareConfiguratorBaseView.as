package net.wg.gui.lobby.vehicleCompare
{
    import net.wg.infrastructure.base.meta.impl.VehicleCompareConfiguratorBaseViewMeta;
    import net.wg.infrastructure.base.meta.IVehicleCompareConfiguratorBaseViewMeta;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import flash.text.TextField;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.lobby.vehicleCompare.configurator.VehConfBottomPanel;
    import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareConfiguratorInitDataVO;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehConfEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.InteractiveObject;

    public class VehicleCompareConfiguratorBaseView extends VehicleCompareConfiguratorBaseViewMeta implements IVehicleCompareConfiguratorBaseViewMeta, IViewStackContent
    {

        private static const INV_INIT_DATA:String = "InvInitData";

        private static const CLOSE_BTN_BORDER_OFFSET:int = 20;

        public var titleTf:TextField;

        public var closeBtn:ISoundButtonEx;

        public var bottomPanel:VehConfBottomPanel;

        private var _initData:VehicleCompareConfiguratorInitDataVO;

        public function VehicleCompareConfiguratorBaseView()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.titleTf.autoSize = TextFieldAutoSize.CENTER;
            this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.closeBtn.label = VEH_COMPARE.HEADER_CLOSEBTN_LABEL;
            this.bottomPanel.addEventListener(VehConfEvent.CLOSE_CLICK,this.onBottomPanelCloseClickHandler);
            this.bottomPanel.addEventListener(VehConfEvent.RESET_CLICK,this.onBottomPanelResetClickHandler);
            this.bottomPanel.addEventListener(VehConfEvent.APPLY_CLICK,this.onBottomPanelApplyClickHandler);
        }

        override protected function onDispose() : void
        {
            this.bottomPanel.removeEventListener(VehConfEvent.CLOSE_CLICK,this.onBottomPanelCloseClickHandler);
            this.bottomPanel.removeEventListener(VehConfEvent.RESET_CLICK,this.onBottomPanelResetClickHandler);
            this.bottomPanel.removeEventListener(VehConfEvent.APPLY_CLICK,this.onBottomPanelApplyClickHandler);
            this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.closeBtn.dispose();
            this.closeBtn = null;
            this.bottomPanel.dispose();
            this.bottomPanel = null;
            this.titleTf = null;
            this._initData = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._initData && isInvalid(INV_INIT_DATA))
            {
                this.titleTf.htmlText = this._initData.title;
                this.bottomPanel.setTexts(this._initData.resetBtnLabel,this._initData.resetBtnTooltip,this._initData.cancelBtnLabel,this._initData.cancelBtnTooltip,this._initData.applyBtnLabel,this._initData.applyBtnTooltip);
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateLayout();
            }
        }

        override protected function setInitData(param1:VehicleCompareConfiguratorInitDataVO) : void
        {
            this._initData = param1;
            invalidate(INV_INIT_DATA);
        }

        override protected function getVehicleCompareConfiguratorInitDataVOForData(param1:Object) : VehicleCompareConfiguratorInitDataVO
        {
            return new VehicleCompareConfiguratorInitDataVO(param1);
        }

        public function as_setApplyEnabled(param1:Boolean) : void
        {
            this.bottomPanel.setApplyEnabled(param1);
        }

        public function as_setResetEnabled(param1:Boolean) : void
        {
            this.bottomPanel.setResetEnabled(param1);
        }

        public function canShowAutomatically() : Boolean
        {
            return true;
        }

        public function getComponentForFocus() : InteractiveObject
        {
            return this;
        }

        public function update(param1:Object) : void
        {
        }

        protected function updateLayout() : void
        {
            this.closeBtn.x = width - this.closeBtn.width - CLOSE_BTN_BORDER_OFFSET;
            this.titleTf.x = width - this.titleTf.width >> 1;
        }

        private function onBottomPanelApplyClickHandler(param1:VehConfEvent) : void
        {
            applyConfigS();
        }

        private function onBottomPanelResetClickHandler(param1:VehConfEvent) : void
        {
            resetConfigS();
        }

        private function onBottomPanelCloseClickHandler(param1:VehConfEvent) : void
        {
            onCloseViewS();
        }

        private function onCloseBtnClickHandler(param1:ButtonEvent) : void
        {
            onCloseViewS();
        }
    }
}
