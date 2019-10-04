package net.wg.gui.lobby.store.actions
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.interfaces.IContentSize;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.lobby.store.actions.data.StoreActionsViewVo;
    import net.wg.gui.lobby.store.actions.data.StoreActionTimeVo;
    import net.wg.gui.lobby.store.actions.interfaces.IStoreActionCard;
    import net.wg.gui.lobby.store.actions.data.CardsSettings;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.generated.STORE_CONSTANTS;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.store.actions.evnts.StoreActionsEvent;

    public class StoreActionsContainer extends UIComponentEx implements IContentSize
    {

        private static const TITLE_BOTTOM_MARGIN:Number = 17;

        private static const COMING_SOON_TOP_MARGIN:Number = 63;

        private static const VIEW_PERMANENT_WIDTH:Number = 960;

        private static const CONTENT_BOTTOM_MARGIN:Number = 30;

        private static const CONTENT_BOTTOM_MARGIN_WITHOUT_CARDS:Number = 60;

        private static const CARDS_HEIGHT_BREAK_POINT:Number = 500;

        private static const CARDS_TOP_MARGIN_FOR_SMALL_HEIGHT_CONTENT:Number = 0.25;

        private static const IS_ACTION_TIME_INVALID:String = "isActionTimeInvalid";

        public var title:TextField = null;

        private var _emptyView:StoreActionsEmpty = null;

        private var _cardsContainer:Sprite = null;

        private var _availableViewHeight:Number = 0;

        private var _data:StoreActionsViewVo = null;

        private var _actionsTime:Vector.<StoreActionTimeVo> = null;

        private var _cards:Vector.<IStoreActionCard> = null;

        private var _cardComingSoon:IStoreActionCard = null;

        private var _contentMaxHeight:Number = 0;

        private var _cardComingSoonEstimatedYPos:Number = 0;

        private var _cardComingSoonBottomMargin:Number = 0;

        private var _cardsSettingsVo:CardsSettings = null;

        private var _isCenteredCardsByHeight:Boolean = false;

        private var _filledSpace:Number = 0;

        public function StoreActionsContainer()
        {
            super();
            this._cardsSettingsVo = new CardsSettings();
        }

        override public function setSize(param1:Number, param2:Number) : void
        {
            super.setSize(param1,param2);
            this._availableViewHeight = param2;
            invalidateSize();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(IS_ACTION_TIME_INVALID))
            {
                this.updateCardsTime(this._actionsTime);
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateSize();
            }
        }

        override protected function onDispose() : void
        {
            this.clearCards();
            this._cardsSettingsVo.dispose();
            this._cardsSettingsVo = null;
            this.title = null;
            this._data = null;
            this._actionsTime = null;
            super.onDispose();
        }

        public function getCardYPositionById(param1:String, param2:Boolean) : Number
        {
            if(param1 == Values.EMPTY_STR)
            {
                return 0;
            }
            var _loc3_:IStoreActionCard = this.getCardById(param1);
            if(_loc3_ && _loc3_.linkage != STORE_CONSTANTS.ACTION_CARD_HERO_LINKAGE)
            {
                if(param2)
                {
                    _loc3_.setSelect();
                }
                return _loc3_.y;
            }
            return 0;
        }

        public function setData(param1:StoreActionsViewVo) : void
        {
            this._data = param1;
            this.clearCards();
            this.buildActionCards(this._data);
            dispatchEvent(new Event(Event.RESIZE));
            dispatchEvent(new Event(Event.COMPLETE));
            invalidateSize();
        }

        public function updateActionsTime(param1:Vector.<StoreActionTimeVo>) : void
        {
            this._actionsTime = param1;
            invalidate(IS_ACTION_TIME_INVALID);
        }

        private function buildActionCards(param1:StoreActionsViewVo) : void
        {
            var _loc3_:* = NaN;
            var _loc4_:IStoreActionCard = null;
            var _loc5_:IStoreActionCard = null;
            var _loc6_:IStoreActionCard = null;
            var _loc7_:* = NaN;
            var _loc8_:* = NaN;
            var _loc9_:* = 0;
            var _loc10_:* = 0;
            var _loc2_:* = false;
            if(param1.cards)
            {
                _loc3_ = 0;
                _loc4_ = null;
                _loc5_ = null;
                _loc6_ = null;
                _loc7_ = 0;
                _loc8_ = 0;
                this._filledSpace = 0;
                _loc2_ = param1.cards.heroCardVo || param1.cards.storeActionCardsColumnLeft || param1.cards.storeActionCardsColumnRight;
                if(_loc2_)
                {
                    this.title.text = App.utils.locale.makeString(param1.title);
                    this.title.visible = true;
                    _loc3_ = this.title.y + this.title.textHeight + TITLE_BOTTOM_MARGIN ^ 0;
                    this._cards = new Vector.<IStoreActionCard>();
                    this._cardsContainer = new Sprite();
                    this.addChild(this._cardsContainer);
                    if(param1.cards.heroCardVo)
                    {
                        _loc4_ = this.createCardByLinkage(param1.cards.heroCardVo.linkage);
                        _loc4_.y = _loc3_;
                        _loc4_.shiftFromCenterByX = -(_loc4_.getPermanentWidth() >> 1);
                        _loc3_ = _loc3_ + (_loc4_.getPermanentHeight() + _loc4_.getPermanentBottomMargin());
                        _loc4_.setData(param1.cards.heroCardVo);
                        this._cardsContainer.addChild(DisplayObject(_loc4_));
                        this._cards.push(_loc4_);
                    }
                    _loc4_ = null;
                    if(param1.cards.storeActionCardsColumnLeft && param1.cards.storeActionCardsColumnRight)
                    {
                        _loc7_ = _loc3_;
                        _loc9_ = 0;
                        _loc10_ = param1.cards.storeActionCardsColumnLeft.length;
                        _loc9_ = 0;
                        while(_loc9_ < _loc10_)
                        {
                            _loc4_ = this.createCardByLinkage(param1.cards.storeActionCardsColumnLeft[_loc9_].linkage);
                            _loc4_.y = _loc7_;
                            _loc4_.shiftFromCenterByX = -_loc4_.getPermanentWidth() - (_loc4_.getPermanentLeftMargin() >> 1);
                            _loc7_ = _loc7_ + (_loc4_.getPermanentHeight() + _loc4_.getPermanentBottomMargin());
                            _loc4_.setData(param1.cards.storeActionCardsColumnLeft[_loc9_]);
                            this._cardsContainer.addChild(DisplayObject(_loc4_));
                            this._cards.push(_loc4_);
                            _loc9_++;
                        }
                        _loc5_ = _loc4_;
                        _loc8_ = _loc3_;
                        _loc10_ = param1.cards.storeActionCardsColumnRight.length;
                        _loc4_ = null;
                        _loc9_ = 0;
                        while(_loc9_ < _loc10_)
                        {
                            _loc4_ = this.createCardByLinkage(param1.cards.storeActionCardsColumnRight[_loc9_].linkage);
                            _loc4_.y = _loc8_;
                            _loc4_.shiftFromCenterByX = _loc4_.getPermanentLeftMargin() >> 1;
                            _loc8_ = _loc8_ + (_loc4_.getPermanentHeight() + _loc4_.getPermanentBottomMargin());
                            _loc4_.setData(param1.cards.storeActionCardsColumnRight[_loc9_]);
                            this._cardsContainer.addChild(DisplayObject(_loc4_));
                            this._cards.push(_loc4_);
                            _loc9_++;
                        }
                        _loc6_ = _loc4_;
                        _loc3_ = Math.max(_loc7_,_loc8_);
                    }
                }
                if(param1.cards.comingSoonVo)
                {
                    _loc4_ = this.createCardByLinkage(param1.cards.comingSoonVo.linkage);
                    _loc3_ = _loc3_ + COMING_SOON_TOP_MARGIN;
                    _loc4_.y = _loc3_;
                    this._cardComingSoonEstimatedYPos = _loc3_;
                    _loc4_.shiftFromCenterByX = -(_loc4_.getPermanentWidth() >> 1);
                    _loc4_.setData(param1.cards.comingSoonVo);
                    this.addChild(DisplayObject(_loc4_));
                    this._cardComingSoon = _loc4_;
                    _loc3_ = _loc3_ + _loc4_.getPermanentHeight();
                    this._cardComingSoonBottomMargin = _loc2_?CONTENT_BOTTOM_MARGIN:CONTENT_BOTTOM_MARGIN_WITHOUT_CARDS;
                }
                else if(_loc7_ > _loc8_)
                {
                    if(_loc5_)
                    {
                        _loc3_ = _loc3_ - _loc5_.getPermanentBottomMargin();
                    }
                }
                else if(_loc6_)
                {
                    _loc3_ = _loc3_ - _loc6_.getPermanentBottomMargin();
                }
                this._contentMaxHeight = _loc3_ + CONTENT_BOTTOM_MARGIN;
                this._isCenteredCardsByHeight = _loc2_ && CARDS_HEIGHT_BREAK_POINT > this._cardsContainer.height;
                if(this._isCenteredCardsByHeight)
                {
                    this._filledSpace = this.title.y + this.title.textHeight + this._cardsContainer.height + CONTENT_BOTTOM_MARGIN ^ 0;
                    if(this._cardComingSoon)
                    {
                        this._filledSpace = this._filledSpace + this._cardComingSoon.getPermanentHeight();
                    }
                }
            }
            if(!_loc2_ && param1.empty)
            {
                this.title.visible = false;
                this._emptyView = App.utils.classFactory.getComponent(STORE_CONSTANTS.ACTION_EMPTY_LINKAGE,StoreActionsEmpty);
                this._emptyView.setData(param1.title,param1.empty);
                this.addChild(this._emptyView);
                this._emptyView.addEventListener(StoreActionsEvent.ACTION_CLICK,this.onEmptyViewActionClickHandler);
                this._contentMaxHeight = this._emptyView.height;
            }
        }

        private function updateCardsTime(param1:Vector.<StoreActionTimeVo>) : void
        {
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:IStoreActionCard = null;
            if(this._cards && param1)
            {
                _loc2_ = param1.length;
                _loc3_ = 0;
                while(_loc3_ < _loc2_)
                {
                    _loc4_ = this.getCardById(param1[_loc3_].id);
                    if(_loc4_)
                    {
                        _loc4_.updateTime(param1[_loc3_]);
                    }
                    _loc3_++;
                }
            }
        }

        private function getCardById(param1:String) : IStoreActionCard
        {
            var _loc2_:int = this._cards.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                if(this._cards[_loc3_].cardId == param1)
                {
                    return this._cards[_loc3_];
                }
                _loc3_++;
            }
            return null;
        }

        private function createCardByLinkage(param1:String) : IStoreActionCard
        {
            var _loc2_:IStoreActionCard = App.utils.classFactory.getComponent(param1,IStoreActionCard);
            _loc2_.settings = this._cardsSettingsVo.getSettingsById(param1);
            _loc2_.addEventListener(StoreActionsEvent.ACTION_CLICK,this.onCardActionClickHandler);
            _loc2_.addEventListener(StoreActionsEvent.ACTION_SEEN,this.onCardActionSeenHandler);
            _loc2_.addEventListener(StoreActionsEvent.BATTLE_TASK_CLICK,this.onCardBattleTaskClickHandler);
            return _loc2_;
        }

        private function updateSize() : void
        {
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc1_:Number = App.appWidth >> 1;
            this.title.x = _loc1_ - (this.title.width >> 1);
            if(this._cards)
            {
                _loc2_ = this._cards.length;
                _loc3_ = 0;
                while(_loc3_ < _loc2_)
                {
                    this._cards[_loc3_].updateStageSize(App.appWidth,App.appHeight);
                    this._cards[_loc3_].x = _loc1_ + this._cards[_loc3_].shiftFromCenterByX;
                    _loc3_++;
                }
                if(this._isCenteredCardsByHeight && this._filledSpace > 0)
                {
                    this._cardsContainer.y = Math.max(0,(this._availableViewHeight - this._filledSpace) * CARDS_TOP_MARGIN_FOR_SMALL_HEIGHT_CONTENT ^ 0);
                }
            }
            if(this._cardComingSoon)
            {
                this._cardComingSoon.updateStageSize(App.appWidth,App.appHeight);
                this._cardComingSoon.x = _loc1_ + this._cardComingSoon.shiftFromCenterByX;
                if(this._availableViewHeight > this._contentMaxHeight)
                {
                    this._cardComingSoon.y = this._availableViewHeight - this._cardComingSoon.getPermanentHeight() - this._cardComingSoonBottomMargin;
                }
                else
                {
                    this._cardComingSoon.y = this._cardComingSoonEstimatedYPos;
                }
            }
            if(this._emptyView)
            {
                this._emptyView.x = _loc1_;
                this._emptyView.y = this._availableViewHeight - this._emptyView.height >> 1;
            }
        }

        private function clearCards() : void
        {
            var _loc1_:IStoreActionCard = null;
            if(this._cardComingSoon)
            {
                this.removeChild(DisplayObject(this._cardComingSoon));
                this._cardComingSoon = null;
            }
            if(this._cardsContainer && this._cards)
            {
                _loc1_ = null;
                while(this._cards.length)
                {
                    _loc1_ = this._cards.pop();
                    _loc1_.removeEventListener(StoreActionsEvent.ACTION_CLICK,this.onCardActionClickHandler);
                    _loc1_.removeEventListener(StoreActionsEvent.ACTION_SEEN,this.onCardActionSeenHandler);
                    _loc1_.removeEventListener(StoreActionsEvent.BATTLE_TASK_CLICK,this.onCardBattleTaskClickHandler);
                    _loc1_.dispose();
                    this._cardsContainer.removeChild(DisplayObject(_loc1_));
                }
                this._cards = null;
                this.removeChild(this._cardsContainer);
                this._cardsContainer = null;
            }
            if(this._emptyView)
            {
                this._emptyView.removeEventListener(StoreActionsEvent.ACTION_CLICK,this.onEmptyViewActionClickHandler);
                this.removeChild(this._emptyView);
                this._emptyView.dispose();
                this._emptyView = null;
            }
        }

        public function get contentWidth() : Number
        {
            return VIEW_PERMANENT_WIDTH;
        }

        public function get contentHeight() : Number
        {
            return this._contentMaxHeight;
        }

        private function onCardBattleTaskClickHandler(param1:StoreActionsEvent) : void
        {
            this.dispatcherActionsEvent(param1);
        }

        private function onEmptyViewActionClickHandler(param1:StoreActionsEvent) : void
        {
            this.dispatcherActionsEvent(param1);
        }

        private function onCardActionClickHandler(param1:StoreActionsEvent) : void
        {
            this.dispatcherActionsEvent(param1);
        }

        private function onCardActionSeenHandler(param1:StoreActionsEvent) : void
        {
            this.dispatcherActionsEvent(param1);
        }

        private function dispatcherActionsEvent(param1:StoreActionsEvent) : void
        {
            dispatchEvent(param1);
        }
    }
}
