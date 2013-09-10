import net.wargaming.utils.DebugUtils;

class com.xvm.Sandbox
{
    public static var SANDBOX_UNKNOWN = "_";
    public static var SANDBOX_VMM = "V";
    public static var SANDBOX_BATTLE = "B";
    public static var SANDBOX_HANGAR = "H";
    public static var SANDBOX_LOGIN = "L";

    public static function GetCurrentSandboxPrefix() : String
    {
        // VehicleMarkersManager.swf
        if (_root["vehicleMarkersCanvas"] != undefined)
            return SANDBOX_VMM;

        // battle.swf, PlayersPanel.swf, StatisticForm.swf, Minimap.swf, TeamBasesPanel.swf
        if (_root["sixthSenseIndicator"] != undefined)
            return SANDBOX_BATTLE;

        // hangar SWFs + battleloading.swf
        if (_root["invitesHandler"] != undefined)
            return SANDBOX_HANGAR;

        // login screen
        if (_root.loadingName != "startgamevideo" || _root.loadingName == "login")
            return SANDBOX_LOGIN;

        // unknown sand box
        var s = "XVM\nunknown sand box\n\n";
        for (var i in _root)
        {
            if (typeof(_root[i]) != "function")
                s += i + ": " + _root[i] + "\n";
        }
        DebugUtils.LOG_WARNING(s);
        return SANDBOX_UNKNOWN;
    }
}
