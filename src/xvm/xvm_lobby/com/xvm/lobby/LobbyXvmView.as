/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class LobbyXvmView extends XvmViewBase
    {
        public function LobbyXvmView(view:IView)
        {
            super(view);
        }

        public function get page():LobbyPage
        {
            return super.view as LobbyPage;
        }

        override public function onBeforePopulate(e:LifeCycleEvent):void
        {
            Config.networkServicesSettings = new NetworkServicesSettings(Xfw.cmd(XvmCommands.GET_SVC_SETTINGS));
            super.onBeforePopulate(e);
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            initServerInfo();
        }

        override public function onConfigLoaded(e:Event):void
        {
            initServerInfo();
        }

        // server info

        private var _orig_onlineCounter_x:Number = NaN;
        private var _orig_onlineCounter_y:Number = NaN;
        private function initServerInfo():void
        {
            var cfg:CHangarServerInfo = Config.config.hangar.serverInfo;
            if (!cfg.enabled)
            {
                page.header.onlineCounter.mouseEnabled = false;
                page.header.onlineCounter.mouseChildren = false;
                page.header.onlineCounter.alpha = 0;
            }
            else
            {
                page.header.onlineCounter.mouseEnabled = true;
                page.header.onlineCounter.mouseChildren = true;
                if (isNaN(_orig_onlineCounter_x))
                {
                    _orig_onlineCounter_x = page.header.onlineCounter.x;
                    _orig_onlineCounter_y = page.header.onlineCounter.y;
                }
                page.header.onlineCounter.x = _orig_onlineCounter_x + cfg.shiftX;
                page.header.onlineCounter.y = _orig_onlineCounter_y + cfg.shiftY;
                page.header.onlineCounter.alpha = cfg.alpha / 100.0;
                page.header.onlineCounter.rotation = cfg.rotation;
            }
        }
    }
}
