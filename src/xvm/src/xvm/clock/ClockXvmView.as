/**
 * XVM - clock
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.clock
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import com.xfw.types.cfg.*;
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class ClockXvmView extends XvmViewBase
    {
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
            //Logger.add("onAfterPopulate: " + view.as_alias);
            createClock();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforeDispose: " + view.as_alias);
            removeClock();
        }

        // PRIVATE

        private var clock:ClockControl = null;

        private function createClock():void
        {
            var cfg:CClock = Config.config.hangar.clock;
            if (cfg.enabled)
                clock = page.addChildAt(new ClockControl(cfg), cfg.topmost ? page.getChildIndex(page.header) + 1 : 0) as ClockControl;
        }

        private function removeClock():void
        {
            if (clock != null)
            {
                clock.dispose();
                clock = null;
            }
        }
    }

}
