package net.wg.gui.lobby.profile.components.chart
{
   import scaleform.clik.constants.InvalidationType;
   
   public class ChartItem extends ChartItemBase
   {
      
      public function ChartItem() {
         super();
      }
      
      private static const VALUE_INV:String = "valInv";
      
      private var _value:Number = 0;
      
      override public function setData(param1:Object) : void {
         super.setData(param1);
         invalidate(InvalidationType.DATA);
         var _loc2_:* = "percentValue";
         if(_data.hasOwnProperty(_loc2_))
         {
            this.value = _data[_loc2_];
         }
         else if(!isNaN(Number(_data)))
         {
            this.value = Number(_data);
         }
         
      }
      
      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.applyDataChange();
            invalidate(VALUE_INV);
         }
         if(isInvalid(VALUE_INV))
         {
            this.applyValueChange();
         }
      }
      
      protected function applyDataChange() : void {
      }
      
      protected function applyValueChange() : void {
      }
      
      public function get value() : Number {
         return this._value;
      }
      
      public function set value(param1:Number) : void {
         this._value = param1;
         invalidate(VALUE_INV);
      }
   }
}
