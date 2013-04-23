import com.xvm.Wrapper;

class wot.wrapper.TeamMemberRenderer.TeamMemberRenderer extends net.wargaming.messenger.controls.TeamMemberRenderer
{
    function TeamMemberRenderer()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "configUI",
            "afterSetData",
            "updateAfterStateChange",
            "getToolTipData"
        ];
        Wrapper.override(this, new wot.TeamMemberRenderer.TeamMemberRenderer(this, super), OVERRIDE_FUNCTIONS);
    }
}
