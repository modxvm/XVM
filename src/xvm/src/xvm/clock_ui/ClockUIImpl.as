/**
 * XVM - clock
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.clock_ui
{
    import com.xfw.*;
    import com.xvm.*;
    import xvm.clock.IClockUI;
    import com.xvm.types.cfg.*;
    import net.wg.gui.lobby.*;
    import xvm.clock_ui.controls.ClockControl;

    public class ClockUIImpl implements IClockUI
    {
        private var page:LobbyPage = null;
        private var clock:ClockControl = null;

        public function ClockUIImpl()
        {
            //Logger.add("ClockUIImpl");
        }

        public function init(page:LobbyPage):void
        {
            this.page = page;

            var cfg:CHangarClock = Config.config.hangar.clock;
            clock = page.addChildAt(new ClockControl(cfg), cfg.topmost ? page.getChildIndex(page.header) + 1 : 0) as ClockControl;
        }

        public function dispose():void
        {
            if (clock != null)
            {
                clock.dispose();
                clock = null;
            }
        }

        // PRIVATE
    }

}
