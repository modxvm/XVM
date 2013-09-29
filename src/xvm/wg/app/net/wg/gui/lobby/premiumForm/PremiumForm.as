package net.wg.gui.lobby.premiumForm 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.VO.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class PremiumForm extends net.wg.infrastructure.base.meta.impl.PremiumFormMeta implements net.wg.infrastructure.base.meta.IPremiumFormMeta
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
            return;
        }

        protected override function onPopulate():void
        {
            this.updateWindowProperties();
            super.onPopulate();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(UPDATE_WINDOW)) 
            {
                this.updateWindowSize();
            }
            return;
        }

        internal function onScrollingListItemClickHandler(arg1:scaleform.clik.events.ListEvent):void
        {
            if (arg1.itemData == null) 
            {
                return;
            }
            this.scrollingList.dataProvider.invalidate();
            this.selectedItem = arg1.itemData as net.wg.data.VO.PremiumFormModel;
            return;
        }

        internal function cancelButtonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onWindowCloseS();
            return;
        }

        internal function updateWindowProperties():void
        {
            window.getConstraints().scaleMode = scaleform.clik.constants.ConstrainMode.COUNTER_SCALE;
            window.useBottomBtns = true;
            window.title = "";
            this.updateStage(App.appWidth, App.appHeight);
            return;
        }

        internal function applyButtonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (this.selectedItem) 
            {
                onPremiumBuyS(this.selectedItem.days, this.selectedItem.discountPrice);
            }
            return;
        }

        internal function isAccessData():Boolean
        {
            return this.isPremiumCalled && this.costs.length > 0 && this.isGoldCalled;
        }

        internal function clearPreviousCostControls():void
        {
            this.listHeight = 0;
            this.costs = [];
            this.dataProvider = new scaleform.clik.data.DataProvider();
            return;
        }

        internal function changeButtonsFocus(arg1:Boolean=false):void
        {
            this.applyButton.enabled = arg1;
            App.utils.focusHandler.setFocus(arg1 ? this.applyButton : this.closeButton);
            return;
        }

        internal function autoSelectItemsByDiscountPrice(arg1:Array):void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                if ((loc3 = arg1[loc2] as net.wg.data.VO.PremiumFormModel).price <= this._userGold || loc3.discountPrice <= this._userGold) 
                {
                    if (this.selectedItem && this.selectedItem.days == loc3.days) 
                    {
                        loc3.isUserSelected = true;
                        this.changeButtonsFocus(true);
                        return;
                    }
                    if (loc1 && loc1.discountPrice < loc3.discountPrice) 
                    {
                        loc1 = loc3;
                    }
                    else if (!loc1) 
                    {
                        loc1 = loc3;
                    }
                }
                ++loc2;
            }
            if (loc1) 
            {
                loc1.isUserSelected = true;
                this.selectedItem = loc1;
                this.changeButtonsFocus(true);
            }
            else 
            {
                this.changeButtonsFocus(false);
            }
            return;
        }

        internal function updateWindowSize():void
        {
            window.updateSize(this.vs.width, this.vs.height, true);
            window.validateNow();
            return;
        }

        internal function updateScrollingSize():void
        {
            this.scrollingList.height = this.listHeight - ADDITIONAL_PADDING * 0.5;
            this.vs.height = Math.round(this.scrollingList.height + this.scrollingList.y + this.applyButton.height + OFFSET_BOTTOM * 0.5 + ADDITIONAL_PADDING);
            var loc1:*;
            this.closeButton.y = loc1 = Math.round(this.vs.height - this.applyButton.height);
            this.applyButton.y = loc1;
            this.scrollingList.dataProvider = this.dataProvider;
            this.scrollingList.invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        internal function createDataProvider():void
        {
            var isDiscountPackage:Boolean;
            var innerCheckDiscount:Function;
            var i:int;
            var model:net.wg.data.VO.PremiumFormModel;

            var loc1:*;
            isDiscountPackage = false;
            innerCheckDiscount = null;
            model = null;
            innerCheckDiscount = function (arg1:Object, arg2:int, arg3:Array):void
            {
                isDiscountPackage = !(arg1["discountPrice"] == arg1["price"]) || isDiscountPackage;
                return;
            }
            this.listHeight = 0;
            this.scrollingList.selectedIndex = -1;
            this.scrollingList.dataProvider.cleanUp();
            isDiscountPackage = false;
            this.costs.forEach(innerCheckDiscount);
            this.models = [];
            i = 0;
            while (i < this.costs.length) 
            {
                model = new net.wg.data.VO.PremiumFormModel(this.costs[i]);
                model.userGold = this._userGold;
                model.isDiscountPackage = isDiscountPackage;
                model.isUserSelected = false;
                this.models.push(model);
                this.listHeight = this.listHeight + PACKET_MARGIN;
                ++i;
            }
            this.autoSelectItemsByDiscountPrice(this.models);
            if (this.dataProvider) 
            {
                this.dataProvider.cleanUp();
                this.dataProvider.setSource(this.models);
            }
            else 
            {
                this.dataProvider = new scaleform.clik.data.DataProvider(this.models);
            }
            if (this.isFirstRun) 
            {
                this.dataProvider.invalidate();
            }
            else 
            {
                this.updateScrollingSize();
            }
            this.updateWindowSize();
            invalidate(UPDATE_WINDOW);
            return;
        }

        internal function onChange():void
        {
            if (!this.isAccessData()) 
            {
                return;
            }
            this.changeButtonsFocus(false);
            this.updateDataProvider = true;
            this.createDataProvider();
            return;
        }

        public function as_setPremium(arg1:Boolean):void
        {
            this.isPremiumCalled = true;
            this.buyMessage.text = arg1 ? MENU.PREMIUM_CONTINUEMESSAGE : MENU.PREMIUM_BUYMESSAGE;
            this.applyButton.label = arg1 ? MENU.PREMIUM_SUBMITCONTINUE : MENU.PREMIUM_SUBMITBUY;
            window.title = arg1 ? MENU.PREMIUM_CONTINUETITLE : MENU.PREMIUM_BUYTITLE;
            this.onChange();
            return;
        }

        public function as_setCosts(arg1:Array):void
        {
            this.costs = arg1;
            this.onChange();
            return;
        }

        public function as_setGold(arg1:Number):void
        {
            this._userGold = arg1;
            this.isGoldCalled = true;
            this.onChange();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.scrollingList.width = (this.vs.width - OFFSET_LEFT - ADDITIONAL_PADDING - 1);
            this.scrollingList.x = OFFSET_LEFT + ADDITIONAL_PADDING * 0.5 + 1;
            this.scrollingList.y = OFFSET_TOP;
            this.applyButton.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.applyButtonClickHandler);
            this.closeButton.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.cancelButtonClickHandler);
            this.scrollingList.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onScrollingListItemClickHandler);
            this.scrollingList.focusable = false;
            this.percents.text = "+" + String(50);
            this.ofCreditsAndExperience.text = MENU.PREMIUM_OFCREDITSANDEXPERIENCE;
            this.perEverButtle.text = MENU.PREMIUM_PEREVERBUTTLE;
            onPremiumDataRequestS();
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            super.updateStage(arg1, arg2);
            return;
        }

        protected override function onDispose():void
        {
            var loc1:*=null;
            super.onDispose();
            this.applyButton.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.applyButtonClickHandler);
            this.applyButton.dispose();
            this.applyButton = null;
            this.closeButton.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.cancelButtonClickHandler);
            this.closeButton.dispose();
            this.applyButton = null;
            if (this.costs) 
            {
                this.costs.splice(0, this.costs.length);
                this.costs = null;
            }
            if (this.models) 
            {
                var loc2:*=0;
                var loc3:*=this.models;
                for each (loc1 in loc3) 
                {
                    loc1.dispose();
                }
                this.models.splice(0, this.models.length);
                this.models = null;
            }
            this.dataProvider.cleanUp();
            this.dataProvider = null;
            this.selectedItem.dispose();
            this.selectedItem = null;
            this.listHeight = NaN;
            this._userGold = NaN;
            this.scrollingList.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onScrollingListItemClickHandler);
            this.scrollingList.dispose();
            this.scrollingList = null;
            this.buyMessage = null;
            this.perEverButtle = null;
            this.ofCreditsAndExperience = null;
            this.percents = null;
            this.removeChild(this.vs);
            this.vs = null;
            return;
        }

        internal static const OFFSET_BOTTOM:Number=13;

        internal static const PACKET_MARGIN:Number=PACKET_HEIGHT + 3;

        internal static const OFFSET_LEFT:Number=4;

        internal static const UPDATE_WINDOW:String="updateWindow";

        internal static const ADDITIONAL_PADDING:int=2;

        internal static const OFFSET_TOP:Number=124;

        internal static const PACKET_HEIGHT:Number=21;

        public var vs:flash.display.MovieClip;

        public var percents:flash.text.TextField;

        internal var selectedItem:net.wg.data.VO.PremiumFormModel;

        internal var dataProvider:scaleform.clik.data.DataProvider;

        internal var models:Array;

        internal var _userGold:Number;

        internal var costs:Array;

        public var closeButton:net.wg.gui.components.controls.SoundButtonEx=null;

        public var applyButton:net.wg.gui.components.controls.SoundButtonEx=null;

        public var scrollingList:net.wg.gui.components.controls.ScrollingListEx;

        public var perEverButtle:flash.text.TextField;

        public var ofCreditsAndExperience:flash.text.TextField;

        internal var isFirstRun:Boolean=false;

        public var buyMessage:flash.text.TextField;

        internal var updateWindow:Boolean=false;

        internal var updateDataProvider:Boolean=false;

        internal var isGoldCalled:Boolean=false;

        internal var listHeight:int=0;

        internal var isPremiumCalled:Boolean=false;
    }
}
