import com.xvm.Wrapper;

class wot.wrapper.Minimap.MinimapEntry extends net.wargaming.ingame.MinimapEntry
{
    function MinimapEntry()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "lightPlayer"
        ];
        Wrapper.override(this, new wot.Minimap.MinimapEntry(this, super), OVERRIDE_FUNCTIONS);
    }
}
