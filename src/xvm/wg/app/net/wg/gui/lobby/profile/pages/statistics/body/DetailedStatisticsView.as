package net.wg.gui.lobby.profile.pages.statistics.body
{
   import net.wg.gui.lobby.profile.pages.statistics.detailedStatistics.DetailedStatisticsGroupEx;
   import net.wg.gui.lobby.profile.components.IResizableContent;
   import net.wg.gui.components.common.containers.EqualGapsHorizontalLayout;
   import flash.display.InteractiveObject;


   public class DetailedStatisticsView extends DetailedStatisticsGroupEx implements IResizableContent
   {
          
      public function DetailedStatisticsView() {
         super();
      }

      override protected function configUI() : void {
         super.configUI();
         layout = new EqualGapsHorizontalLayout();
         unitRendererClass = App.utils.classFactory.getClass("StatisticsDashLineTextItemIRenderer_UI");
      }

      public function update(param1:Object) : void {
         var _loc2_:* = 0;
         if((param1) && param1.length > _loc2_)
         {
            dataProvider = DetailedLabelDataVO(param1[_loc2_]).detailedInfoList;
         }
      }

      public function getComponentForFocus() : InteractiveObject {
         return null;
      }

      public function setViewSize(param1:Number, param2:Number) : void {
         EqualGapsHorizontalLayout(layout).availableSize = param1;
         invalidate(LAYOUT_INVALID);
      }

      public function set centerOffset(param1:int) : void {
          
      }

      public function get centerOffset() : int {
         return 0;
      }

      public function set active(param1:Boolean) : void {
          
      }

      public function get active() : Boolean {
         return false;
      }
   }

}