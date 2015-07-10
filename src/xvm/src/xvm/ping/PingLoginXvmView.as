/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.ping
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.gui.login.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.ping.PingServers.*;

    public class PingLoginXvmView extends XvmViewBase
    {
        private var _initialized:Boolean = false;

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
            if (!_initialized)
                return;
            remove();
            init();
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            _initialized = true;
            init();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            _initialized = false;
            remove();
        }

        // PRIVATE

        private var pingControl:PingServersView = null;

        private function init():void
        {
            var cfg:CPingServers = Config.config.login.pingServers;
            cfg.fontStyle.markCurrentServer = "none" // at login screen it's not relevant
            PingServers.initFeature(cfg.enabled, cfg.updateInterval);
            if (cfg.enabled)
                pingControl = page.addChild(new PingServersView(cfg)) as PingServersView;
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
