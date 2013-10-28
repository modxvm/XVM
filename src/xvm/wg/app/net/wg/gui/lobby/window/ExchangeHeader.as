package net.wg.gui.lobby.window
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.IconText;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import net.wg.utils.ILocale;


   public class ExchangeHeader extends UIComponent
   {
          
      public function ExchangeHeader() {
         this.infoContainer = new Sprite();
         super();
      }

      private static const CENTER_PADDING:uint = 20;

      private static const ACTION_CENTER_OFFSET:int = -8;

      private static const EQUALS_SIGN_PADDING:int = -2;

      private static const DISCOUNT_MC_PADDING:int = -5;

      public var rate_part_1:IconText;

      public var rate_part_2:IconText;

      public var sign_mc:MovieClip;

      public var rateLabel:TextField;

      public var action_decor:MovieClip;

      public var usual_decor:MovieClip;

      public var discountMc:DiscountMC;

      private var actionRate:uint;

      private var rate:uint;

      private var isRatesDataChanged:Boolean;

      private var isApplyRates:Boolean;

      private var _rateLabelFunction:Function;

      private var actualRate:uint;

      private var infoContainer:Sprite;

      private var isLayoutChanged:Boolean;

      override protected function configUI() : void {
         super.configUI();
         this.rateLabel.autoSize = TextFieldAutoSize.LEFT;
         this.rateLabel.text = App.utils.locale.makeString(MENU.EXCHANGE_RATE);
         this.rate_part_2.textField.autoSize = this.rate_part_1.textField.autoSize = TextFieldAutoSize.LEFT;
         this.rate_part_1.text = "1";
         this.rate_part_1.validateNow();
         this.infoContainer.addChild(this.rateLabel);
         this.infoContainer.addChild(this.rate_part_1);
         this.infoContainer.addChild(this.sign_mc);
         this.infoContainer.addChild(this.rate_part_2);
         this.isLayoutChanged = true;
         addChild(this.infoContainer);
      }

      override protected function draw() : void {
         var _loc1_:* = false;
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         super.draw();
         if(this.isRatesDataChanged)
         {
            this.isRatesDataChanged = false;
            _loc1_ = !(this.rate == this.actionRate) && !(this.actionRate == 0);
            this.rate_part_1.filters = this.rate_part_2.filters = null;
            this.rate_part_1.filters = ExchangeUtils.getGlow(this.rate_part_1.icon);
            this.rate_part_2.filters = ExchangeUtils.getGlow(this.rate_part_2.icon);
            _loc2_ = 100 * (this.actionRate - this.rate) / this.rate;
            this.discountMc.text = (_loc2_ >= 0?"+":"-") + Math.round(Math.abs(_loc2_)) + "%";
            this.actualRate = _loc1_?this.actionRate:this.rate;
            this.discountMc.visible = _loc1_;
            this.action_decor.visible = _loc1_;
            this.usual_decor.visible = !_loc1_;
            this.sign_mc.gotoAndStop(_loc1_?2:1);
            this.isApplyRates = true;
            this.isLayoutChanged = true;
         }
         if(this.isApplyRates)
         {
            this.isApplyRates = false;
            this.applyRateText();
            this.isLayoutChanged = true;
         }
         if(this.isLayoutChanged)
         {
            this.isLayoutChanged = false;
            this.rate_part_1.x = Math.round(this.rateLabel.width + CENTER_PADDING);
            this.sign_mc.x = Math.round(this.rate_part_1.x + this.rate_part_1.actualWidth + EQUALS_SIGN_PADDING);
            this.rate_part_2.x = Math.round(this.sign_mc.x + this.sign_mc.width + EQUALS_SIGN_PADDING);
            _loc3_ = this.rate_part_2.x + this.rate_part_2.actualWidth;
            this.infoContainer.x = width - _loc3_ >> 1;
            if(_loc1_)
            {
               this.infoContainer.x = this.infoContainer.x + ACTION_CENTER_OFFSET;
               this.discountMc.x = this.infoContainer.x + _loc3_ + DISCOUNT_MC_PADDING;
            }
         }
      }

      private function applyRateText() : void {
         var _loc1_:ILocale = App.utils.locale;
         if(this._rateLabelFunction != null)
         {
            this.rate_part_2.text = this._rateLabelFunction(this.actualRate);
         }
         else
         {
            this.rate_part_2.text = _loc1_.gold(this.actualRate);
         }
         this.rate_part_2.validateNow();
      }

      public function setRates(param1:uint, param2:uint) : void {
         this.actionRate = param2;
         this.rate = param1;
         this.isRatesDataChanged = true;
         invalidate();
      }

      public function set rateLabelFunction(param1:Function) : void {
         this._rateLabelFunction = param1;
         this.isApplyRates = true;
         invalidate();
      }
   }

}