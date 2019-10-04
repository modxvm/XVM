package net.wg.gui.lobby.vehiclePreview.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewHeader;
    import net.wg.gui.components.tooltips.helpers.TankTypeIco;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.advanced.interfaces.IBackButton;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewHeaderVO;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.vehiclePreview.events.VehPreviewEvent;

    public class VehPreviewHeader extends UIComponentEx implements IVehPreviewHeader
    {

        private static const CLOSE_BTN_OFFSET:int = 15;

        private static const GAP:int = 25;

        private static const INVALIDATE_LAYOUT:String = "invalidateLayout";

        private static const INVALIDATE_DATA:String = "invalidateData";

        public var tankTypeIcon:TankTypeIco;

        public var txtTankInfo:TextField;

        public var background:Sprite;

        public var titleTf:TextField;

        public var premiumIGRBg:Sprite = null;

        private var _closeBtn:ISoundButtonEx;

        private var _backBtn:IBackButton;

        private var _headerData:VehPreviewHeaderVO;

        public function VehPreviewHeader()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this._backBtn.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
            this._closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.background = null;
            this._closeBtn.dispose();
            this._closeBtn = null;
            this._backBtn.dispose();
            this._backBtn = null;
            this.titleTf = null;
            this.tankTypeIcon.dispose();
            this.tankTypeIcon = null;
            this.txtTankInfo = null;
            this.premiumIGRBg = null;
            this._headerData = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabled = false;
            this.background.mouseEnabled = this.background.mouseChildren = false;
            this.txtTankInfo.mouseEnabled = false;
            this.tankTypeIcon.mouseEnabled = false;
            this.titleTf.mouseEnabled = false;
            this._backBtn.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
            this._closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.premiumIGRBg.mouseEnabled = this.premiumIGRBg.mouseChildren = false;
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            super.draw();
            if(this._headerData && isInvalid(INVALIDATE_DATA))
            {
                this.premiumIGRBg.visible = this._headerData.isPremiumIGR;
                this.tankTypeIcon.type = this._headerData.tankType;
                this.txtTankInfo.htmlText = this._headerData.tankInfo;
                this._closeBtn.label = this._headerData.closeBtnLabel;
                this._backBtn.label = this._headerData.backBtnLabel;
                this._backBtn.descrLabel = this._headerData.backBtnDescrLabel;
                this.titleTf.htmlText = this._headerData.titleText;
                this._closeBtn.visible = this._backBtn.visible = this._headerData.showCloseBtn;
                App.utils.commons.updateTextFieldSize(this.titleTf,true,false);
                invalidate(INVALIDATE_LAYOUT);
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                invalidate(INVALIDATE_LAYOUT);
            }
            if(isInvalid(INVALIDATE_LAYOUT))
            {
                _loc1_ = width >> 1;
                this.tankTypeIcon.x = _loc1_;
                this.background.x = width - this.background.width >> 1;
                this.titleTf.x = _loc1_ - this.titleTf.width - GAP;
                this.txtTankInfo.x = _loc1_ + GAP;
                this.premiumIGRBg.x = _loc1_ - (this.premiumIGRBg.width >> 1);
                this._closeBtn.x = width - this._closeBtn.width - CLOSE_BTN_OFFSET | 0;
            }
        }

        public function update(param1:Object) : void
        {
            this._headerData = VehPreviewHeaderVO(param1);
            invalidate(INVALIDATE_DATA);
        }

        public function get backBtn() : IBackButton
        {
            return this._backBtn;
        }

        public function set backBtn(param1:IBackButton) : void
        {
            this._backBtn = param1;
        }

        public function get closeBtn() : ISoundButtonEx
        {
            return this._closeBtn;
        }

        public function set closeBtn(param1:ISoundButtonEx) : void
        {
            this._closeBtn = param1;
        }

        private function onBackBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new VehPreviewEvent(VehPreviewEvent.BACK_CLICK,true));
        }

        private function onCloseBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new VehPreviewEvent(VehPreviewEvent.CLOSE_CLICK,true));
        }
    }
}
