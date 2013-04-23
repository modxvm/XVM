import com.xvm.Wrapper;

class wot.wrapper.battleloading.BattleLoadingItemRenderer extends net.wargaming.controls.LobbyPlayerListItemRenderer
{
    function BattleLoadingItemRenderer()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "setData",
            "setState",
            "update"
        ];
        Wrapper.override(this, new wot.battleloading.BattleLoadingItemRenderer(this, super), OVERRIDE_FUNCTIONS);
    }
}
