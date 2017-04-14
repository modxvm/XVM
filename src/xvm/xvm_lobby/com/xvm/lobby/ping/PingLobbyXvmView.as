/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ping
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import com.xvm.lobby.ping.PingServers.*;
    import flash.events.*;
    import net.wg.gui.lobby.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class PingLobbyXvmView extends XvmViewBase
    {
        private var _initialized:Boolean = false;
        private var _isHangar:Boolean = false;
        private var cfg:CPingServers;

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

        public function setVisibility(isHangar:Boolean):void
        {
            _isHangar = isHangar;
            if (pingControl)
            {
                pingControl.visible = isHangar || (cfg.layer.toLowerCase() == Defines.LAYER_TOP);
            }
        }

        // PRIVATE

        private var pingControl:PingServersView = null;

        private function init():void
        {
            cfg = Config.config.hangar.pingServers;
            PingServers.initFeature(cfg.enabled, cfg.updateInterval);
            if (cfg.enabled)
            {
                var layer:String = cfg.layer.toLowerCase();
                var index:int = (layer == Defines.LAYER_BOTTOM) ? 0 : (layer == Defines.LAYER_TOP) ? page.getChildIndex(page.header) + 1 : page.getChildIndex(page.header);
                pingControl = page.addChildAt(new PingServersView(cfg), index) as PingServersView;
                setVisibility(_isHangar);
            }
        }

        private function remove():void
        {
            PingServers.stop();
            if (pingControl)
            {
                pingControl.dispose();
                pingControl = null;
            }
        }
    }
}
