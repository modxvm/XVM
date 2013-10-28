package net.wg.gui.components.common.crosshair
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([ClipQuantityBar,CrosshairBase,CrosshairPanelArcade,CrosshairPanelBase,CrosshairPanelPostmortem,CrosshairPanelSniper,CrosshairPanelStrategic,CrosshairSniper,CrosshairStrategic,ReloadingTimer]));
      }
   }

}