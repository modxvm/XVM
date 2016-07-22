/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.battleClock
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.battle.views.debugPanel.DebugPanel;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class BattleClock extends TextField implements IDisposable
    {
        private var format:String;
        private var timer:Timer = null;

        public function BattleClock()
        {
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            onConfigLoaded(null);
        }

        public function dispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            stop();
        }

        // event handlers

        private function onConfigLoaded(e:Event):void
        {
            stop();
            setup();
        }

        private function setup():void
        {
            //Xvm.swfProfilerBegin("BattleClock.setup()");
            format = Config.config.battle.clockFormat;
            mouseEnabled = false;
            selectable = false;
            var debugPanel:DebugPanel = BattleXvmView.battlePage.debugPanel;
            x = debugPanel.lagOnlineSpr.x + debugPanel.lagOnlineSpr.width;
            y = debugPanel.fpsTF.y;
            antiAliasType = AntiAliasType.ADVANCED;
            var textFormat:TextFormat = debugPanel.fpsTF.defaultTextFormat;
            textFormat.align = "left";
            defaultTextFormat = textFormat;
            filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 1, 3) ];

            timer = new Timer(1000, 0);
            timer.addEventListener(TimerEvent.TIMER, onTimer);
            timer.start();
            //Xvm.swfProfilerEnd("BattleClock.setup()");
        }

        private function stop():void
        {
            if (timer)
            {
                timer.stop();
                timer = null;
            }
        }

        private function onTimer(e:Event):void
        {
            htmlText = XfwUtils.FormatDate(format, new Date());
        }
    }
}
