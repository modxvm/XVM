package net.wg.gui.lobby.eventItemsTradeCongratulation
{
    import net.wg.infrastructure.base.meta.impl.EventItemsTradeCongratulationMeta;
    import net.wg.infrastructure.base.meta.IEventItemsTradeCongratulationMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.Sprite;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.lobby.eventItemsTradeCongratulation.data.EventItemsTradeCongratulationVO;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;

    public class EventItemsTradeCongratulation extends EventItemsTradeCongratulationMeta implements IEventItemsTradeCongratulationMeta
    {

        private static const HEIGHT_MIN:int = 880;

        private static const CLOSE_BTN_OFFSET:int = 10;

        private static const ITEM_WIDTH:int = 478;

        private static const MULTIPLIER_OFFSET:int = 313;

        private static const SHADOW_OFFSET:int = 283;

        private static const HEADER_Y:int = 175;

        private static const HEADER_Y_MIN:int = 90;

        private static const TITLE_Y:int = 255;

        private static const TITLE_Y_MIN:int = 170;

        private static const DESCRIPTION_Y:int = 745;

        private static const ITEM_Y:int = 320;

        private static const ITEM_Y_MIN:int = 190;

        private static const SIGN_Y:int = 360;

        private static const SIGN_Y_MIN:int = 230;

        private static const MULTIPLIER_Y:int = 560;

        private static const MULTIPLIER_Y_MIN:int = 430;

        private static const SHADOW_Y:int = 535;

        private static const SHADOW_Y_MIN:int = 405;

        private static const LIP_Y:int = 700;

        private static const CONFIRMATION_BTN_Y:int = 825;

        public var headerTF:TextField = null;

        public var titleTF:TextField = null;

        public var descriptionTF:TextField = null;

        public var item:UILoaderAlt = null;

        public var sign:UILoaderAlt = null;

        public var multiplierTF:TextField = null;

        public var shadow:Sprite = null;

        public var lip:Sprite = null;

        public var confirmationBtn:ISoundButtonEx = null;

        public var background:Sprite = null;

        private var _data:EventItemsTradeCongratulationVO = null;

        public function EventItemsTradeCongratulation()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            closeBtn.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
            this.confirmationBtn.addEventListener(ButtonEvent.CLICK,this.onConfirmationBtnClickHandler);
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.headerTF.text = this._data.header;
                this.titleTF.text = this._data.title;
                this.descriptionTF.text = this._data.description;
                this.multiplierTF.text = this._data.multiplier;
                this.item.source = this._data.item;
                this.sign.source = this._data.sign;
                this.confirmationBtn.label = this._data.btnLabel;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                closeBtn.validateNow();
                closeBtn.x = _width - closeBtn.width - CLOSE_BTN_OFFSET | 0;
                this.headerTF.x = _width - this.headerTF.width >> 1;
                this.titleTF.x = _width - this.titleTF.width >> 1;
                this.descriptionTF.x = _width - this.descriptionTF.width >> 1;
                this.confirmationBtn.x = _width - this.confirmationBtn.width >> 1;
                this.item.x = this.sign.x = _width - ITEM_WIDTH >> 1;
                this.multiplierTF.x = this.item.x + MULTIPLIER_OFFSET;
                this.shadow.x = this.item.x + SHADOW_OFFSET;
                this.lip.x = _width - this.lip.width >> 1;
                _loc1_ = 0;
                if(_height < HEIGHT_MIN)
                {
                    _loc1_ = HEIGHT_MIN - _height;
                }
                this.headerTF.y = HEADER_Y - _loc1_;
                if(this.headerTF.y < HEADER_Y_MIN)
                {
                    this.headerTF.y = HEADER_Y_MIN;
                }
                this.titleTF.y = TITLE_Y - _loc1_;
                if(this.titleTF.y < TITLE_Y_MIN)
                {
                    this.titleTF.y = TITLE_Y_MIN;
                }
                this.descriptionTF.y = DESCRIPTION_Y - _loc1_;
                this.item.y = ITEM_Y - _loc1_;
                if(this.item.y < ITEM_Y_MIN)
                {
                    this.item.y = ITEM_Y_MIN;
                }
                this.sign.y = SIGN_Y - _loc1_;
                if(this.sign.y < SIGN_Y_MIN)
                {
                    this.sign.y = SIGN_Y_MIN;
                }
                this.multiplierTF.y = MULTIPLIER_Y - _loc1_;
                if(this.multiplierTF.y < MULTIPLIER_Y_MIN)
                {
                    this.multiplierTF.y = MULTIPLIER_Y_MIN;
                }
                this.shadow.y = SHADOW_Y - _loc1_;
                if(this.shadow.y < SHADOW_Y_MIN)
                {
                    this.shadow.y = SHADOW_Y_MIN;
                }
                this.lip.y = LIP_Y - _loc1_;
                this.confirmationBtn.y = CONFIRMATION_BTN_Y - _loc1_;
                this.background.width = _width;
                this.background.height = _height;
            }
        }

        override protected function setData(param1:EventItemsTradeCongratulationVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function onBeforeDispose() : void
        {
            this.confirmationBtn.removeEventListener(ButtonEvent.CLICK,this.onConfirmationBtnClickHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.headerTF = null;
            this.titleTF = null;
            this.descriptionTF = null;
            this.item.dispose();
            this.item = null;
            this.sign.dispose();
            this.sign = null;
            this.multiplierTF = null;
            this.shadow = null;
            this.lip = null;
            this.background = null;
            this.confirmationBtn.dispose();
            this.confirmationBtn = null;
            this._data = null;
            super.onDispose();
        }

        override protected function onCloseBtn() : void
        {
            closeViewS();
        }

        override protected function onEscapeKeyDown() : void
        {
            closeViewS();
        }

        private function onConfirmationBtnClickHandler(param1:ButtonEvent) : void
        {
            onButtonConfirmationClickS();
        }
    }
}
