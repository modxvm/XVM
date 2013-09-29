package net.wg.gui.lobby.store.views 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.store.views.EquipmentView, net.wg.gui.lobby.store.views.ModuleView, net.wg.gui.lobby.store.views.OptionalDeviceView, net.wg.gui.lobby.store.views.ShellView, net.wg.gui.lobby.store.views.VehicleView]));
            return;
        }
    }
}
