import com.xvm.Wrapper;

class wot.wrapper.gameloading.GameLoadingForm extends net.wargaming.gameloading.GameLoadingForm
{
    function GameLoadingForm()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "setVersion"
        ];
        Wrapper.override(this, new wot.gameloading.GameLoadingForm(this, super), OVERRIDE_FUNCTIONS);
    }
}
