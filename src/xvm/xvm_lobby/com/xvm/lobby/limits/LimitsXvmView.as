/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.limits
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.events.*;
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class LimitsXvmView extends XvmViewBase
    {
        private var limits_ui:ILimitsUI = null;

        public function LimitsXvmView(view:IView)
        {
            super(view);
        }

        public function get page():LobbyPage
        {
            return super.view as LobbyPage;
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            onConfigLoaded(null);
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            dispose();
        }

        override public function onConfigLoaded(e:Event):void
        {
            dispose();
            if (Config.config.hangar.enableGoldLocker || Config.config.hangar.enableFreeXpLocker)
            {
                init();
            }
        }

        // PRIVATE

        private function init():void
        {
            var cls:Class = App.utils.classFactory.getClass("com.xvm.lobby.ui.limits::LimitsUIImpl");
            if (cls)
            {
                limits_ui = new cls() as ILimitsUI;
                if (limits_ui)
                {
                    limits_ui.init(page);
                }
            }
        }

        private function dispose():void
        {
            if (limits_ui)
            {
                limits_ui.dispose();
                limits_ui = null;
            }
        }
    }
}
