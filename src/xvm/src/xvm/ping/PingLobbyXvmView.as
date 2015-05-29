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
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.ping.PingServers.*;

    public class PingLobbyXvmView extends XvmViewBase
    {
        private var _initialized:Boolean = false;

        public function PingLobbyXvmView(view:IView)
        {
            super(view);
        }

        public function get page():LobbyPage
        {
            return super.view as LobbyPage;
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
