package net.wg.gui.components.common 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.components.common.CursorManagedContainer, net.wg.gui.components.common.ManagedContainer, net.wg.gui.components.common.MainViewContainer]));
            return;
        }
    }
}
