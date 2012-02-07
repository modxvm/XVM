class net.wargaming.messenger.MessengerUtils
{
    function MessengerUtils()
    {
    } // End of the function
    static function getFullChannelName(item)
    {
        return (item.isSystem ? (item.channelName) : (item.channelName + "(" + item.ownerName + ")"));
    } // End of the function
    static function getUserInfoObject(info)
    {
        var _loc8 = info[7];
        var _loc2 = info[8];
        var _loc7 = info.slice(9, 9 + _loc2);
        var _loc3 = info[9 + _loc2];
        var _loc10 = info.slice(10 + _loc2, 10 + _loc2 + _loc3);
        var _loc4 = info[10 + _loc2 + _loc3];
        var _loc14 = info.slice(11 + _loc2 + _loc3, 11 + _loc2 + _loc3 + _loc4);
        var _loc6 = info.slice(11 + _loc2 + _loc3 + _loc4, 11 + _loc2 + _loc3 + _loc4 + 8);
        return ({uid: info[0], name: info[1], roster: info[2], status: info[3], displayName: info[5], list: _loc7, achievements: _loc10, stats: _loc14, commonInfo: _loc6, creationTime: net.wargaming.managers.Localization.longDate(info[6]), lastBattleTime: _loc8 == 0 ? ("") : (net.wargaming.managers.Localization.longDate(_loc8) + " " + net.wargaming.managers.Localization.longTime(_loc8))});
    } // End of the function
    static function getUserStatusString(status)
    {
        return (status != null ? (status == true ? ("#messenger:status/online") : ("#messenger:status/offline")) : ("#messenger:status/notAvaible"));
    } // End of the function
    static function isFriend(user)
    {
        return (Boolean(user.roster & net.wargaming.messenger.constants.UserDataFlags.ROSTER_FRIEND));
    } // End of the function
    static function isIgnored(user)
    {
        return (Boolean(user.roster & net.wargaming.messenger.constants.UserDataFlags.ROSTER_IGNORED));
    } // End of the function
    static function isMuted(user)
    {
        return (Boolean(user.roster & net.wargaming.messenger.constants.UserDataFlags.ROSTER_VOICE_MUTED));
    } // End of the function
} // End of Class
