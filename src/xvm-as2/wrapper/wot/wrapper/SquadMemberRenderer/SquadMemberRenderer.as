import com.xvm.Wrapper;

class wot.wrapper.SquadMemberRenderer.SquadMemberRenderer extends net.wargaming.messenger.controls.SquadMemberRenderer
{
    function SquadMemberRenderer()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "configUI",
            "afterSetData",
            "getToolTipData"
        ];
        Wrapper.override(this, new wot.SquadMemberRenderer.SquadMemberRenderer(this, super), OVERRIDE_FUNCTIONS);
    }
}
