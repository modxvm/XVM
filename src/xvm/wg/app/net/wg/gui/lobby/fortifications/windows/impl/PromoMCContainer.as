package net.wg.gui.lobby.fortifications.windows.impl
{
    import net.wg.gui.lobby.profile.components.SimpleLoader;
    
    public class PromoMCContainer extends SimpleLoader
    {
        
        public function PromoMCContainer() {
            super();
            setSource(RES_FORT.MAPS_FORT_WELCOMESCREEN);
        }
        
        override protected function onLoadingComplete() : void {
            super.onLoadingComplete();
            loader.visible = true;
        }
        
        override protected function onDispose() : void {
            super.onDispose();
        }
    }
}
