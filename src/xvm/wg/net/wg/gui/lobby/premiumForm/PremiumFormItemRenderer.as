package net.wg.gui.lobby.premiumForm 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    
    public class PremiumFormItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function PremiumFormItemRenderer()
        {
            super();
            buttonMode = true;
            enabled = false;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(PRICE_POSITION) && !(data == null)) 
                if (data.isDiscountPackage) 
                    this.price.width = NORMAL_PRICE_WIDTH;
                else 
                    this.price.x = this.discount.x + this.discount.width - this.price.width;
            return;
        }

        protected override function configUI():void
        {
            soundType = net.wg.data.constants.SoundTypes.RNDR_NORMAL;
            this.price.text = "";
            this.price.textField.text = "";
            this.pdays.label = "";
            var loc1:*;
            this.price.visible = loc1 = false;
            this.pdays.visible = loc1;
            this.price.width = NORMAL_PRICE_WIDTH;
            this.radioSelection.width = this.width;
            this.addEventListener(flash.events.MouseEvent.CLICK, this.onClickHandler);
            this.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.onMouseOverHandler);
            this.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.onMouseOutHandler);
            this.updateSelection();
            super.configUI();
            this.updateData();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.removeEventListener(flash.events.MouseEvent.CLICK, this.onClickHandler);
            this.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.onMouseOverHandler);
            this.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.onMouseOutHandler);
            this.days = null;
            this._userGold = NaN;
            this.price.dispose();
            this.price = null;
            this.pdays.dispose();
            this.pdays = null;
            this.discount.dispose();
            this.discount = null;
            this.removeChild(this.radioSelection);
            this.radioSelection = null;
            return;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1 == null) 
                return;
            super.setData(arg1);
            this.days = MENU.premium_periods("days" + String(arg1.days));
            this.updateData();
            return;
        }

        internal function updateData():void
        {
            this.updateDiscountPercent(this.getDiscountPercent(data.price, data.discountPrice));
            this.price.text = App.utils.locale.gold(data.discountPrice);
            this.price.toolTip = this.days;
            this.pdays.label = this.days;
            this.pdays.data = {"isUserSelected":false, "days":data.days, "price":data.discountPrice};
            var loc1:*;
            this.price.visible = loc1 = true;
            this.pdays.visible = loc1;
            this.pdays.validateNow();
            this.updatePriceAlign = data.isDiscountPackage;
            this.gold = data.userGold;
            this.selected = data.isUserSelected;
            return;
        }

        internal function updateDiscountPercent(arg1:Number):void
        {
            var loc1:*=arg1 > 0;
            this.discount.visible = loc1;
            this.discount.quantity.text = loc1 ? "-" + arg1 + "%" : this.discount.quantity.text;
            this.price.icon = loc1 ? "goldDiscount" : "gold";
            return;
        }

        public function set updatePriceAlign(arg1:Boolean):void
        {
            invalidate(PRICE_POSITION);
            return;
        }

        internal function getDiscountPercent(arg1:Number, arg2:Number):Number
        {
            var loc1:*=0;
            if (arg2 > 0) 
                loc1 = Math.round(100 - arg2 / arg1 * 100);
            else 
                DebugUtils.LOG_ERROR("discountPrice must be greater than 0");
            if (loc1 < 0 || loc1 > 100) 
            {
                DebugUtils.LOG_ERROR("Incorrect discountPrice value. DiscountPercent was changed to 0%.");
                loc1 = 0;
            }
            return loc1;
        }

        public override function set selected(arg1:Boolean):void
        {
            super.selected = arg1;
            this.pdays.selected = arg1;
            if (data) 
                data.isUserSelected = arg1;
            this.updateSelection();
            return;
        }

        internal function updateSelection():void
        {
            this.radioSelection.visible = this.pdays.selected;
            return;
        }

        public function set gold(arg1:Number):void
        {
            this._userGold = arg1;
            var loc1:*;
            focusable = loc1 = this._userGold >= data.discountPrice;
            enabled = loc1 = loc1;
            this.pdays.enabled = loc1;
            return;
        }

        internal function onClickHandler(arg1:flash.events.MouseEvent):void
        {
            data.isUserSelected = true;
            this.updateSelection();
            invalidateData();
            return;
        }

        internal function onMouseOverHandler(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.showSpecial(this.price.toolTip, null);
            return;
        }

        internal function onMouseOutHandler(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        protected override function handlePress(arg1:uint=0):void
        {
            if (enabled == false) 
                return;
            super.handlePress(arg1);
            return;
        }

        internal static const PRICE_POSITION:String="pricePosition";

        internal static const NORMAL_PRICE_WIDTH:Number=190;

        public var pdays:net.wg.gui.components.controls.RadioButton;

        public var discount:net.wg.gui.lobby.premiumForm.DiscountPrice;

        public var price:net.wg.gui.components.controls.IconText;

        public var radioSelection:flash.display.MovieClip;

        public var _userGold:Number;

        internal var days:String=null;
    }
}
