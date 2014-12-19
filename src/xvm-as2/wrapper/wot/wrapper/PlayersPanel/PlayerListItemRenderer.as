import com.xvm.Wrapper;

class wot.wrapper.PlayersPanel.PlayerListItemRenderer extends net.wargaming.ingame.PlayerListItemRenderer
{
    function PlayerListItemRenderer()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "__getColorTransform",
            "setState",
            "update"
        ];
        Wrapper.override(this, new wot.PlayersPanel.PlayerListItemRenderer(this, super), OVERRIDE_FUNCTIONS);
    }
}
