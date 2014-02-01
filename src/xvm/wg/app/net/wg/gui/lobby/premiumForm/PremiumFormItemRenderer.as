package net.wg.gui.lobby.premiumForm
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.RadioButton;
   import net.wg.gui.components.controls.IconText;
   import flash.display.MovieClip;
   import net.wg.data.constants.SoundTypes;
   import flash.events.MouseEvent;


   public class PremiumFormItemRenderer extends SoundListItemRenderer
   {
          
      public function PremiumFormItemRenderer() {
         super();
         buttonMode = true;
         enabled = false;
      }

      private static const PRICE_POSITION:String = "pricePosition";

      private static const NORMAL_PRICE_WIDTH:Number = 190;

      private static const ACTION_PRICE_POS:Number = 79;

      public var pdays:RadioButton;

      public var discount:DiscountPrice;

      public var price:IconText;

      public var radioSelection:MovieClip;

      public var _userGold:Number;

      private var days:String = null;

      override protected function draw() : void {
         super.draw();
         if((isInvalid(PRICE_POSITION)) && !(data == null))
         {
            if(data.isDiscountPackage)
            {
               this.price.x = ACTION_PRICE_POS;
            }
            else
            {
               this.price.x = Math.round(this.discount.x + this.discount.width - this.price.width);
            }
         }
      }

      override protected function configUI() : void {
         soundType = SoundTypes.RNDR_NORMAL;
         this.price.text = "";
         this.price.textField.text = "";
         this.pdays.label = "";
         this.pdays.visible = this.price.visible = false;
         this.price.width = NORMAL_PRICE_WIDTH;
         this.radioSelection.width = this.width;
         this.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.addEventListener(MouseEvent.ROLL_OVER,this.onMouseOverHandler);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onMouseOutHandler);
         this.updateSelection();
         super.configUI();
         this.updateData();
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOutHandler);
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
      }

      override public function setData(param1:Object) : void {
         if(param1 == null)
         {
            return;
         }
         super.setData(param1);
         this.days = MENU.premium_periods("days" + String(param1.days));
         this.updateData();
      }

      private function updateData() : void {
         this.updateDiscountPercent(this.getDiscountPercent(data.price,data.discountPrice));
         this.price.text = App.utils.locale.gold(data.discountPrice);
         this.price.toolTip = this.days;
         this.pdays.label = this.days;
         this.pdays.data =
            {
               "isUserSelected":false,
               "days":data.days,
               "price":data.discountPrice
            }
         ;
         this.pdays.visible = this.price.visible = true;
         this.pdays.validateNow();
         this.gold = data.userGold;
         this.selected = data.isUserSelected;
         invalidate(PRICE_POSITION);
      }

      private function updateDiscountPercent(param1:Number) : void {
         var _loc2_:* = param1 > 0;
         this.discount.visible = _loc2_;
         this.discount.quantity.text = _loc2_?"-" + param1 + "%":this.discount.quantity.text;
         this.price.icon = _loc2_?"goldDiscount":"gold";
      }

      private function getDiscountPercent(param1:Number, param2:Number) : Number {
         var _loc3_:Number = 0;
         if(param2 > 0)
         {
            _loc3_ = Math.round(100 - param2 / param1 * 100);
         }
         else
         {
            DebugUtils.LOG_ERROR("discountPrice must be greater than 0");
         }
         return _loc3_;
      }

      override public function set selected(param1:Boolean) : void {
         super.selected = param1;
         this.pdays.selected = param1;
         if(data)
         {
            data.isUserSelected = param1;
         }
         this.updateSelection();
      }

      private function updateSelection() : void {
         this.radioSelection.visible = this.pdays.selected;
      }

      public function set gold(param1:Number) : void {
         this._userGold = param1;
         this.pdays.enabled = enabled = focusable = this._userGold >= data.discountPrice;
      }

      private function onClickHandler(param1:MouseEvent) : void {
         data.isUserSelected = true;
         this.updateSelection();
         invalidateData();
      }

      private function onMouseOverHandler(param1:MouseEvent) : void {
         App.toolTipMgr.showSpecial(this.price.toolTip,null);
      }

      private function onMouseOutHandler(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      override protected function handlePress(param1:uint=0) : void {
         if(enabled == false)
         {
            return;
         }
         super.handlePress(param1);
      }
   }

}