/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.online
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.online.OnlineServers.*;

    public class OnlineLobbyXvmView extends XvmViewBase
    {
        private var _initialized:Boolean = false;

        public function OnlineLobbyXvmView(view:IView)
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

        private var onlineControl:OnlineServersView = null;

        private function init():void
        {
            var cfg:COnlineServers = Config.config.hangar.onlineServers;
            OnlineServers.initFeature(cfg.enabled && Config.config.__wgApiAvailable, cfg.updateInterval);
            if (cfg.enabled && Config.config.__wgApiAvailable)
                onlineControl = page.addChildAt(new OnlineServersView(cfg), cfg.topmost ? page.getChildIndex(page.header) + 1 : 0) as OnlineServersView;
        }

        private function remove():void
        {
            OnlineServers.stop();
            if (onlineControl != null)
            {
                onlineControl.dispose();
                onlineControl = null;
            }
        }
    }

}
