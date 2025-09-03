/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ping
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import com.xvm.lobby.ping.PingServers.*;
    import flash.events.*;
    import net.wg.gui.login.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class PingLoginXvmView extends XvmViewBase
    {
        public function PingLoginXvmView(view:IView)
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

        private var pingControl:PingServersView = null;

        private function init():void
        {
            var cfg:CPingServers = Config.config.login.pingServers;
            cfg.currentServerFormat = "{server}"; // at login screen it's not relevant
            PingServers.initFeature(cfg.enabled, cfg.updateInterval);
            if (cfg.enabled)
            {
                pingControl = page.addChild(new PingServersView(cfg)) as PingServersView;
            }
        }

        private function remove():void
        {
            PingServers.stop();
            if (pingControl)
            {
                page.removeChild(pingControl);
                pingControl.dispose();
                pingControl = null;
            }
        }
    }
}
