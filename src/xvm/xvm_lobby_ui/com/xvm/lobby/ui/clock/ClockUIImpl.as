/**
 * XVM - clock
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.clock
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.lobby.clock.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import net.wg.gui.lobby.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.infrastructure.interfaces.*;

    public class ClockUIImpl implements IClockUI
    {
        private var page:LobbyPage = null;
        private var cfg:CHangarClock;
        private var clock:ClockControl = null;

        public function ClockUIImpl()
        {
            //Logger.add("ClockUIImpl");
        }

        public function init(page:LobbyPage):void
        {
            this.page = page;
            this.cfg = Config.config.hangar.clock;

            var layer:String = cfg.layer.toLowerCase();
            var index:int = (layer == "bottom") ? 0 : (layer == "top") ? page.getChildIndex(page.header) + 1 : page.getChildIndex(page.subViewContainer as DisplayObject) + 1;
            clock = page.addChildAt(new ClockControl(cfg), index) as ClockControl;
        }

        public function dispose():void
        {
            if (clock)
            {
                page.removeChild(clock);
                clock.dispose();
                clock = null;
            }
        }

        public function setVisibility(isHangar:Boolean):void
        {
            if (clock)
            {
                clock.visible = isHangar || (cfg.layer.toLowerCase() == "top");
            }
        }
    }
}
