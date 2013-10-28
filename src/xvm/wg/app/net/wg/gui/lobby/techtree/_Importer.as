package net.wg.gui.lobby.techtree
{
   import net.wg.infrastructure.BaseImporter;
   import net.wg.gui.lobby.techtree.constants._Importer;
   import net.wg.gui.lobby.techtree.controls._Importer;
   import net.wg.gui.lobby.techtree.data._Importer;
   import net.wg.gui.lobby.techtree.helpers._Importer;
   import net.wg.gui.lobby.techtree.math._Importer;
   import net.wg.gui.lobby.techtree.nodes._Importer;
   import net.wg.gui.lobby.techtree.sub._Importer;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([MenuHandler,ResearchPage,TechTreeEvent,TechTreePage,net.wg.gui.lobby.techtree.constants._Importer,net.wg.gui.lobby.techtree.controls._Importer,net.wg.gui.lobby.techtree.data._Importer,net.wg.gui.lobby.techtree.helpers._Importer,net.wg.gui.lobby.techtree.math._Importer,net.wg.gui.lobby.techtree.nodes._Importer,net.wg.gui.lobby.techtree.sub._Importer]));
      }
   }

}