import com.xvm.Wrapper;

class wot.wrapper.UserInfo.UserInfo extends net.wargaming.profile.UserInfo
{
    function UserInfo()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "setCommonInfo",
            "setStat",
            "setList"
        ];
        Wrapper.override(this, new wot.UserInfo.UserInfo(this, super), OVERRIDE_FUNCTIONS);
    }
}
