import wot.utils.Chance;
import wot.utils.Utils;

class wot.StatisticForm.WinChances
{
    public var showChances = false;
    public var showExp = false;

    private static var s_chanceField: TextField = null;
    private static var s_chanceText: String;

    public function showWinChances()
    {
        //wot.utils.Logger.add("showWinChances()");
        if (!_root.statsDialog)
            return;
        if (!s_chanceField)
        {
            s_chanceField = Utils.duplicateTextField(_root.statsDialog, "battleText", _root.statsDialog.battleText, 21, "center");
            s_chanceField._width += 300;
            s_chanceField._x -= 150;
        }
        s_chanceText = "<span class='xvm_battleText'>" +
            (Chance.GetChanceText(showExp) || "") +
            "</span>";
        //wot.utils.Logger.add(s_chanceText);
        if (s_chanceField.htmlText != s_chanceText)
        {
            //wot.utils.Logger.add(s_chanceField.htmlText);
            s_chanceField.html = true;
            s_chanceField.htmlText = s_chanceText;
        }
    }
}