package net.wg.gui.lobby.demonstration 
{
    import __AS3__.vec.*;
    import net.wg.gui.lobby.demonstration.data.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.demonstration.DemonstratorWindow, net.wg.gui.lobby.demonstration.MapItemRenderer, net.wg.gui.lobby.demonstration.data.DemonstratorVO, net.wg.gui.lobby.demonstration.data.MapItemVO]));
            return;
        }
    }
}
