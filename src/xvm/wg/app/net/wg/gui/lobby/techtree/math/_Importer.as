package net.wg.gui.lobby.techtree.math 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.techtree.math.ADG_ItemLevelsBuilder, net.wg.gui.lobby.techtree.math.HungarianAlgorithm, net.wg.gui.lobby.techtree.math.MatrixPosition]));
            return;
        }
    }
}
