package net.wg.gui.lobby.vehicleInfo
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.data.constants.Errors;
   
   public class VehicleInfoBase extends UIComponent implements IViewStackContent
   {
      
      public function VehicleInfoBase() {
         super();
      }
      
      private var _data:Array;
      
      private var yOffset:Number = 19;
      
      private var startY:Number = 10;
      
      private var startX:Number = 10;
      
      override protected function onDispose() : void {
         super.onDispose();
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
      
      override public function toString() : String {
         return "[WG VehicleInfoBase " + name + "]";
      }
      
      public function update(param1:Object) : void {
         var _loc3_:BaseBlock = null;
         this._data = param1 as Array;
         var _loc2_:uint = 0;
         while(_loc2_ < this._data.length)
         {
            _loc3_ = new BaseBlock();
            _loc3_.setData(this._data[_loc2_]);
            _loc3_.x = this.startX;
            _loc3_.y = this.startY + _loc2_ * this.yOffset;
            this.addChild(_loc3_);
            _loc2_++;
         }
      }
      
      public function getComponentForFocus() : InteractiveObject {
         throw new AbstractException("VehicleInfoBase::componentForFocus" + Errors.ABSTRACT_INVOKE);
      }
      
      public function canShowAutomatically() : Boolean {
         return true;
      }
   }
}
