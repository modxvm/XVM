import com.xvm.Wrapper;

class wot.wrapper.LangBarPanel.LanguageBar extends net.wargaming.LanguageBar
{
    function LanguageBar()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "init"
        ];
        Wrapper.override(this, new wot.LangBarPanel.LanguageBar(this, super), OVERRIDE_FUNCTIONS);
    }
}
