package net.wg.gui.lobby.techtree.nodes
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([FakeNode,NationTreeNode,Renderer,ResearchItem,ResearchRoot]));
      }
   }

}