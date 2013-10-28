package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([CommonStatistics,AxisPointLevels,ProfileStatisticsVO,StatisticBarChartInitializer,ProfileStatisticsDetailVO,AxisPointNations,AxisPointTypes,LevelsStatisticChart,NationsStatisticsChart,ProfileStatistics,StatisticBarChartAxisPoint,StatisticBarChartItem,NationBarChartItem,LevelBarChartItem,TypeBarChartItem,StatisticBarChartLayout,StatisticChartInfo,StatisticsBarChart,StatisticsBarChartAxis,StatisticsInitVO,TechniqueStatistics,TfContainer,StatisticsChartsUtils,TypesStatisticsChart]));
      }
   }

}