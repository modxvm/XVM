import com.xvm.*;

class wot.StatisticForm.WinChances
{
    private static var s_chanceField: TextField = null;
    private static var s_chanceText: String;

    public function showWinChances()
    {
        //Logger.add("showWinChances()");

        if (!s_chanceField)
        {
            if (!_root.statsDialog)
            {
                //Logger.addObject(_root); // debug
                return;
            }
            s_chanceField = Utils.duplicateTextField(_root.statsDialog, "battleText", _root.statsDialog.battleText, -19, "left");
            s_chanceField._width += 300;
        }

        s_chanceText = "<span class='xvm_battleText'>" + (Chance.GetChanceText(
            Config.networkServicesSettings.chance,
            Config.config.statisticForm.showBattleTier,
            Config.networkServicesSettings.chanceLive) || "") + "</span>";
        //com.xvm.Logger.add(s_chanceText);
        if (s_chanceField.htmlText != s_chanceText)
        {
            //com.xvm.Logger.add(s_chanceField.htmlText);
            s_chanceField.html = true;
            s_chanceField.htmlText = s_chanceText;
        }
    }
}
