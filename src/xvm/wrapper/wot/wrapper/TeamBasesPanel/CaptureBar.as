import com.xvm.Wrapper;

class wot.wrapper.TeamBasesPanel.CaptureBar extends net.wargaming.ingame.CaptureBar
{
    function CaptureBar()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "updateProgress",
            "updateTitle"
        ];
        Wrapper.override(this, new wot.TeamBasesPanel.CaptureBar(this, super), OVERRIDE_FUNCTIONS);
    }
}
