/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.battleloading
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.battle.battleloading.*;
    import net.wg.gui.tutorial.controls.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.gfx.*;

    public class Clock implements IDisposable
    {
        private var form:BaseTipLoadingForm;
        private var clock:TextField;
        private var clockFormat:String;

        private var _disposed: Boolean = false;

        public function Clock(form:BaseTipLoadingForm)
        {
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init(form);
        }

        private function _init(form:BaseTipLoadingForm):void
        {
            if (!form)
                return;

            if (!form.helpTip.visible)
                return;

            this.form = form;
            var notTipsForm:Boolean;
            try
            {
                notTipsForm = form["formBackgroundTable"].visible;
            }
            catch (ex:Error)
            {
                notTipsForm = false;
            }

            var cfg:CBattleLoading = notTipsForm ? Config.config.battleLoading : Config.config.battleLoadingTips;

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

        public final function dispose():void
        {
            onDispose();
            _disposed = true;
        }
        
        public final function isDisposed(): Boolean
        {
            return _disposed;
        }

        protected function onDispose():void
        {
            if (clock)
            {
                form.removeChild(clock);
                clock = null;
            }
        }

        // PRIVATE

        private function update():void
        {
            if (clock)
            {
                if (clockFormat)
                {
                    clock.text = XfwUtils.FormatDate(clockFormat, new Date());
                }
            }
        }
    }

}
