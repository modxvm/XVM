package net.wg.gui.lobby.store.shop 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.store.shop.Shop, net.wg.gui.lobby.store.shop.ShopModuleListItemRenderer, net.wg.gui.lobby.store.shop.ShopVehicleListItemRenderer]));
            return;
        }
    }
}
