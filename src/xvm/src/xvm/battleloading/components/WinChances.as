/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.battleloading.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.utils.*;
    import flash.text.*;
    import net.wg.gui.lobby.battleloading.*;

    public class WinChances
    {
        private var page:BattleLoading;

        public function WinChances(page:BattleLoading)
        {
            if (Config.networkServicesSettings.chance == false && Config.config.battleLoading.showBattleTier == false)
                return;
            this.page = page;

            // Add stat loading handler
            Stat.loadBattleStat(this, onStatLoaded);
        }

        private var winChanceTF:TextField = null;
        private function onStatLoaded():void
        {
            if (winChanceTF == null)
            {
                winChanceTF = createWinChanceTextField(page.form.battleText);
                page.form.addChild(winChanceTF);
                winChanceTF.styleSheet = WGUtils.createTextStyleSheet("chances", page.form.battleText.defaultTextFormat);
                winChanceTF.x = page.form.battleText.x;
                winChanceTF.y = -10;
            }

            var playerNames:Vector.<String> = new Vector.<String>();
            for (var name:String in Stat.stat)
                playerNames.push(name);

            var chanceText:String = Chance.GetChanceText(playerNames, Config.networkServicesSettings.chance, Config.config.battleLoading.showBattleTier);
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
            tf.align = TextFormatAlign.LEFT;
            f.defaultTextFormat = tf;
            f.selectable = false;
            f.filters = tpl.filters;
            return f;
        }
    }
}
