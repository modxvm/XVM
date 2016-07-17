/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.battleloading.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xfw.events.*;
    import com.xvm.types.cfg.*;
    import flash.text.*;
    import net.wg.gui.lobby.battleloading.*;

    public class WinChances
    {
        private var page:BattleLoading;
        private var cfg:CBattleLoading;

        public function WinChances(page:BattleLoading)
        {
            this.page = page;

            cfg = (page.form as BattleLoadingForm).formBackgroundTable.visible ? Config.config.battleLoading : Config.config.battleLoadingTips;

            if (Config.networkServicesSettings.chance == false && cfg.showBattleTier == false)
                return;

            // Load battle stat
            Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, onStatLoaded)
            if (Stat.battleStatLoaded)
            {
                onStatLoaded(null);
            }
        }

        // PRIVATE

        private var winChanceTF:TextField = null;
        private function onStatLoaded(e:ObjectEvent):void
        {
            if (winChanceTF == null)
            {
                var form:BaseLoadingForm = page.form as BaseLoadingForm;
                winChanceTF = createWinChanceTextField(form.battleText);
                form.addChild(winChanceTF);
                winChanceTF.styleSheet = XfwUtils.createTextStyleSheet("chances", form.battleText.defaultTextFormat);
                winChanceTF.x = form.battleText.x - 283;
                winChanceTF.y = -50;
            }

            var playerNames:Vector.<String> = new Vector.<String>();
            for (var name:String in Stat.battleStat)
                playerNames.push(name);

            var chanceText:String = Chance.GetChanceText(playerNames, Stat.battleStat, Config.networkServicesSettings.chance, cfg.showBattleTier, false, true);
            if (chanceText)
            {
                winChanceTF.htmlText = '<span class="chances">' + chanceText + '</span>';
            }
        }

        private function createWinChanceTextField(tpl:TextField):TextField
        {
            var f:TextField = new TextField();
            f.x = tpl.x;
            f.y = tpl.y;
            f.autoSize = TextFieldAutoSize.NONE;
            f.width = tpl.width;
            f.height = tpl.height;
            f.antiAliasType = AntiAliasType.ADVANCED;
            var tf:TextFormat = tpl.getTextFormat();
            tf.color = 0xFFFFFF;
            tf.align = TextFormatAlign.CENTER;
            f.defaultTextFormat = tf;
            f.selectable = false;
            f.filters = tpl.filters;
            return f;
        }
    }
}
