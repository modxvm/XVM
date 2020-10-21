package net.wg.gui.lobby.eventStylesTrade
{
    import net.wg.infrastructure.base.meta.impl.EventStylesTradeMeta;
    import net.wg.infrastructure.base.meta.IEventStylesTradeMeta;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.lobby.eventStylesTrade.components.NotEnough;
    import net.wg.gui.lobby.eventStylesTrade.components.ConfirmStyleDialog;
    import net.wg.gui.lobby.eventHangar.components.EventHeaderText;
    import flash.text.TextField;
    import net.wg.gui.lobby.eventStylesTrade.components.Content;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import net.wg.gui.lobby.eventCoins.EventCoins;
    import net.wg.gui.lobby.eventStylesTrade.data.EventStylesTradeDataVO;
    import scaleform.clik.motion.Tween;
    import net.wg.gui.lobby.eventStylesTrade.data.SkinVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.events.LobbyEvent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.eventStylesTrade.events.StylesTradeEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
    import net.wg.gui.lobby.eventStylesShopTab.events.StylesShopTabEvent;
    import net.wg.data.constants.generated.HANGAR_ALIASES;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
    import net.wg.data.constants.Values;
    import scaleform.clik.events.InputEvent;

    public class EventStylesTrade extends EventStylesTradeMeta implements IEventStylesTradeMeta
    {

        private static const SHOW_INFO_ALPHA:Number = 1;

        private static const HIDE_INFO_ALPHA:Number = 0.0;

        private static const ANIMATION_DURATION:int = 200;

        private static const ANIMATION_DELAY:int = 150;

        private static const MIN_WIDTH:int = 1500;

        private static const MIN_HEIGHT:int = 900;

        private static const SUB_OFFSET_SMALL:int = 72;

        private static const SUB_OFFSET_BIG:int = 108;

        private static const HEADER_SMALL_FRAME:int = 1;

        private static const HEADER_BIG_FRAME:int = 2;

        private static const CLOSE_BTN_OFFSET:int = 10;

        private static const SMALL_WIDTH:int = 1500;

        private static const SMALL_HEIGHT:int = 1000;

        private static const COINS_Y:int = 154;

        private static const COINS_SMALL_Y:int = 101;

        private static const COINS_OFFSET:int = 5;

        private static const COINS_CURRENCY:String = "eventCoin";

        public var backBtn:ISoundButtonEx = null;

        public var notEnough:NotEnough = null;

        public var confirmBuy:ConfirmStyleDialog = null;

        public var header:EventHeaderText = null;

        public var textSubHeader:TextField = null;

        public var content:Content = null;

        public var bg:MovieClip = null;

        public var messengerBg:Sprite = null;

        public var eventCoins:EventCoins = null;

        private var _data:EventStylesTradeDataVO = null;

        private var _fadeTween:Tween = null;

        private var _isSmall:Boolean = false;

        public function EventStylesTrade()
        {
            super();
        }

        override public function setSize(param1:Number, param2:Number) : void
        {
            super.setSize(param1,param2);
            this.content.setScreenSize(param1,param2);
        }

        override public function setActualSize(param1:Number, param2:Number) : void
        {
            super.setActualSize(param1,param2);
            this._isSmall = height < MIN_HEIGHT;
            this.content.setScreenSize(param1,param2);
        }

        public function as_getDataProvider() : Object
        {
            return this.content.getDataProvider();
        }

        public function as_setVisible(param1:Boolean) : void
        {
            visible = param1;
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:SkinVO = null;
            var _loc4_:* = false;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.bg.width = _width;
                this.bg.height = _height + this.messengerBg.height;
                this.messengerBg.y = _height;
                this.messengerBg.width = _width;
                this.content.y = _height;
                this.eventCoins.x = _width - COINS_OFFSET | 0;
                this.eventCoins.y = -_height;
                if(App.appWidth < SMALL_WIDTH || App.appHeight < SMALL_HEIGHT)
                {
                    this.eventCoins.y = this.eventCoins.y + COINS_SMALL_Y;
                }
                else
                {
                    this.eventCoins.y = this.eventCoins.y + COINS_Y;
                }
                _loc1_ = _width >> 1;
                _loc2_ = _height >> 1;
                this.confirmBuy.x = _loc1_;
                this.confirmBuy.y = _height - this.confirmBuy.height >> 1;
                this.header.x = _loc1_;
                this.notEnough.x = _loc1_;
                this.notEnough.y = _loc2_;
                this.notEnough.updateClosePosition(_loc1_,-_loc2_);
                closeBtn.validateNow();
                closeBtn.x = width - closeBtn.width - CLOSE_BTN_OFFSET | 0;
            }
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.notEnough.setData(this._data,this.content.selectedIndex);
            }
            if(this._data != null && isInvalid(InvalidationType.DATA,InvalidationType.SIZE))
            {
                _loc3_ = this._data.skins[this.content.selectedIndex];
                _loc4_ = _width < MIN_WIDTH || _height < MIN_HEIGHT;
                this.header.gotoAndStop(_loc4_?HEADER_SMALL_FRAME:HEADER_BIG_FRAME);
                if(_baseDisposed)
                {
                    return;
                }
                this.eventCoins.visible = _loc3_.currency == COINS_CURRENCY;
                if(this.eventCoins.visible)
                {
                    this.content.setIsSmall(this._isSmall);
                }
                this.header.text = _loc3_.name.toUpperCase();
                this.textSubHeader.y = _loc4_?SUB_OFFSET_SMALL:SUB_OFFSET_BIG;
                this.textSubHeader.text = App.utils.locale.makeString(EVENT.TRADESTYLES_SKINDESCR,{"name":_loc3_.suitableTank});
                App.utils.commons.updateTextFieldSize(this.textSubHeader,true,false);
                this.textSubHeader.x = _width - this.textSubHeader.width >> 1;
            }
        }

        override protected function setData(param1:EventStylesTradeDataVO) : void
        {
            this._data = param1;
            this.content.setData(this._data);
            this.content.selectedIndex = param1.selectedIndex;
            invalidateData();
        }

        override protected function configUI() : void
        {
            super.configUI();
            App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler,true,null,getFocusIndex());
            this.backBtn.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
            this.content.addEventListener(StylesTradeEvent.BUY_CLICK,this.onBuyClickHandler);
            this.content.addEventListener(StylesTradeEvent.USE_CLICK,this.onUseClickHandler);
            this.content.addEventListener(CustomizationItemEvent.SELECT_ITEM,this.onSelectItemHandler);
            this.content.addEventListener(StylesTradeEvent.BUNDLE_CLICK,this.onBundleClickHandler);
            this.content.addEventListener(StylesTradeEvent.DATA_CHANGED,this.onDataChangedHandler);
            this.confirmBuy.addEventListener(StylesTradeEvent.BUY_CONFIRM_CLICK,this.onBuyConfirmClickHandler);
            this.confirmBuy.addEventListener(StylesTradeEvent.BUNDLE_CONFIRM_CLICK,this.onBundleConfirmClickHandler);
            addEventListener(StylesTradeEvent.BUY_CANCEL_CLICK,this.onBuyCancelClickHandler);
            this.notEnough.addEventListener(StylesShopTabEvent.BANNER_CLICK,this.onBannerClickHandler);
            App.stage.addEventListener(LobbyEvent.DRAGGING_START,this.onDraggingStartHandler);
            App.stage.addEventListener(LobbyEvent.DRAGGING_END,this.onDraggingEndHandler);
            closeBtn.label = EVENT.TRADESTYLES_CLOSE;
            this.backBtn.label = EVENT.TRADESTYLES_BACK;
            this.notEnough.visible = this.confirmBuy.visible = this.bg.visible = this.messengerBg.visible = false;
            mouseEnabled = false;
            this.content.addChild(this.eventCoins);
            this.content.setTouchScrollEnabled(false);
            this.content.considerWidth = true;
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerFlashComponentS(this.eventCoins,HANGAR_ALIASES.EVENT_COINS_COMPONENT);
        }

        override protected function onBeforeDispose() : void
        {
            App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
            this.backBtn.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
            this.content.removeEventListener(StylesTradeEvent.BUY_CLICK,this.onBuyClickHandler);
            this.content.removeEventListener(StylesTradeEvent.USE_CLICK,this.onUseClickHandler);
            this.content.removeEventListener(StylesTradeEvent.BUNDLE_CLICK,this.onBundleClickHandler);
            this.content.removeEventListener(StylesTradeEvent.DATA_CHANGED,this.onDataChangedHandler);
            this.confirmBuy.removeEventListener(StylesTradeEvent.BUY_CONFIRM_CLICK,this.onBuyConfirmClickHandler);
            this.confirmBuy.removeEventListener(StylesTradeEvent.BUNDLE_CONFIRM_CLICK,this.onBundleConfirmClickHandler);
            this.content.removeEventListener(CustomizationItemEvent.SELECT_ITEM,this.onSelectItemHandler);
            removeEventListener(StylesTradeEvent.BUY_CANCEL_CLICK,this.onBuyCancelClickHandler);
            this.notEnough.removeEventListener(StylesShopTabEvent.BANNER_CLICK,this.onBannerClickHandler);
            App.stage.removeEventListener(LobbyEvent.DRAGGING_START,this.onDraggingStartHandler);
            App.stage.removeEventListener(LobbyEvent.DRAGGING_END,this.onDraggingEndHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.backBtn.dispose();
            this.backBtn = null;
            this.notEnough.dispose();
            this.notEnough = null;
            this.header.dispose();
            this.header = null;
            this.textSubHeader = null;
            this.confirmBuy.dispose();
            this.confirmBuy = null;
            this.content.dispose();
            this.content = null;
            this.bg = null;
            this.messengerBg = null;
            this.eventCoins = null;
            this._data = null;
            this.clearTween();
            super.onDispose();
        }

        override protected function onCloseBtn() : void
        {
            closeViewS();
        }

        private function clearTween() : void
        {
            if(this._fadeTween != null)
            {
                this._fadeTween.paused = true;
                this._fadeTween.dispose();
                this._fadeTween = null;
            }
        }

        private function onDraggingStartHandler(param1:LobbyEvent) : void
        {
            this.clearTween();
            this._fadeTween = new Tween(ANIMATION_DURATION,this.content,{"alpha":HIDE_INFO_ALPHA},{"delay":ANIMATION_DELAY});
        }

        private function onDraggingEndHandler(param1:LobbyEvent) : void
        {
            this.clearTween();
            if(this.content.alpha != SHOW_INFO_ALPHA)
            {
                this._fadeTween = new Tween(ANIMATION_DURATION,this.content,{"alpha":SHOW_INFO_ALPHA});
            }
        }

        private function onBackBtnClickHandler(param1:ButtonEvent) : void
        {
            onBackClickS();
        }

        private function onBuyClickHandler(param1:StylesTradeEvent) : void
        {
            var _loc2_:SkinVO = this._data.skins[this.content.selectedIndex];
            if(_loc2_.notEnoughCount > 0)
            {
                if(_loc2_.currency == CURRENCIES_CONSTANTS.GOLD)
                {
                    onBuyClickS();
                }
                else
                {
                    showBlurS();
                    this.toggleWindow(false,true);
                }
            }
            else if(this._data.useConfirm)
            {
                showBlurS();
                this.confirmBuy.setData(this._data,this.content.selectedIndex,false);
                this.toggleWindow(true,false);
            }
            else
            {
                onBuyClickS();
            }
        }

        private function toggleWindow(param1:Boolean, param2:Boolean) : void
        {
            this.header.visible = this.textSubHeader.visible = this.backBtn.visible = closeBtn.visible = this.content.visible = !param1 && !param2;
            this.confirmBuy.visible = param1;
            this.notEnough.visible = param2;
            this.bg.visible = this.messengerBg.visible = param1 || param2;
        }

        private function onBuyConfirmClickHandler(param1:StylesTradeEvent) : void
        {
            hideBlurS();
            this.toggleWindow(false,false);
            onBuyClickS();
        }

        private function onBannerClickHandler(param1:StylesShopTabEvent) : void
        {
            hideBlurS();
            onBannerClickS(param1.index);
            this.toggleWindow(false,false);
        }

        private function onBuyCancelClickHandler(param1:StylesTradeEvent) : void
        {
            hideBlurS();
            this.toggleWindow(false,false);
        }

        private function onUseClickHandler(param1:StylesTradeEvent) : void
        {
            onUseClickS();
        }

        private function onDataChangedHandler(param1:StylesTradeEvent) : void
        {
            invalidateData();
        }

        private function onBundleClickHandler(param1:StylesTradeEvent) : void
        {
            if(this._data.bundleNotEnough)
            {
                onBundleClickS();
            }
            else
            {
                showBlurS();
                this.confirmBuy.setData(this._data,Values.DEFAULT_INT,true);
                this.toggleWindow(true,false);
            }
        }

        private function onBundleConfirmClickHandler(param1:StylesTradeEvent) : void
        {
            hideBlurS();
            this.toggleWindow(false,false);
            onBundleClickS();
        }

        private function onEscapeKeyDownHandler(param1:InputEvent) : void
        {
            if(!visible)
            {
                return;
            }
            if(this.confirmBuy.visible || this.notEnough.visible)
            {
                hideBlurS();
                this.toggleWindow(false,false);
            }
            else
            {
                closeViewS();
            }
        }

        private function onSelectItemHandler(param1:CustomizationItemEvent) : void
        {
            param1.stopImmediatePropagation();
            this.content.selectedIndex = param1.itemId;
            onSelectS(param1.itemId);
            invalidateData();
        }
    }
}
