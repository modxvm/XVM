package net.wg.gui.cyberSport.vo
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([ActionButtonVO,AutoSearchVO,CSCommandVO,UnitCandidateVO,UnitSlotVO,UnitVO,VehicleSelectorFilterVO,VehicleSelectorItemVO]));
      }
   }

}