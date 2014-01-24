/**
 * XVM - lobby
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.ping
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
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
            initPing();
        }

        private function initPing():void
        {
            var cfg:CPingServers = Config.config.hangar.pingServers;
            PingServers.initFeature(cfg.enabled, cfg.updateInterval);
            if (cfg.enabled)
                page.addChild(new PingServersView(cfg));
        }
    }

}
