import com.xvm.Wrapper;

class wot.wrapper.Minimap.Minimap extends net.wargaming.ingame.Minimap
{
    function Minimap()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "scaleMarkers",
            "onEntryInited",
            "correctSizeIndex",
            "draw",
            "sizeUp"
        ];
        Wrapper.override(this, new wot.Minimap.Minimap(this, super), OVERRIDE_FUNCTIONS);
    }
}
