/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.battleloading.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.lobby.battleloading.*;
    import scaleform.gfx.*;

    public class Clock
    {
        private var clock:TextField;
        private var clockFormat:String;

        public function Clock(page:BattleLoading)
        {
            var form:BattleLoadingForm = page.form as BattleLoadingForm;
            if (!form)
                return;

            if (!form.helpTip.visible)
                return;

            var cfg:CBattleLoading = (page.form as BattleLoadingForm).formBackgroundTable.visible ? Config.config.battleLoading : Config.config.battleLoadingTips;

            clockFormat = cfg.clockFormat;
            if (clockFormat)
            {
                var f:TextField = form.helpTip;

                clock = new TextField();
                clock.mouseEnabled = false;
                clock.selectable = false;
                TextFieldEx.setNoTranslate(clock, true);
                clock.antiAliasType = AntiAliasType.ADVANCED;
                clock.x = f.x;
                clock.y = f.y;
                clock.autoSize = TextFieldAutoSize.NONE;
                clock.width = f.width;
                clock.height = f.height;
                var tf:TextFormat = new TextFormat("$TitleFont", 16, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.RIGHT);
                clock.defaultTextFormat = tf;
                clock.filters = f.filters;
                form.addChild(clock);

                update();
                setInterval(update, 1000);
            }
        }

        // PRIVATE

        private function update():void
        {
            clock.text = XfwUtils.FormatDate(clockFormat, new Date());
        }
    }

}
