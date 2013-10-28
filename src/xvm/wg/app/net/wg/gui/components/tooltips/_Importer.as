package net.wg.gui.components.tooltips
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([ToolTipVehicle,ToolTipTankmen,ToolTipEquipment,ToolTipAchievement,ToolTipTankClass,AchievementsCustomBlockItem,ToolTipBase,ToolTipSpecial,Status,ToolTipComplex,ToolTipBuySkill,ToolTipSkill,ToolTipRSSNews,ToolTipFinalStats,ToolTipIGR,IgrQuestBlock,IgrQuestProgressBlock,ToolTipSuitableVehicle,TooltipUnitCommand,ToolTipSelectedVehicle,SuitableVehicleBlockItem,Separator]));
      }
   }

}