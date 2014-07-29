package net.wg.gui.lobby.premiumForm
{
    import net.wg.infrastructure.base.meta.impl.PremiumFormMeta;
    import net.wg.infrastructure.base.meta.IPremiumFormMeta;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.components.controls.ScrollingListEx;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.VO.PremiumFormModel;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.events.ListEvent;
    import scaleform.clik.constants.ConstrainMode;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.InteractiveObject;
    
    public class PremiumForm extends PremiumFormMeta implements IPremiumFormMeta
    {
        
        public function PremiumForm()
        {
            this.costs = [];
            this.models = [];
            super();
            isModal = false;
            isCentered = true;
            canClose = true;
            canDrag = true;
        }
        
        private static var UPDATE_WINDOW:String = "updateWindow";
        
        private static var OFFSET_LEFT:Number = 4;
        
        private static var ADDITIONAL_PADDING:int = 2;
        
        private static var OFFSET_TOP:Number = 124;
        
        private static var PACKET_HEIGHT:Number = 25;
        
        private static var OFFSET_BOTTOM:Number = 7;
        
        private static var PACKET_MARGIN:Number = PACKET_HEIGHT + 2;
        
        public var vs:MovieClip;
        
        public var percents:TextField;
        
        public var ofCreditsAndExperience:TextField;
        
        public var perEverButtle:TextField;
        
        public var buyMessage:TextField;
        
        public var scrollingList:ScrollingListEx;
        
        public var applyButton:SoundButtonEx = null;
        
        public var closeButton:SoundButtonEx = null;
        
        private var costs:Array;
        
        private var _userGold:Number;
        
        private var models:Array;
        
        private var dataProvider:DataProvider;
        
        private var selectedItem:PremiumFormModel;
        
        private var isPremiumCalled:Boolean = false;
        
        private var isGoldCalled:Boolean = false;
        
        private var updateDataProvider:Boolean = false;
        
        private var updateWindow:Boolean = false;
        
        private var listHeight:int = 0;
        
        private var isFirstRun:Boolean = false;
        
        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            this.applyButton.removeEventListener(ButtonEvent.PRESS,this.applyButtonClickHandler);
            this.applyButton.dispose();
            this.applyButton = null;
            this.closeButton.removeEventListener(ButtonEvent.PRESS,this.cancelButtonClickHandler);
            this.closeButton.dispose();
            this.applyButton = null;
            if(this.costs)
            {
                this.costs.splice(0,this.costs.length);
                this.costs = null;
            }
            if(this.models)
            {
                for each(_loc1_ in this.models)
                {
                    _loc1_.dispose();
                }
                this.models.splice(0,this.models.length);
                this.models = null;
            }
            this.dataProvider.cleanUp();
            this.dataProvider = null;
            this.selectedItem = null;
            this.listHeight = NaN;
            this._userGold = NaN;
            this.scrollingList.removeEventListener(ListEvent.INDEX_CHANGE,this.onScrollingListItemClickHandler);
            this.scrollingList.dispose();
            this.scrollingList = null;
            this.buyMessage = null;
            this.perEverButtle = null;
            this.ofCreditsAndExperience = null;
            this.percents = null;
            this.removeChild(this.vs);
            this.vs = null;
            super.onDispose();
        }
        
        override protected function onPopulate() : void
        {
            this.updateWindowProperties();
            super.onPopulate();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(UPDATE_WINDOW))
            {
                this.updateWindowSize();
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.scrollingList.width = this.vs.width - OFFSET_LEFT - ADDITIONAL_PADDING - 1;
            this.scrollingList.x = OFFSET_LEFT + ADDITIONAL_PADDING * 0.5 + 1;
            this.scrollingList.y = OFFSET_TOP;
            this.applyButton.addEventListener(ButtonEvent.PRESS,this.applyButtonClickHandler);
            this.closeButton.addEventListener(ButtonEvent.PRESS,this.cancelButtonClickHandler);
            this.scrollingList.addEventListener(ListEvent.INDEX_CHANGE,this.onScrollingListItemClickHandler);
            this.scrollingList.focusable = false;
            this.percents.text = "+" + String(50);
            this.ofCreditsAndExperience.text = MENU.PREMIUM_OFCREDITSANDEXPERIENCE;
            this.perEverButtle.text = MENU.PREMIUM_PEREVERBUTTLE;
            onPremiumDataRequestS();
        }
        
        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
        }
        
        public function as_setGold(param1:Number) : void
        {
            this._userGold = param1;
            this.isGoldCalled = true;
            this.onChange();
        }
        
        public function as_setCosts(param1:Array) : void
        {
            this.costs = param1;
            this.onChange();
        }
        
        public function as_setPremium(param1:Boolean) : void
        {
            this.isPremiumCalled = true;
            this.buyMessage.text = param1?MENU.PREMIUM_CONTINUEMESSAGE:MENU.PREMIUM_BUYMESSAGE;
            this.applyButton.label = param1?MENU.PREMIUM_SUBMITCONTINUE:MENU.PREMIUM_SUBMITBUY;
            window.title = param1?MENU.PREMIUM_CONTINUETITLE:MENU.PREMIUM_BUYTITLE;
            this.onChange();
        }
        
        private function updateWindowProperties() : void
        {
            window.getConstraints().scaleMode = ConstrainMode.COUNTER_SCALE;
            window.useBottomBtns = true;
            window.title = "";
            this.updateStage(App.appWidth,App.appHeight);
        }
        
        private function onChange() : void
        {
            if(!this.isAccessData())
            {
                return;
            }
            this.changeButtonsFocus(false);
            this.updateDataProvider = true;
            this.createDataProvider();
        }
        
        private function createDataProvider() : void
        {
            var isDiscountPackage:Boolean = false;
            var innerCheckDiscount:Function = null;
            var model:PremiumFormModel = null;
            innerCheckDiscount = function(param1:Object, param2:int, param3:Array):void
            {
                isDiscountPackage = !(param1["discountPrice"] == param1["price"]) || (isDiscountPackage);
            };
            this.listHeight = 0;
            this.scrollingList.selectedIndex = -1;
            this.scrollingList.dataProvider.cleanUp();
            isDiscountPackage = false;
            this.costs.forEach(innerCheckDiscount);
            this.models = [];
            var i:int = 0;
            while(i < this.costs.length)
            {
                model = new PremiumFormModel(this.costs[i]);
                model.userGold = this._userGold;
                model.isDiscountPackage = isDiscountPackage;
                model.isUserSelected = false;
                this.models.push(model);
                this.listHeight = this.listHeight + PACKET_MARGIN;
                i++;
            }
            this.autoSelectItemsByDiscountPrice(this.models);
            if(!this.dataProvider)
            {
                this.dataProvider = new DataProvider(this.models);
            }
            else
            {
                this.dataProvider.cleanUp();
                this.dataProvider.setSource(this.models);
            }
            if(!this.isFirstRun)
            {
                this.updateScrollingSize();
            }
            else
            {
                this.dataProvider.invalidate();
            }
            this.updateWindowSize();
            invalidate(UPDATE_WINDOW);
        }
        
        private function updateScrollingSize() : void
        {
            this.scrollingList.height = this.listHeight - ADDITIONAL_PADDING * 0.5;
            this.vs.height = Math.round(this.scrollingList.height + this.scrollingList.y + this.applyButton.height + OFFSET_BOTTOM * 0.5 + ADDITIONAL_PADDING);
            this.applyButton.y = this.closeButton.y = Math.round(this.vs.height - this.applyButton.height);
            this.scrollingList.dataProvider = this.dataProvider;
            this.scrollingList.invalidate(InvalidationType.DATA);
        }
        
        private function updateWindowSize() : void
        {
            window.updateSize(this.vs.width,this.vs.height,true);
            window.validateNow();
        }
        
        private function autoSelectItemsByDiscountPrice(param1:Array) : void
        {
            var _loc2_:PremiumFormModel = null;
            var _loc4_:PremiumFormModel = null;
            var _loc3_:* = 0;
            while(_loc3_ < param1.length)
            {
                _loc4_ = param1[_loc3_] as PremiumFormModel;
                if(_loc4_.price <= this._userGold || _loc4_.discountPrice <= this._userGold)
                {
                    if((this.selectedItem) && this.selectedItem.days == _loc4_.days)
                    {
                        _loc4_.isUserSelected = true;
                        this.changeButtonsFocus(true);
                        return;
                    }
                    if((_loc2_) && _loc2_.discountPrice < _loc4_.discountPrice)
                    {
                        _loc2_ = _loc4_;
                    }
                    else
                    {
                        _loc2_;
                        _loc2_ = _loc4_;
                    }
                }
                _loc3_++;
            }
            if(_loc2_)
            {
                _loc2_.isUserSelected = true;
                this.selectedItem = _loc2_;
                this.changeButtonsFocus(true);
            }
            else
            {
                this.changeButtonsFocus(false);
            }
        }
        
        private function changeButtonsFocus(param1:Boolean = false) : void
        {
            this.applyButton.enabled = param1;
            setFocus(param1?this.applyButton:this.closeButton);
        }
        
        private function clearPreviousCostControls() : void
        {
            this.listHeight = 0;
            this.costs = [];
            this.dataProvider = new DataProvider();
        }
        
        private function isAccessData() : Boolean
        {
            return (this.isPremiumCalled) && this.costs.length > 0 && (this.isGoldCalled);
        }
        
        private function applyButtonClickHandler(param1:ButtonEvent) : void
        {
            if(this.selectedItem)
            {
                onPremiumBuyS(this.selectedItem.days,this.selectedItem.discountPrice);
            }
        }
        
        private function cancelButtonClickHandler(param1:ButtonEvent) : void
        {
            onWindowCloseS();
        }
        
        private function onScrollingListItemClickHandler(param1:ListEvent) : void
        {
            if(param1.itemData == null)
            {
                return;
            }
            this.scrollingList.dataProvider.invalidate();
            this.selectedItem = param1.itemData as PremiumFormModel;
        }
    }
}
