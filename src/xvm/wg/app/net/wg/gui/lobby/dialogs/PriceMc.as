package net.wg.gui.lobby.dialogs
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.lobby.profile.components.DashLine;
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconText;


   public class PriceMc extends UIComponent
   {
          
      public function PriceMc() {
         super();
      }

      private static const OPERATION_INVALID:String = "opInv";

      public var dashLine:DashLine;

      public var textField:TextField;

      public var priceValue:IconText;

      private var _allowed:Boolean = true;

      private var normalTextColor:uint = 0;

      override protected function configUI() : void {
         super.configUI();
         this.dashLine.width = 305;
         this.normalTextColor = this.priceValue.textColor;
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(OPERATION_INVALID))
         {
            this.priceValue.textColor = this._allowed?this.normalTextColor:16711680;
         }
      }

      public function set allowed(param1:Boolean) : void {
         this._allowed = param1;
         invalidate(OPERATION_INVALID);
      }
   }

}