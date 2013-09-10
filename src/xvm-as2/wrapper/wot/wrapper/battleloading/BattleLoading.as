import com.xvm.Wrapper;

class wot.wrapper.battleloading.BattleLoading extends net.wargaming.BattleLoading
{
    function BattleLoading()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "setSize"
        ];
        Wrapper.override(this, new wot.battleloading.BattleLoading(this, super), OVERRIDE_FUNCTIONS);
    }
}
