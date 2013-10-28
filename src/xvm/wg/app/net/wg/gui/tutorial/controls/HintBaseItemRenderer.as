package net.wg.gui.tutorial.controls
{
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.constants.InvalidationType;


   public class HintBaseItemRenderer extends UIComponent
   {
          
      public function HintBaseItemRenderer() {
         super();
      }

      protected var _data:Object;

      public function get data() : Object {
         return this._data;
      }

      public function set data(param1:Object) : void {
         this._data = param1;
         invalidate(InvalidationType.DATA);
      }

      override public function dispose() : void {
         super.dispose();
         this._data = null;
      }

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this._data))
         {
            this.drawData();
         }
      }

      protected function drawData() : void {
          
      }
   }

}