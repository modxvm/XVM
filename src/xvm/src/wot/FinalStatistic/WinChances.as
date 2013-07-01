import com.xvm.Chance;
import com.xvm.Config;
import com.xvm.GlobalEventDispatcher;

class wot.FinalStatistic.WinChances
{
    private var form_mc:MovieClip;

    public function WinChances(form_mc:MovieClip)
    {
        this.form_mc = form_mc;
        GlobalEventDispatcher.addEventListener("stat_loaded", this, onStatLoaded);
    }

    private function onStatLoaded()
    {
        GlobalEventDispatcher.removeEventListener("stat_loaded", this, onStatLoaded);

        if (Config.s_config.finalStatistic.showChances)
            showWinChances();
    }

    private function showWinChances()
    {
        var s_chanceField:TextField = form_mc._parent._parent.titleBtn.textField;
        var s_text = null;
        form_mc.onEnterFrame = function()
        {
            if (s_chanceField.htmlText == null)
                return;
            //delete this.onEnterFrame;
            if (s_text == null)
            {
                s_chanceField.html = true;
                s_chanceField.htmlText += "<tab><tab><tab><font face='$TitleFont' size='18' color='#E9E7D6'>" +
                    Chance.GetChanceText(Config.s_config.finalStatistic.showChancesExp) + "</font>";
                s_text = s_chanceField.htmlText;
            }
            if (s_chanceField.htmlText != s_text)
            {
                s_chanceField.htmlText = s_text;
                s_text = s_chanceField.htmlText;
            }
        }
    }
}
