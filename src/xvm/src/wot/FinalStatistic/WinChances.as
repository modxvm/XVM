import flash.filters.DropShadowFilter;
import wot.utils.Config;
import wot.utils.Chance;
import wot.utils.GlobalEventDispatcher;

class wot.FinalStatistic.WinChances
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

        if (Config.s_config.statisticForm.showChances)
            showWinChances();
    }

    private function showWinChances()
    {
        //wot.utils.Logger.addObject(_root.windowLayout, "_root.windowLayout", 3);
        //wot.utils.Logger.addObject(wot.utils.StatData.s_data, "s_data(2)", 3);
        if (s_chanceField)
            return;

        s_chanceField = form_mc.createTextField("s_chanceField", form_mc.getNextHighestDepth(), 0, -30, form_mc._width, 30);
        s_chanceField.antiAliasType = "advanced";
        var tf: TextFormat = new TextFormat("$TextFont", 20, 0xEBEBEB, false, false, false, "", "", "center");
        s_chanceField.setNewTextFormat(tf);
        s_chanceField.filters = [ new DropShadowFilter(0, 0, 0, 1, 5, 5, 3, 3) ];

        s_chanceField.text = "ABCDE 012345 >>>";
        s_chanceText = Chance.ShowChance(s_chanceField, Config.s_config.statisticForm.showChancesExp);
        
        //wot.utils.Logger.add("s_chanceText: " + s_chanceText);
    }
}