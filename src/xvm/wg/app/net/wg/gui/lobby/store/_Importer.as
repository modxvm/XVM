package net.wg.gui.lobby.store 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.store.ComplexListItemRenderer, net.wg.gui.lobby.store.ModuleRendererCredits, net.wg.gui.lobby.store.NationFilter, net.wg.gui.lobby.store.Store, net.wg.gui.lobby.store.StoreListItemRenderer, net.wg.gui.lobby.store.StoreTable, net.wg.gui.lobby.store.TableHeader, net.wg.gui.lobby.store.TableHeaderInfo]));
            return;
        }
    }
}
