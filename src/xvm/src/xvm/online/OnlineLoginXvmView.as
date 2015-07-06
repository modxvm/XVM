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
    import net.wg.gui.login.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.online.OnlineServers.*;

    public class OnlineLoginXvmView extends XvmViewBase
    {
        private var _initialized:Boolean = false;

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
            var cfg:COnlineServers = Config.config.login.onlineServers;
            OnlineServers.initFeature(cfg.enabled && Config.config.__wgApiAvailable, cfg.updateInterval);
            if (cfg.enabled && Config.config.__wgApiAvailable)
                onlineControl = page.addChild(new OnlineServersView(cfg)) as OnlineServersView;
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
