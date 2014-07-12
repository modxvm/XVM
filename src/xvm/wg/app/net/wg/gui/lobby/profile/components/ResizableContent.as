package net.wg.gui.lobby.profile.components
{
   import scaleform.clik.core.UIComponent;
   import flash.geom.Point;
   import flash.display.InteractiveObject;
   
   public class ResizableContent extends UIComponent implements IResizableContent
   {
      
      public function ResizableContent() {
         super();
      }
      
      protected var currentDimension:Point;
      
      private var _centerOffset:int;
      
      private var isActive:Boolean;
      
      override protected function draw() : void {
         super.draw();
         if((isInvalid(ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID)) && (this.currentDimension))
         {
            this.applyResizing();
         }
         if(isInvalid(ResizableInvalidationTypes.ACTIVE_INVALID))
         {
            this.applyActivation();
         }
      }
      
      protected function applyActivation() : void {
      }
      
      protected function applyResizing() : void {
      }
      
      public function setViewSize(param1:Number, param2:Number) : void {
         if(!this.currentDimension)
         {
            this.currentDimension = new Point();
         }
         this.currentDimension.x = param1;
         this.currentDimension.y = param2;
         invalidate(ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID);
      }
      
      public function set active(param1:Boolean) : void {
         this.isActive = param1;
         invalidate(ResizableInvalidationTypes.ACTIVE_INVALID);
      }
      
      public function get active() : Boolean {
         return this.isActive;
      }
      
      public function set centerOffset(param1:int) : void {
         this._centerOffset = param1;
         invalidate(ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID);
      }
      
      public function get centerOffset() : int {
         return this._centerOffset;
      }
      
      public function update(param1:Object) : void {
      }
      
      public function getComponentForFocus() : InteractiveObject {
         return null;
      }
      
      public function canShowAutomatically() : Boolean {
         return true;
      }
   }
}
