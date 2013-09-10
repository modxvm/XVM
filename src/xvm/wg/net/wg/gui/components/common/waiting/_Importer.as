package net.wg.gui.components.common.waiting 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.components.common.waiting.WaitingView, net.wg.gui.components.common.waiting.WaitingMc, net.wg.gui.components.common.waiting.WaitingComponent, net.wg.gui.components.common.waiting.Waiting]));
            return;
        }
    }
}
