package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    
    public class CooldownIconLoaderCtnr extends UIComponentEx
    {
        
        public function CooldownIconLoaderCtnr() {
            super();
        }
        
        public var loader:UILoaderAlt = null;
        
        override protected function onDispose() : void {
            this.loader.dispose();
            this.loader = null;
            super.onDispose();
        }
    }
}
