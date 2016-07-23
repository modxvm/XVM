/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.fullStats
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.battle.events.*;
    import com.xvm.types.cfg.*;
    import flash.text.*;
    import net.wg.infrastructure.interfaces.entity.*;

    public class WinChances
    {
        private var cfg:CStatisticForm;
        private var winChanceTF:TextField = null;

        public function WinChances(form:UI_FullStats)
        {
            cfg = Config.config.statisticForm;

            if (Config.networkServicesSettings.chance || Config.networkServicesSettings.chanceLive || cfg.showBattleTier)
            {
                winChanceTF = createWinChanceTextField(form.battleTF);
                form.addChild(winChanceTF);
                winChanceTF.styleSheet = XfwUtils.createTextStyleSheet("chances", form.battleTF.defaultTextFormat);
                winChanceTF.x = form.battleTF.x - 283;
                winChanceTF.y = 20;

                if (Config.networkServicesSettings.chanceLive)
                {
                    Xvm.addEventListener(PlayerStateEvent.DEAD, updateChanceText);
                }

                // Load battle stat
                Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, updateChanceText)
                if (Stat.battleStatLoaded)
                {
                    updateChanceText();
                }
            }
        }

        // PRIVATE

        private function updateChanceText():void
        {
            var playerNames:Vector.<String> = new Vector.<String>();
            for (var name:String in Stat.battleStat)
                playerNames.push(name);
            var chanceText:String = Chance.GetChanceText(playerNames, Stat.battleStat, Config.networkServicesSettings.chance, cfg.showBattleTier, Config.networkServicesSettings.chanceLive, true);
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
