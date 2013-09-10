package net.wg.gui.lobby.dialogs 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.dialogs.SimpleDialog, net.wg.gui.lobby.dialogs.IconDialog, net.wg.gui.lobby.dialogs.IconDialog, net.wg.gui.lobby.dialogs.IconPriceDialog, net.wg.gui.lobby.dialogs.DemountDeviceDialog, net.wg.gui.lobby.dialogs.DestroyDeviceDialog, net.wg.gui.lobby.dialogs.PriceMc, net.wg.gui.lobby.dialogs.DismissTankmanDialog]));
            return;
        }
    }
}
