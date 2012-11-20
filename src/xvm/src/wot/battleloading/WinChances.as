import wot.utils.Config;
import wot.utils.Chance;
import wot.utils.GlobalEventDispatcher;
import wot.utils.StatsLogger;

class wot.battleloading.WinChances
{
    private var form_mc:MovieClip;
    private static var s_chanceField: TextField = null;
    private static var s_chanceText: String;

    public function WinChances(form_mc)
    {
        this.form_mc = form_mc;
        GlobalEventDispatcher.addEventListener("stat_loaded", this, onStatLoaded);
    }

    private function onStatLoaded()
    {
        GlobalEventDispatcher.removeEventListener("stat_loaded", this, onStatLoaded);

        if (Config.s_config.battleLoading.showChances)
            showWinChances();
    }

    private function showWinChances()
    {
        if (!s_chanceField)
        {
            s_chanceField = form_mc.battleText;
            s_chanceField.html = true;
            s_chanceField._width += 300;
            s_chanceField._x -= 150;
            s_chanceText = Chance.ShowChance(s_chanceField, Config.s_config.battleLoading.showChancesExp);
			StatsLogger.saveStatistics("chance", Chance.lastChances);
        }
        if (s_chanceField.htmlText != s_chanceText)
        {
            //wot.utils.Logger.add(s_chanceField.htmlText);
            s_chanceField.html = true;
            s_chanceField.htmlText = s_chanceText;
        }
    }
}