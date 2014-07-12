package net.wg.gui.lobby.vehicleInfo
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import flash.display.InteractiveObject;
   
   public class VehicleInfoCrew extends UIComponent implements IViewStackContent
   {
      
      public function VehicleInfoCrew() {
         super();
      }
      
      private var _data:Array;
      
      private var yOffset:Number = 19;
      
      private var startY:Number = 10;
      
      private var startX:Number = 10;
      
      public function update(param1:Object) : void {
         var _loc3_:CrewBlock = null;
         this._data = param1 as Array;
         var _loc2_:uint = 0;
         while(_loc2_ < this._data.length)
         {
            _loc3_ = new CrewBlock();
            _loc3_.setData(this._data[_loc2_]);
            _loc3_.x = this.startX;
            _loc3_.y = this.startY + this.yOffset * _loc2_;
            this.addChild(_loc3_);
            _loc2_++;
         }
      }
      
      override protected function onDispose() : void {
         super.onDispose();
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
      
      override public function toString() : String {
         return "[WG VehicleInfoCrew " + name + "]";
      }
      
      public function getComponentForFocus() : InteractiveObject {
         return null;
      }
      
      public function canShowAutomatically() : Boolean {
         return true;
      }
   }
}
