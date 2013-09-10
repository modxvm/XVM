package xvm.hangar.components.BattleLoading
{
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;
    import com.xvm.*;
    import com.xvm.utils.Utils;
    import net.wg.gui.lobby.battleloading.BattleLoading;

    public class Clock
    {
        private var clock:TextField;

        public function Clock(page:BattleLoading)
        {
            var format:String = Config.config.battleLoading.clockFormat;
            if (!format || format == "")
                return;

            var f:TextField = page.form.helpTip;

            clock = new TextField();
            clock.x = f.x;
            clock.y = f.y;
            clock.autoSize = TextFieldAutoSize.NONE;
            clock.width = f.width;
            clock.height = f.height;
            clock.antiAliasType = AntiAliasType.ADVANCED;
            var tf:TextFormat = f.getTextFormat();
            tf.color = 0xFFFFFF;
            tf.align = TextFormatAlign.RIGHT;
            clock.defaultTextFormat = tf;
            clock.filters = f.filters;
            page.form.addChild(clock);

            update();
            setInterval(update, 1000);
        }

        // PRIVATE

        private function update():void
        {
            clock.text = Utils.FormatDate(Config.config.battleLoading.clockFormat, new Date());
        }
    }

}
