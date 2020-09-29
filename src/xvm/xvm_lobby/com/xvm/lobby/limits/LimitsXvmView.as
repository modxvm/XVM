/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.limits
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.events.*;
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class LimitsXvmView extends XvmViewBase
    {
        private var limits_ui:ILimitsUI = null;

        public function LimitsXvmView(view:IView)
        {
            super(view);
        }

        public function get page():LobbyPage
        {
            return super.view as LobbyPage;
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            super.onAfterPopulate(e);
            setup();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            super.onBeforeDispose(e);
            dispose();
        }

        override public function onConfigLoaded(e:Event):void
        {
            super.onConfigLoaded(e);
            setup();
        }

        // PRIVATE

        private function setup():void
        {
            dispose();
            if (Config.config.hangar.enableFreeXpLocker || Config.config.hangar.enableCrystalLocker)
            {
                var cls:Class = App.utils.classFactory.getClass("com.xvm.lobby.ui.limits::LimitsUIImpl");
                if (!cls)
                {
                    App.instance.loaderMgr.addEventListener(LibraryLoaderEvent.LOADED, onLibLoaded, false, 0, true);
                }
                else
                {
                    limits_ui = new cls() as ILimitsUI;
                    if (limits_ui)
                    {
                        limits_ui.init(page);
                    }
                }
            }
        }

        private function dispose():void
        {
            App.instance.loaderMgr.removeEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);
            if (limits_ui)
            {
                limits_ui.dispose();
                limits_ui = null;
            }
        }

        private function onLibLoaded(e:LibraryLoaderEvent):void
        {
            var swf:String = e.url.replace(/^.*\//, '').toLowerCase();
            if (swf == "xvm_lobby_ui.swf")
            {
                App.instance.loaderMgr.removeEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);
                setup();
            }
        }
    }
}
