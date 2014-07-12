package net.wg.gui.lobby.profile.pages.statistics.detailedStatistics
{
   import net.wg.gui.components.common.containers.GroupEx;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.profile.pages.statistics.body.DetailedStatisticsUnit;
   import scaleform.clik.constants.InvalidationType;
   
   public class DetailedStatisticsGroupEx extends GroupEx
   {
      
      public function DetailedStatisticsGroupEx() {
         super();
      }
      
      private static const UNIT_RENDERER_INVALID:String = "unitRendInv";
      
      private var _unitRendererClass:Class;
      
      override protected function configUI() : void {
         super.configUI();
         itemRendererClass = App.utils.classFactory.getClass(Linkages.DETAILED_STATISTICS_UNIT);
      }
      
      override protected function draw() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:DetailedStatisticsUnit = null;
         super.draw();
         if((isInvalid(UNIT_RENDERER_INVALID,InvalidationType.DATA)) && (this._unitRendererClass))
         {
            _loc1_ = numChildren;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = DetailedStatisticsUnit(getChildAt(_loc2_));
               _loc3_.itemRendererClass = this._unitRendererClass;
               _loc2_++;
            }
         }
      }
      
      public function get unitRendererClass() : Class {
         return this._unitRendererClass;
      }
      
      public function set unitRendererClass(param1:Class) : void {
         if(this._unitRendererClass != param1)
         {
            this._unitRendererClass = param1;
            invalidate(UNIT_RENDERER_INVALID,LAYOUT_INVALID);
         }
      }
      
      override protected function onDispose() : void {
         this._unitRendererClass = null;
         super.onDispose();
      }
   }
}
