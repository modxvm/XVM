package net.wg.gui.lobby.techtree.math
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([ADG_ItemLevelsBuilder,HungarianAlgorithm,MatrixPosition]));
      }
   }

}