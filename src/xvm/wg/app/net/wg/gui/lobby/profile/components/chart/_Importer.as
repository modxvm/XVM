package net.wg.gui.lobby.profile.components.chart
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([AxisChart,BarItem,ChartBase,ChartItem,ChartItemBase,FrameChartItem,IChartItem]));
      }
   }

}