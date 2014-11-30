/**
 * XVM - lobby
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.ping
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.ping.PingServers.*;

    public class PingLobbyXvmView extends XvmViewBase
    {
        public function PingLobbyXvmView(view:IView)
        {
            super(view);
        }

        public function get page():LobbyPage
        {
            return super.view as LobbyPage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            init();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            remove();
        }

        // PRIVATE

        private var pingControl:PingServersView = null;

        private function init():void
        {
            var cfg:CPingServers = Config.config.hangar.pingServers;
            PingServers.initFeature(cfg.enabled, cfg.updateInterval);
            if (cfg.enabled)
                pingControl = page.addChildAt(new PingServersView(cfg), cfg.topmost ? page.getChildIndex(page.header) + 1 : 0) as PingServersView;
        }

        private function remove():void
        {
            PingServers.stop();
            if (pingControl != null)
            {
                pingControl.dispose();
                pingControl = null;
            }
        }
    }

}
