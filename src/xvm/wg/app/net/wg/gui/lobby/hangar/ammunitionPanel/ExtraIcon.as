package net.wg.gui.lobby.hangar.ammunitionPanel
{
    import net.wg.gui.lobby.profile.components.SimpleLoader;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    
    public class ExtraIcon extends SimpleLoader implements IDisposable
    {
        
        public function ExtraIcon() {
            super();
        }
        
        public static var EXTRA_ICON_PROP_NAME:String = "extraModuleInfo";
        
        override protected function startLoading(param1:String) : void {
            super.startLoading(param1);
            loader.visible = false;
        }
        
        override protected function onLoadingComplete() : void {
            super.onLoadingComplete();
            loader.visible = true;
        }
    }
}
