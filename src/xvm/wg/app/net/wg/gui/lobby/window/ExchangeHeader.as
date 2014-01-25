package net.wg.gui.lobby.window
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.IconText;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import net.wg.utils.ILocale;
   import net.wg.data.constants.IconsTypes;
   import net.wg.gui.utils.ComplexTooltipHelper;


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

      public var rateFrom:IconText;

      public var rateTo:IconText;

      public var sign_mc:MovieClip;

      public var rateLabel:TextField;

      public var action_decor:MovieClip;

      public var usual_decor:MovieClip;

      public var discountMc:MovieClip;

      public var actionHitMc:Sprite;

      private var actionRate:uint;

      private var rate:uint;

      private var actionPrc:Number = 0;

      private var isRatesDataChanged:Boolean;

      private var isApplyRates:Boolean;

      private var _rateLabelFunction:Function;

      private var actualRate:uint;

      private var infoContainer:Sprite;

      private var isLayoutChanged:Boolean;

      override protected function onDispose() : void {
         this.actionHitMc.removeEventListener(MouseEvent.MOUSE_OVER,this.onOverHandler);
         this.actionHitMc.removeEventListener(MouseEvent.MOUSE_OUT,this.onOutHandler);
         this.actionHitMc.removeEventListener(MouseEvent.MOUSE_DOWN,this.onPressHandler);
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

      override protected function configUI() : void {
         super.configUI();
         this.rateLabel.autoSize = TextFieldAutoSize.LEFT;
         this.rateLabel.text = App.utils.locale.makeString(MENU.EXCHANGE_RATE);
         this.rateTo.textField.autoSize = this.rateFrom.textField.autoSize = TextFieldAutoSize.LEFT;
         this.rateFrom.text = "1";
         this.rateFrom.validateNow();
         this.infoContainer.addChild(this.rateLabel);
         this.infoContainer.addChild(this.rateFrom);
         this.infoContainer.addChild(this.sign_mc);
         this.infoContainer.addChild(this.rateTo);
         this.isLayoutChanged = true;
         addChild(this.infoContainer);
         this.actionHitMc.addEventListener(MouseEvent.MOUSE_OVER,this.onOverHandler);
         this.actionHitMc.addEventListener(MouseEvent.MOUSE_OUT,this.onOutHandler);
         this.actionHitMc.addEventListener(MouseEvent.MOUSE_DOWN,this.onPressHandler);
         this.setChildIndex(this.actionHitMc,this.numChildren-1);
      }

      override protected function draw() : void {
         var _loc1_:* = false;
         var _loc2_:* = NaN;
         super.draw();
         if(this.isRatesDataChanged)
         {
            this.isRatesDataChanged = false;
            _loc1_ = !(this.rate == this.actionRate) && !(this.actionRate == 0);
            this.rateFrom.filters = this.rateTo.filters = null;
            this.rateFrom.filters = ExchangeUtils.getGlow(this.rateFrom.icon);
            this.rateTo.filters = ExchangeUtils.getGlow(this.rateTo.icon);
            this.actionPrc = _loc1_?100 * (this.actionRate - this.rate) / this.rate:0;
            this.discountMc.text = "%";
            this.actualRate = _loc1_?this.actionRate:this.rate;
            this.discountMc.visible = _loc1_;
            this.action_decor.visible = _loc1_;
            this.usual_decor.visible = !_loc1_;
            this.sign_mc.gotoAndStop(_loc1_?2:1);
            this.isApplyRates = true;
            this.isLayoutChanged = true;
            this.actionHitMc.visible = _loc1_;
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
            this.rateFrom.x = Math.round(this.rateLabel.width + CENTER_PADDING);
            this.sign_mc.x = Math.round(this.rateFrom.x + this.rateFrom.actualWidth + EQUALS_SIGN_PADDING);
            this.rateTo.x = Math.round(this.sign_mc.x + this.sign_mc.width + EQUALS_SIGN_PADDING);
            _loc2_ = this.rateTo.x + this.rateTo.actualWidth;
            this.infoContainer.x = width - _loc2_ >> 1;
            if(_loc1_)
            {
               this.infoContainer.x = this.infoContainer.x + ACTION_CENTER_OFFSET;
               this.discountMc.x = this.infoContainer.x + _loc2_ + DISCOUNT_MC_PADDING;
            }
         }
      }

      private function hideTooltip() : void {
         App.toolTipMgr.hide();
      }

      private function showTooltip() : void {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:ILocale = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc1_:* = "";
         var _loc2_:Number = this.rate;
         var _loc3_:Number = this.actionRate;
         if(this.actionPrc > 0 && !(_loc2_ == 0))
         {
            _loc4_ = this.rateFrom.icon;
            _loc5_ = this.rateTo.icon;
            _loc6_ = App.utils.locale;
            _loc7_ = App.utils.icons.getIcon16StrPath(_loc4_);
            _loc8_ = App.utils.icons.getIcon16StrPath(_loc5_);
            _loc9_ = _loc5_ == IconsTypes.GOLD?_loc6_.gold(Math.abs(_loc3_)):_loc6_.integer(Math.abs(_loc3_));
            _loc10_ = _loc5_ == IconsTypes.GOLD?_loc6_.gold(Math.abs(_loc2_)):_loc6_.integer(Math.abs(_loc2_));
            _loc9_ = " 1" + _loc7_ + "= " + _loc9_ + " " + _loc8_;
            _loc10_ = " 1" + _loc7_ + "= " + _loc10_ + " " + _loc8_;
            _loc1_ = new ComplexTooltipHelper().addHeader(_loc6_.makeString(TOOLTIPS.ACTIONPRICE_EXCHANGE_HEADER,{})).addBody(_loc6_.makeString(TOOLTIPS.ACTIONPRICE_EXCHANGE_BODY,
               {
                  "oldPrice":_loc10_,
                  "newPrice":_loc9_
               }
            )).make();
            if(_loc1_.length > 0)
            {
               App.toolTipMgr.showComplex(_loc1_);
            }
         }
         else
         {
            if(this.actionPrc < 0)
            {
            }
         }
      }

      private function applyRateText() : void {
         var _loc1_:ILocale = App.utils.locale;
         if(this._rateLabelFunction != null)
         {
            this.rateTo.text = this._rateLabelFunction(this.actualRate);
         }
         else
         {
            this.rateTo.text = _loc1_.gold(this.actualRate);
         }
         this.rateTo.validateNow();
      }

      private function onOverHandler(param1:MouseEvent) : void {
         this.showTooltip();
      }

      private function onOutHandler(param1:MouseEvent) : void {
         this.hideTooltip();
      }

      private function onPressHandler(param1:MouseEvent) : void {
         this.hideTooltip();
      }
   }

}