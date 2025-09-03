/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.online
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import com.xvm.lobby.online.OnlineServers.*;
    import flash.events.*;
    import net.wg.gui.login.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class OnlineLoginXvmView extends XvmViewBase
    {
        // currently data is updated once per minute on XVM server
        private static const UPDATE_INTERVAL:int = 60000;

        public function OnlineLoginXvmView(view:IView)
        {
            super(view);
        }

        public function get page():LoginPage
        {
            return super.view as LoginPage;
        }

        override public function onConfigLoaded(e:Event):void
        {
            super.onConfigLoaded(e);
            remove();
            init();
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            super.onAfterPopulate(e);
            init();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            super.onBeforeDispose(e);
            remove();
        }

        // PRIVATE

        private var onlineControl:OnlineServersView = null;

        private function init():void
        {
            var cfg:COnlineServers = Config.config.login.onlineServers;
            cfg.currentServerFormat = "{server}"; // at login screen it's not relevant
            OnlineServers.initFeature(cfg.enabled && Config.config.__wgApiAvailable, UPDATE_INTERVAL);
            if (cfg.enabled)
            {
                if (Config.config.__wgApiAvailable)
                {
                    onlineControl = page.addChild(new OnlineServersView(cfg)) as OnlineServersView;
                }
            }
        }

        private function remove():void
        {
            OnlineServers.stop();
            if (onlineControl)
            {
                page.removeChild(onlineControl);
                onlineControl.dispose();
                onlineControl = null;
            }
        }
    }
}
