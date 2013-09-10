package net.wg.gui.lobby.techtree.nodes 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.techtree.nodes.FakeNode, net.wg.gui.lobby.techtree.nodes.NationTreeNode, net.wg.gui.lobby.techtree.nodes.Renderer, net.wg.gui.lobby.techtree.nodes.ResearchItem, net.wg.gui.lobby.techtree.nodes.ResearchRoot]));
            return;
        }
    }
}
