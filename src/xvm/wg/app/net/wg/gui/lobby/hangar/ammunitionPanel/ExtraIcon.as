package net.wg.gui.lobby.hangar.ammunitionPanel 
{
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class ExtraIcon extends net.wg.gui.lobby.profile.components.SimpleLoader implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function ExtraIcon()
        {
            super();
            return;
        }

        protected override function startLoading(arg1:String):void
        {
            super.startLoading(arg1);
            loader.visible = false;
            return;
        }

        protected override function onLoadingComplete():void
        {
            super.onLoadingComplete();
            loader.visible = true;
            return;
        }

        public static const EXTRA_ICON_PROP_NAME:String="extraModuleInfo";
    }
}
