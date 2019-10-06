package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.CrystalsPromoWindowMeta;
    import net.wg.infrastructure.base.meta.ICrystalsPromoWindowMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.Image;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.controls.Button;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.interfaces.IWindow;
    import scaleform.clik.events.ButtonEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.data.CrystalsPromoWindowVO;

    public class CrystalsPromoWindow extends CrystalsPromoWindowMeta implements ICrystalsPromoWindowMeta
    {

        private static const PLACE_RANGE:int = 3;

        private static const GAP:int = -20;

        private static const MIN_LINES_COUNT:int = 3;

        private static const OPEN_SHOP_BTN_OFFSET:int = 15;

        public var headerTF:TextField = null;

        public var subTitle0:TextField = null;

        public var subDescr0:TextField = null;

        public var subTitle1:TextField = null;

        public var subDescr1:TextField = null;

        public var subTitle2:TextField = null;

        public var subDescr2:TextField = null;

        public var image0:Image = null;

        public var image1:Image = null;

        public var image2:Image = null;

        public var bg:UILoaderAlt = null;

        public var closeBtn:ISoundButtonEx = null;

        public var openShopBtn:SoundButtonEx = null;

        private var _formCloseBtn:Button = null;

        private var _itemsToPlace:Vector.<DisplayObject> = null;

        private var _gap:int = 0;

        public function CrystalsPromoWindow()
        {
            super();
            this._itemsToPlace = new <DisplayObject>[this.subDescr0,this.image1,this.subTitle1,this.subDescr1,this.image2,this.subTitle2,this.subDescr2];
        }

        override public function setWindow(param1:IWindow) : void
        {
            super.setWindow(param1);
            window.useBottomBtns = true;
            this._formCloseBtn = param1.getCloseBtn();
            this._formCloseBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.subTitle0.autoSize = this.subTitle1.autoSize = this.subTitle2.autoSize = TextFieldAutoSize.LEFT;
            this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.openShopBtn.addEventListener(ButtonEvent.CLICK,this.onOpenShopBtnHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.arrangeElements(0);
                this.openShopBtn.y = this.subDescr2.y + this.subDescr2.textHeight + OPEN_SHOP_BTN_OFFSET;
            }
        }

        override protected function setData(param1:CrystalsPromoWindowVO) : void
        {
            window.title = param1.windowTitle;
            this.headerTF.htmlText = param1.headerTF;
            this.subTitle0.htmlText = param1.subTitle0;
            this.subDescr0.htmlText = param1.subDescr0;
            this.subTitle1.htmlText = param1.subTitle1;
            this.subDescr1.htmlText = param1.subDescr1;
            this.subTitle2.htmlText = param1.subTitle2;
            this.subDescr2.htmlText = param1.subDescr2;
            this.image0.source = param1.image0;
            this.image1.source = param1.image1;
            this.image2.source = param1.image2;
            this.bg.source = param1.bg;
            this.closeBtn.label = param1.closeBtn;
            this.openShopBtn.visible = param1.showOpenShopBtn;
            if(param1.showOpenShopBtn)
            {
                this.openShopBtn.label = param1.openShopBtnLabel;
            }
            invalidateSize();
        }

        override protected function onDispose() : void
        {
            this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.openShopBtn.removeEventListener(ButtonEvent.CLICK,this.onOpenShopBtnHandler);
            this._formCloseBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this._formCloseBtn = null;
            this.headerTF = null;
            this.subTitle0 = null;
            this.subDescr0 = null;
            this.subTitle1 = null;
            this.subDescr1 = null;
            this.subTitle2 = null;
            this.subDescr2 = null;
            this.image0.dispose();
            this.image0 = null;
            this.image1.dispose();
            this.image1 = null;
            this.image2.dispose();
            this.image2 = null;
            this.bg.dispose();
            this.bg = null;
            this.closeBtn.dispose();
            this.closeBtn = null;
            this.openShopBtn.dispose();
            this.openShopBtn = null;
            if(this._itemsToPlace)
            {
                this._itemsToPlace.splice(0,this._itemsToPlace.length);
                this._itemsToPlace = null;
            }
            super.onDispose();
        }

        private function arrangeElements(param1:int) : void
        {
            var _loc2_:DisplayObject = null;
            var _loc3_:* = false;
            var _loc4_:TextField = null;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            if(param1 < this._itemsToPlace.length)
            {
                _loc3_ = true;
                _loc4_ = TextField(this._itemsToPlace[param1]);
                if(_loc4_.numLines < MIN_LINES_COUNT)
                {
                    this._gap = this._gap + GAP;
                }
                _loc5_ = param1 + PLACE_RANGE;
                if(_loc5_ > this._itemsToPlace.length)
                {
                    _loc5_ = this._itemsToPlace.length - 1;
                    _loc3_ = false;
                }
                if(this._gap != 0)
                {
                    _loc6_ = param1 + 1;
                    while(_loc6_ <= _loc5_)
                    {
                        _loc2_ = this._itemsToPlace[_loc6_];
                        _loc2_.y = _loc2_.y + this._gap;
                        _loc6_++;
                    }
                }
                if(_loc3_)
                {
                    this.arrangeElements(_loc5_);
                }
            }
        }

        private function onCloseBtnClickHandler(param1:ButtonEvent) : void
        {
            onWindowCloseS();
        }

        private function onOpenShopBtnHandler(param1:ButtonEvent) : void
        {
            onOpenShopS();
        }
    }
}
