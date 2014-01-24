/**
 * XVM - login page
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.ping
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import net.wg.gui.login.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.ping.PingServers.*;

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

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            initPing();
        }

        // PRIVATE

        private function initPing():void
        {
            var cfg:CPingServers = Config.config.login.pingServers;
            PingServers.initFeature(cfg.enabled, cfg.updateInterval);
            if (cfg.enabled)
                page.addChild(new PingServersView(cfg));
        }
    }

}
