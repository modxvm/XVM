package net.wg.gui.lobby.eventShopConfirmation
{
    import net.wg.infrastructure.base.meta.impl.EventShopConfirmationMeta;
    import net.wg.infrastructure.base.meta.IEventShopConfirmationMeta;
    import flash.text.TextField;
    import net.wg.gui.components.containers.GroupEx;
    import net.wg.gui.lobby.eventShopConfirmation.components.ConfirmationRewardRenderer;
    import flash.display.MovieClip;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.display.Sprite;
    import net.wg.gui.lobby.eventCoins.EventCoins;
    import net.wg.gui.lobby.eventShopConfirmation.data.ConfirmationDataVO;
    import scaleform.clik.constants.InvalidationType;
    import flash.text.TextFieldAutoSize;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
    import net.wg.data.constants.generated.HANGAR_ALIASES;
    import scaleform.clik.events.InputEvent;

    public class EventShopConfirmation extends EventShopConfirmationMeta implements IEventShopConfirmationMeta
    {

        private static const REWARD_GAP:int = 16;

        private static const COINS_X_OFFSET:int = 6;

        private static const COINS_Y_OFFSET:int = 154;

        private static const REWARD_GROUP_RENDERER:String = "ConfirmationRewardRendererUI";

        private static const MONEY_PADDING_RIGHT:int = 6;

        private static const MONEY_PADDING_TOP:int = 8;

        public var textHeader:TextField = null;

        public var textDescription:TextField = null;

        public var rewards:GroupEx = null;

        public var textGift:TextField = null;

        public var textGiftDescription:TextField = null;

        public var gift:ConfirmationRewardRenderer = null;

        public var iconGold:MovieClip = null;

        public var priceTF:TextField = null;

        public var priceTitleTF:TextField = null;

        public var buyBtn:ISoundButtonEx = null;

        public var cancelBtn:ISoundButtonEx = null;

        public var bg:MovieClip = null;

        public var messengerBg:Sprite = null;

        public var eventCoins:EventCoins = null;

        public var money:TextField;

        private var _data:ConfirmationDataVO = null;

        private var _moneyValue:String = "";

        public function EventShopConfirmation()
        {
            super();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                x = _width >> 1;
                y = _height >> 1;
                this.bg.width = _width;
                this.bg.height = _height + this.messengerBg.height;
                this.bg.x = -x;
                this.bg.y = -y;
                this.messengerBg.x = -x;
                this.messengerBg.y = _height >> 1;
                this.messengerBg.width = _width;
                this.eventCoins.x = x - COINS_X_OFFSET;
                this.eventCoins.y = -y + COINS_Y_OFFSET;
                this.alignMoney();
            }
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                gotoAndStop(this._data.currency);
                if(_baseDisposed)
                {
                    return;
                }
                this.textHeader.autoSize = TextFieldAutoSize.CENTER;
                this.textHeader.text = this._data.title;
                this.textDescription.autoSize = TextFieldAutoSize.CENTER;
                this.textDescription.text = this._data.descr;
                this.priceTF.text = this._data.price;
                App.utils.commons.updateTextFieldSize(this.priceTF,true,false);
                this.priceTitleTF.x = -(this.priceTitleTF.width + this.priceTF.width + this.iconGold.width >> 1);
                this.priceTF.x = this.priceTitleTF.x + this.priceTitleTF.width >> 0;
                this.iconGold.x = this.priceTF.x + this.priceTF.width >> 0;
                this.textGift.autoSize = TextFieldAutoSize.CENTER;
                this.textGift.text = this._data.giftTitle;
                this.textGiftDescription.autoSize = TextFieldAutoSize.CENTER;
                this.textGiftDescription.text = this._data.giftDescr;
                this.gift.update(this._data.gift);
                this.rewards.dataProvider = this._data.rewards;
                if(this.money != null && this._moneyValue != this._data.money)
                {
                    this._moneyValue = this._data.money;
                    this.money.htmlText = this._moneyValue;
                    this.alignMoney();
                }
            }
        }

        override protected function setData(param1:ConfirmationDataVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function configUI() : void
        {
            super.configUI();
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler,true,null,getFocusIndex());
            this.buyBtn.label = EVENT.TRADESTYLES_BUY;
            this.cancelBtn.label = EVENT.TRADESTYLES_CANCEL;
            this.buyBtn.addEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
            this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelClickHandler);
            this.priceTitleTF.text = EVENT.TRADESTYLES_CONFIRMATIONCOST;
            App.utils.commons.updateTextFieldSize(this.priceTitleTF,true,false);
            var _loc1_:CenterAlignedGroupLayout = new CenterAlignedGroupLayout(ConfirmationRewardRenderer.SIZE,ConfirmationRewardRenderer.SIZE);
            _loc1_.gap = REWARD_GAP;
            this.rewards.layout = _loc1_;
            this.rewards.itemRendererLinkage = REWARD_GROUP_RENDERER;
            registerFlashComponentS(this.eventCoins,HANGAR_ALIASES.EVENT_COINS_COMPONENT);
            this.money.autoSize = TextFieldAutoSize.LEFT;
        }

        override protected function onBeforeDispose() : void
        {
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
            this.buyBtn.removeEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
            this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelClickHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.cancelBtn.dispose();
            this.cancelBtn = null;
            this.buyBtn.dispose();
            this.buyBtn = null;
            this.textHeader = null;
            this.textDescription = null;
            this.iconGold = null;
            this.priceTF = null;
            this.priceTitleTF = null;
            this.rewards.dispose();
            this.rewards = null;
            this.textGift = null;
            this.textGiftDescription = null;
            this.gift.dispose();
            this.gift = null;
            this.bg = null;
            this.messengerBg = null;
            this._data = null;
            this.eventCoins = null;
            this.money = null;
            super.onDispose();
        }

        protected function alignMoney() : void
        {
            this.money.y = MONEY_PADDING_TOP - (_height >> 1);
            this.money.x = (_width >> 1) - this.money.width - MONEY_PADDING_RIGHT | 0;
        }

        private function onEscapeKeyDownHandler(param1:InputEvent) : void
        {
            onCancelClickS();
            param1.stopImmediatePropagation();
        }

        private function onBuyBtnClickHandler(param1:ButtonEvent) : void
        {
            onBuyClickS();
        }

        private function onCancelClickHandler(param1:ButtonEvent) : void
        {
            onCancelClickS();
        }
    }
}
