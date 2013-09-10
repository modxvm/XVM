import com.xvm.Wrapper;

class wot.wrapper.TeamBasesPanel.TeamBasesPanel extends net.wargaming.ingame.TeamBasesPanel
{
    function TeamBasesPanel()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "add"
        ];
        Wrapper.override(this, new wot.TeamBasesPanel.TeamBasesPanel(this, super), OVERRIDE_FUNCTIONS);
    }
}
