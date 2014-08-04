import com.xvm.Wrapper;

class wot.wrapper.PlayersPanel.PlayersPanel extends net.wargaming.ingame.PlayersPanel
{
    function PlayersPanel()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "setData",
            "onRecreateDevice",
            "updateAlphas",
            "updateWidthOfLongestName"
        ];
        Wrapper.override(this, new wot.PlayersPanel.PlayersPanel(this, super), OVERRIDE_FUNCTIONS);
    }
}
