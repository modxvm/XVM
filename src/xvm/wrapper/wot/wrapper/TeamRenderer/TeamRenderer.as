import com.xvm.Wrapper;

class wot.wrapper.TeamRenderer.TeamRenderer extends net.wargaming.messenger.controls.TeamRenderer
{
    function TeamRenderer()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "configUI",
            "afterSetData"
        ];
        Wrapper.override(this, new wot.TeamRenderer.TeamRenderer(this, super), OVERRIDE_FUNCTIONS);
    }
}
