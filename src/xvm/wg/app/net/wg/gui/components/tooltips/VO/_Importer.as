package net.wg.gui.components.tooltips.VO
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([VehicleVO,VehicleBaseVO,TankmenVO,EquipmentVO,AchievementVO,ToolTipBlockVO,ToolTipBlockRightListItemVO,ToolTipBlockResultVO,ToolTipStatusColorsVO,ToolTipFinalStatsVO,Dimension,SuitableVehicleVO,IgrVO,ToolTipVehicleSelectedVO,UnitCommandVO]));
      }
   }

}