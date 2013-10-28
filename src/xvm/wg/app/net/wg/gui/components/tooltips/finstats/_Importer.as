package net.wg.gui.components.tooltips.finstats
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([EfficiencyBlock,EfficiencyCritsBlock]));
      }
   }

}