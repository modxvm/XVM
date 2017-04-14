/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.online
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import com.xvm.lobby.online.OnlineServers.*;
    import flash.events.*;
    import net.wg.gui.lobby.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class OnlineLobbyXvmView extends XvmViewBase
    {
        private var _initialized:Boolean = false;
        private var _isHangar:Boolean = false;
        private var cfg:COnlineServers;

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

        public function setVisibility(isHangar:Boolean):void
        {
            _isHangar = isHangar;
            if (onlineControl)
            {
                onlineControl.visible = isHangar || (cfg.layer.toLowerCase() == Defines.LAYER_TOP);
            }
        }

        // PRIVATE

        private var onlineControl:OnlineServersView = null;

        private function init():void
        {
            cfg = Config.config.hangar.onlineServers;
            cfg.updateInterval = 60000; // currently data is updated once per minute on XVM server
            OnlineServers.initFeature(cfg.enabled && Config.config.__wgApiAvailable, cfg.updateInterval);
            if (cfg.enabled && Config.config.__wgApiAvailable)
            {
                var layer:String = cfg.layer.toLowerCase();
                var index:int = (layer == Defines.LAYER_BOTTOM) ? 0 : (layer == Defines.LAYER_TOP) ? page.getChildIndex(page.header) + 1 : page.getChildIndex(page.header);
                onlineControl = page.addChildAt(new OnlineServersView(cfg), index) as OnlineServersView;
                setVisibility(_isHangar);
            }
        }

        private function remove():void
        {
            OnlineServers.stop();
            if (onlineControl)
            {
                onlineControl.dispose();
                onlineControl = null;
            }
        }
    }
}
