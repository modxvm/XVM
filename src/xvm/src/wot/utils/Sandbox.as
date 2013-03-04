import net.wargaming.utils.DebugUtils;
class wot.utils.Sandbox
{
    public static function GetCurrentSandboxPrefix() : String
    {
        // VehicleMarkersManager.swf
        if (_root["vehicleMarkersCanvas"] != undefined)
            return "V";

        // battle.swf, PlayersPanel.swf, StatisticForm.swf, Minimap.swf, TeamBasesPanel.swf
        if (_root["sixthSenseIndicator"] != undefined)
            return "B";

        // hangar SWFs + battleloading.swf
        if (_root["invitesHandler"] != undefined)
            return "H";

        // unknown sand box
        var s = "\nunknown sand box\n\n";
        for (var i in _root)
        {
            if (typeof _root[i] != "function")
                s += i + ": " + _root[i] + "\n";
        }
        DebugUtils.LOG_WARNING(s);
        return "_";
    }
}
