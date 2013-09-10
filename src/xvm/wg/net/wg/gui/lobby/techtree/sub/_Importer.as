package net.wg.gui.lobby.techtree.sub 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.techtree.sub.NationTree, net.wg.gui.lobby.techtree.sub.ResearchItems]));
            return;
        }
    }
}
