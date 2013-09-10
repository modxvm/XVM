package net.wg.gui.lobby.browser 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.browser.BrowserActionBtn, net.wg.gui.lobby.browser.BrowserEvent, net.wg.gui.lobby.browser.BrowserHitArea, net.wg.gui.lobby.browser.BrowserWindow]));
            return;
        }
    }
}
