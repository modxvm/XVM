/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.battleClock
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.battle.views.debugPanel.DebugPanel;

    public class BattleClock extends TextField
    {
        private var format:String;

        public function BattleClock()
        {
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

            App.utils.scheduler.scheduleRepeatableTask(tick, 1000, int.MAX_VALUE);
        }

        public function dispose():void
        {
            App.utils.scheduler.cancelTask(tick);
        }

        // event handlers

        private function tick():void
        {
            htmlText = XfwUtils.FormatDate(format, new Date());
        }
    }
}
