package net.wg.gui.components.common.crosshair
{
   import flash.display.MovieClip;
   
   public class CrosshairStrategic extends CrosshairBase
   {
      
      public function CrosshairStrategic() {
         super();
      }
      
      private static const NODE_TYPE_RED:String = "red";
      
      private static const NODE_TYPE_GREEN:String = "green";
      
      private static const NODE_TYPE_DEBUG:String = "debug";
      
      private static const NODES_COUNT:uint = 37;
      
      private static const NODE_NAME_BASE:String = "elem_";
      
      override protected function initCallbacks() : void {
      }
      
      override protected function onSetReloading(param1:Number, param2:Number, param3:Boolean, param4:Number = 0) : void {
         this.radiusNodesGotoAndStop(param1 == 0?NODE_TYPE_GREEN:NODE_TYPE_RED);
      }
      
      override protected function onSetReloadingAsPercent(param1:Number) : void {
         this.radiusNodesGotoAndStop(param1 < 100?NODE_TYPE_RED:NODE_TYPE_GREEN);
      }
      
      protected function onSetAsDebug() : void {
         this.radiusNodesGotoAndStop(NODE_TYPE_DEBUG);
      }
      
      private function radiusNodesGotoAndStop(param1:String) : void {
         var _loc2_:* = 1;
         while(_loc2_ <= NODES_COUNT)
         {
            (getChildByName(NODE_NAME_BASE + _loc2_) as MovieClip).gotoAndStop(param1);
            _loc2_++;
         }
      }
   }
}
