/**
 * XVM - clock
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.clock
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.events.*;
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class ClockXvmView extends XvmViewBase
    {
        private var clock_ui:IClockUI = null;

        public function ClockXvmView(view:IView)
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
            if (Config.config.hangar.clock.enabled)
            {
                init();
            }
        }

        // PRIVATE

        private function init():void
        {
            var cls:Class = App.utils.classFactory.getClass("com.xvm.lobby.ui.clock::ClockUIImpl");
            if (cls)
            {
                clock_ui = new cls() as IClockUI;
                if (clock_ui)
                {
                    clock_ui.init(page);
                }
            }
        }

        private function dispose():void
        {
            if (clock_ui)
            {
                clock_ui.dispose();
                clock_ui = null;
            }
        }
    }
}
