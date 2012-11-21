import wot.utils.Config;
import wot.utils.Chance;
import wot.utils.GlobalEventDispatcher;

class wot.FinalStatistic.WinChances
{
    private var form_mc:MovieClip;
    private static var s_chanceField: TextField = null;

    public function WinChances(form_mc)
    {
        this.form_mc = form_mc;
        GlobalEventDispatcher.addEventListener("stat_loaded", this, onStatLoaded);
    }

    private function onStatLoaded()
    {
        GlobalEventDispatcher.removeEventListener("stat_loaded", this, onStatLoaded);

        if (Config.s_config.statisticForm.showChances)
            showWinChances();
    }

    private function showWinChances()
    {
        if (s_chanceField)
            return;

        s_chanceField = form_mc.createTextField("s_chanceField", form_mc.getNextHighestDepth(), 0, -26, form_mc._width, 26);
        s_chanceField.antiAliasType = "advanced";
        s_chanceField.html = true;
        s_chanceField.filters = [new flash.filters.DropShadowFilter(1, 90, 0, 100, 5, 5, 1, 3) ];

        s_chanceField.htmlText = "<p align='center'><font face='$TitleFont' size='18' color='#D8D8C8'>" +
            Chance.GetChanceText(Config.s_config.statisticForm.showChancesExp) +
            "</font></p>";
    }
}