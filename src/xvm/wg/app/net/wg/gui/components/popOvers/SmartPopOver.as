package net.wg.gui.components.popOvers
{
   import flash.geom.Point;


   public class SmartPopOver extends PopOver
   {
          
      public function SmartPopOver() {
         super();
         visible = false;
      }

      override protected function initLayout() : void {
         layout = new SmartPopOverExternalLayout();
      }

      override protected function invokeLayout() : void {
         var _loc1_:SmartPopOverExternalLayout = SmartPopOverExternalLayout(layout);
         if((_loc1_.positionKeyPoint) && (_loc1_.stageDimensions))
         {
            visible = true;
            super.invokeLayout();
         }
      }

      public function setPositionKeyPoint(param1:int, param2:int) : void {
         SmartPopOverExternalLayout(layout).positionKeyPoint = new Point(param1,param2);
         invalidateLayout();
      }

      public function setStageDimensions(param1:int, param2:int) : void {
         SmartPopOverExternalLayout(layout).stageDimensions = new Point(param1,param2);
         invalidateLayout();
      }
   }

}