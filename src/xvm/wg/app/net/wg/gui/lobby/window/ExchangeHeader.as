package net.wg.gui.lobby.window 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    
    public class ExchangeHeader extends scaleform.clik.core.UIComponent
    {
        public function ExchangeHeader()
        {
            this.infoContainer = new flash.display.Sprite();
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.rateLabel.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.rateLabel.text = App.utils.locale.makeString(MENU.EXCHANGE_RATE);
            var loc1:*;
            this.rate_part_1.textField.autoSize = loc1 = flash.text.TextFieldAutoSize.LEFT;
            this.rate_part_2.textField.autoSize = loc1;
            this.rate_part_1.text = "1";
            this.rate_part_1.validateNow();
            this.infoContainer.addChild(this.rateLabel);
            this.infoContainer.addChild(this.rate_part_1);
            this.infoContainer.addChild(this.sign_mc);
            this.infoContainer.addChild(this.rate_part_2);
            this.isLayoutChanged = true;
            addChild(this.infoContainer);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=false;
            var loc2:*=NaN;
            var loc3:*=NaN;
            super.draw();
            if (this.isRatesDataChanged) 
            {
                this.isRatesDataChanged = false;
                loc1 = !(this.rate == this.actionRate) && !(this.actionRate == 0);
                var loc4:*;
                this.rate_part_2.filters = loc4 = null;
                this.rate_part_1.filters = loc4;
                this.rate_part_1.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(this.rate_part_1.icon);
                this.rate_part_2.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(this.rate_part_2.icon);
                loc2 = 100 * (this.actionRate - this.rate) / this.rate;
                DebugUtils.LOG_DEBUG(loc2, this.actionRate, this.rate);
                this.discountMc.text = (loc2 >= 0 ? "+" : "-") + Math.round(Math.abs(loc2)) + "%";
                this.actualRate = loc1 ? this.actionRate : this.rate;
                this.discountMc.visible = loc1;
                this.action_decor.visible = loc1;
                this.usual_decor.visible = !loc1;
                this.sign_mc.gotoAndStop(loc1 ? 2 : 1);
                this.isApplyRates = true;
                this.isLayoutChanged = true;
            }
            if (this.isApplyRates) 
            {
                this.isApplyRates = false;
                this.applyRateText();
                this.isLayoutChanged = true;
            }
            if (this.isLayoutChanged) 
            {
                this.isLayoutChanged = false;
                this.rate_part_1.x = Math.round(this.rateLabel.width + CENTER_PADDING);
                this.sign_mc.x = Math.round(this.rate_part_1.x + this.rate_part_1.actualWidth + EQUALS_SIGN_PADDING);
                this.rate_part_2.x = Math.round(this.sign_mc.x + this.sign_mc.width + EQUALS_SIGN_PADDING);
                loc3 = this.rate_part_2.x + this.rate_part_2.actualWidth;
                this.infoContainer.x = width - loc3 >> 1;
                if (loc1) 
                {
                    this.infoContainer.x = this.infoContainer.x + ACTION_CENTER_OFFSET;
                    this.discountMc.x = this.infoContainer.x + loc3 + DISCOUNT_MC_PADDING;
                }
            }
            return;
        }

        internal function applyRateText():void
        {
            var loc1:*=App.utils.locale;
            if (this._rateLabelFunction == null) 
            {
                this.rate_part_2.text = loc1.gold(this.actualRate);
            }
            else 
            {
                this.rate_part_2.text = this._rateLabelFunction(this.actualRate);
            }
            this.rate_part_2.validateNow();
            return;
        }

        public function setRates(arg1:uint, arg2:uint):void
        {
            this.actionRate = arg2;
            this.rate = arg1;
            this.isRatesDataChanged = true;
            invalidate();
            return;
        }

        public function set rateLabelFunction(arg1:Function):void
        {
            this._rateLabelFunction = arg1;
            this.isApplyRates = true;
            invalidate();
            return;
        }

        internal static const CENTER_PADDING:uint=20;

        internal static const ACTION_CENTER_OFFSET:int=-8;

        internal static const EQUALS_SIGN_PADDING:int=-2;

        internal static const DISCOUNT_MC_PADDING:int=-5;

        public var rate_part_1:net.wg.gui.components.controls.IconText;

        public var rate_part_2:net.wg.gui.components.controls.IconText;

        public var sign_mc:flash.display.MovieClip;

        public var rateLabel:flash.text.TextField;

        public var action_decor:flash.display.MovieClip;

        public var usual_decor:flash.display.MovieClip;

        public var discountMc:net.wg.gui.lobby.window.DiscountMC;

        internal var actionRate:uint;

        internal var rate:uint;

        internal var isRatesDataChanged:Boolean;

        internal var isApplyRates:Boolean;

        internal var _rateLabelFunction:Function;

        internal var actualRate:uint;

        internal var infoContainer:flash.display.Sprite;

        internal var isLayoutChanged:Boolean;
    }
}
