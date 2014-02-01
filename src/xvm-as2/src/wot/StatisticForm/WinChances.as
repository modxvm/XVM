import com.xvm.Chance;
import com.xvm.Utils;

class wot.StatisticForm.WinChances
{
    public var showChances = false;
    public var showLive = false;
    public var showBattleTier = false;

    private static var s_chanceField: TextField = null;
    private static var s_chanceText: String;

    public function showWinChances()
    {
        //com.xvm.Logger.add("showWinChances()");
        if (!_root.statsDialog)
            return;
        if (!s_chanceField)
        {
            s_chanceField = Utils.duplicateTextField(_root.statsDialog, "battleText", _root.statsDialog.battleText, 20, "center");
            s_chanceField._width += 300;
            s_chanceField._x -= 150;
        }

        s_chanceText = "<span class='xvm_battleText'><b><font size='16'>" +
            (Chance.GetChanceText(showChances, showBattleTier, showLive) || "") +
            "</font></b></span>";
        //com.xvm.Logger.add(s_chanceText);
        if (s_chanceField.htmlText != s_chanceText)
        {
            //com.xvm.Logger.add(s_chanceField.htmlText);
            s_chanceField.html = true;
            s_chanceField.htmlText = s_chanceText;
        }
    }
}
