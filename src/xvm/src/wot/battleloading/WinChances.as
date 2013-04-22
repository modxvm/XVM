import com.xvm.Chance;
import com.xvm.GlobalEventDispatcher;
import com.xvm.StatsLogger;
import com.xvm.Utils;

class wot.battleloading.WinChances
{
    public var showChances = false;
    public var showExp = false;
    public var enableLog = false;

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

        if (showChances)
            showWinChances();
    }

    private function showWinChances()
    {
        if (!s_chanceField)
        {
            s_chanceField = Utils.duplicateTextField(form_mc, "battleText", form_mc.battleText, 21, "center");
            s_chanceField._width += 300;
            s_chanceField._x -= 150;
            s_chanceText = '<span class="xvm_battleText">' +
                (Chance.ShowChance(s_chanceField, showExp) || "") +
                '</span>';
            //com.xvm.Logger.add(s_chanceText);
            if (enableLog == true)
                StatsLogger.saveStatistics("chance", Chance.lastChances);
        }
        if (s_chanceField.htmlText != s_chanceText)
        {
            //com.xvm.Logger.add(s_chanceField.htmlText);
            s_chanceField.html = true;
            s_chanceField.htmlText = s_chanceText;
        }
    }
}