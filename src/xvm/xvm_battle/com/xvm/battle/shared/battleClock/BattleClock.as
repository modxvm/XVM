/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.battleClock
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.battle.views.debugPanel.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.gfx.*;

    public class BattleClock extends TextField implements IDisposable
    {
        private var format:String;
        private var timer:Timer = null;

        private var _disposed:Boolean = false;

        public function BattleClock()
        {
            mouseEnabled = false;
            selectable = false;
            width = 300;
            TextFieldEx.setNoTranslate(this, true);
            antiAliasType = AntiAliasType.ADVANCED;
            filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 1, 3)];

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            onConfigLoaded(null);
        }

        public function dispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            stop();
            _disposed = true;
        }

        public final function isDisposed(): Boolean
        {
            return _disposed;
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
            var debugPanel:DebugPanel = BattleXvmView.battlePageDebugPanel;
            x = debugPanel.lagOnlineSpr.x + debugPanel.lagOnlineSpr.width;
            y = debugPanel.fpsTF.y;
            var textFormat:TextFormat = debugPanel.fpsTF.defaultTextFormat;
            textFormat.align = "left";
            defaultTextFormat = textFormat;

            timer = new Timer(1000, 0);
            timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true)
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
