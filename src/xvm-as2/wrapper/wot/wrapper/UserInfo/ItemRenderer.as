import com.xvm.Wrapper;

class wot.wrapper.UserInfo.ItemRenderer extends net.wargaming.profile.ItemRenderer
{
    function ItemRenderer()
    {
        super();

        //net.wargaming.utils.DebugUtils.LOG_WARNING("ItemRenderer");
        var OVERRIDE_FUNCTIONS:Array = [
            "setup",
            "updateAfterStateChange"
        ];
        Wrapper.override(this, new wot.UserInfo.ItemRenderer(this, super), OVERRIDE_FUNCTIONS);
    }
}
