package net.wg.gui.lobby.dialogs
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.lobby.profile.components.DashLine;
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.data.constants.IconsTypes;


   public class PriceMc extends UIComponent
   {
          
      public function PriceMc() {
         super();
      }

      public static var IS_INVALID_PRICE:String = "isInvalidPrice";

      private static const OPERATION_INVALID:String = "opInv";

      public var dashLine:DashLine;

      public var textField:TextField;

      public var priceValue:IconText;

      public var actionPrice:ActionPrice;

      private var _allowed:Boolean = true;

      private var normalTextColor:uint = 0;

      private var _price:Number = 0;

      private var _defPrice:Number = 0;

      private var _currency:String = "";

      private var _actionPrc:Number = 0;

      public function set allowed(param1:Boolean) : void {
         this._allowed = param1;
         invalidate(OPERATION_INVALID);
      }

      public function get price() : Number {
         return this._price;
      }

      public function set price(param1:Number) : void {
         this._price = param1;
         invalidate(IS_INVALID_PRICE);
      }

      public function get defPrice() : Number {
         return this._defPrice;
      }

      public function set defPrice(param1:Number) : void {
         this._defPrice = param1;
         invalidate(IS_INVALID_PRICE);
      }

      public function get currency() : String {
         return this._currency;
      }

      public function set currency(param1:String) : void {
         this._currency = param1;
         invalidate(IS_INVALID_PRICE);
      }

      public function get actionPrc() : Number {
         return this._actionPrc;
      }

      public function set actionPrc(param1:Number) : void {
         this._actionPrc = param1;
         invalidate(IS_INVALID_PRICE);
      }

      override protected function configUI() : void {
         super.configUI();
         this.dashLine.width = 305;
         this.normalTextColor = this.priceValue.textColor;
      }

      override protected function draw() : void {
         var _loc1_:ActionPriceVO = null;
         super.draw();
         if(isInvalid(OPERATION_INVALID))
         {
            this.priceValue.textColor = this._allowed?this.normalTextColor:16711680;
            this.actionPrice.textColorType = this._allowed?ActionPrice.TEXT_COLOR_TYPE_ICON:ActionPrice.TEXT_COLOR_TYPE_ERROR;
         }
         if(isInvalid(IS_INVALID_PRICE))
         {
            this.priceValue.text = this._currency == IconsTypes.GOLD?App.utils.locale.gold(this._price):App.utils.locale.integer(this._price);
            this.priceValue.icon = this._currency;
            _loc1_ = new ActionPriceVO(this._actionPrc,this._price,this._defPrice,this._currency);
            this.actionPrice.setData(_loc1_);
            this.priceValue.visible = !this.actionPrice.visible;
         }
      }
   }

}