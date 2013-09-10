import com.xvm.Wrapper;

class wot.wrapper.TeamRenderer.PlayerItemRenderer extends net.wargaming.messenger.controls.PlayerItemRenderer
{
    function PlayerItemRenderer()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "configUI",
            "afterSetData"
        ];
        Wrapper.override(this, new wot.TeamRenderer.PlayerItemRenderer(this, super), OVERRIDE_FUNCTIONS);
    }
}
