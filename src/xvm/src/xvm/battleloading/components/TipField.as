/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.battleloading.components
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.text.*;
    import net.wg.gui.lobby.battleloading.*;

    public class TipField
    {
        private var page:BattleLoading;

        public function TipField(page:BattleLoading)
        {
            this.page = page;
            Stat.loadBattleStat(this, update);
            update();
        }

        // PRIVATE

        private function update():void
        {
            var info:TextField = page.form.helpTip;

            info.text = "XVM v" + Config.config.__xvmVersion + "     " + Config.config.__xvmIntro;

            if (Config.config.__stateInfo.warning != null)
            {
                info.textColor = 0xFFD040;
                if (Config.config.__stateInfo.warning != "")
                    setTipText(Config.config.__stateInfo.warning);
            }

            if (Config.config.__stateInfo.error != null)
            {
                info.textColor = 0xFF4040;
                if (Config.config.__stateInfo.error != "")
                    setTipText(Config.config.__stateInfo.error, true);
            }
        }

        private function setTipText(text:String, isError:Boolean = false):void
        {
            var tip:TextField = page.form.tipText;
            var tf:TextFormat = tip.getTextFormat();
            tf.align = TextFormatAlign.LEFT;
            tf.size = 12;
            tf.leading = 0;
            tip.defaultTextFormat = tf;
            tip.text = text;
            if (isError)
            {
                tf.color = 0xFF4040;
                var pos:int = text.indexOf(">>>");
                if (pos != -1)
                    tip.setTextFormat(tf, pos, pos + 3);
                pos = text.indexOf("<<<");
                if (pos != -1)
                    tip.setTextFormat(tf, pos, pos + 3);
            }
        }
    }
}
