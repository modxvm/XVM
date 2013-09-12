package xvm.hangar.components.WinChances
{
    import flash.display.Sprite;
    import flash.text.*;
    import net.wg.gui.lobby.battleloading.BattleLoading;
    import com.xvm.*;
    import com.xvm.misc.*;
    import com.xvm.utils.*;

    public class WinChances
    {
        private var page:BattleLoading;
        private var chanceField:TextField;

        public function WinChances(page:BattleLoading)
        {
            if (Config.config.rating.showPlayersStatistics == false)
                return;
            if (Config.config.battleLoading.showChances == false)
                return;
            this.page = page;
            chanceField = null;

            // Add stat loading handler
            Stat.loadBattleStat(this, onStatLoaded);

            //winChances.showChances = Config.s_config.battleLoading.showChances;
            //winChances.showExp = Config.s_config.battleLoading.showChancesExp;
            //winChances.enableLog = Config.s_config.rating.enableStatisticsLog;
        }

        private function onStatLoaded():void
        {
            chanceField = Utils.cloneTextField(page.form.battleText);
            var tf:TextFormat = chanceField.getTextFormat();
            tf.size = 17;
            chanceField.defaultTextFormat = tf;
            chanceField.htmlText = "";
            chanceField.autoSize = TextFieldAutoSize.CENTER;
            chanceField.width += 300;
            chanceField.x -= 150;
            chanceField.y += 78;
            chanceField.styleSheet = Utils.createTextStyleSheet("chances", chanceField.defaultTextFormat);
            page.form.addChild(chanceField);

            //Logger.addObject(chanceField.defaultTextFormat);
            var chanceText:String = Chance.GetChanceText(Config.config.battleLoading.showChancesExp) || "";
            //com.xvm.Logger.add(chanceText);
            // TODO if (enableLog == true)
            // TODO     StatsLogger.saveStatistics("chance", Chance.lastChances);
            chanceText = '<span class="chances">' + chanceText + '</span>';
            chanceField.htmlText = chanceText;
        }
    }
}
