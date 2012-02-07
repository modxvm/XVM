class net.wargaming.Account
{
    static var _nations;
    function Account()
    {
    } // End of the function
    static function get attrs()
    {
        return (net.wargaming.Account.accountAttrs);
    } // End of the function
    static function get denunciations()
    {
        return (net.wargaming.Account.denunciationsCount);
    } // End of the function
    static function __addCallBack(type, scope, callBack)
    {
        if (!net.wargaming.Account.initialized)
        {
            net.wargaming.Account.initialize();
        } // end if
        net.wargaming.Account.callBackHash[type].push([scope, callBack]);
        return (net.wargaming.Account.initialValues[type]);
    } // End of the function
    static function addCreditsCallBack(scope, callBack)
    {
        return (net.wargaming.Account.__addCallBack("credits", scope, callBack));
    } // End of the function
    static function addPremiumCallBack(scope, callBack)
    {
        return (net.wargaming.Account.__addCallBack("premium", scope, callBack));
    } // End of the function
    static function addGoldCallBack(scope, callBack)
    {
        return (net.wargaming.Account.__addCallBack("gold", scope, callBack));
    } // End of the function
    static function addExperienceCallBack(scope, callBack)
    {
        return (net.wargaming.Account.__addCallBack("experience", scope, callBack));
    } // End of the function
    static function addVehicleChangeCallBack(scope, callBack)
    {
        return (net.wargaming.Account.__addCallBack("vehicleChange", scope, callBack));
    } // End of the function
    static function addPlayerSpeakingCallBack(scope, callBack)
    {
        return (net.wargaming.Account.__addCallBack("speakingPlayer", scope, callBack));
    } // End of the function
    static function initialize()
    {
        initialized = true;
        gfx.io.GameDelegate.addCallBack("common.experienceResponse", net.wargaming.Account, "setExp");
        gfx.io.GameDelegate.addCallBack("common.creditsResponse", net.wargaming.Account, "setCredits");
        gfx.io.GameDelegate.addCallBack("common.goldResponse", net.wargaming.Account, "setGold");
        gfx.io.GameDelegate.addCallBack("common.premiumResponse", net.wargaming.Account, "setPremium");
        gfx.io.GameDelegate.addCallBack("common.vehicleChangeResponse", net.wargaming.Account, "setVehicleChange");
        gfx.io.GameDelegate.addCallBack("common.speakingPlayersResponse", net.wargaming.Account, "setPlayerSpeaking");
        gfx.io.GameDelegate.addCallBack("common.accountAttrs", net.wargaming.Account, "setAccountAttrs");
        gfx.io.GameDelegate.addCallBack("common.denunciations", net.wargaming.Account, "setDenunciations");
        gfx.io.GameDelegate.addCallBack("common.nations", net.wargaming.Account, "setNations");
    } // End of the function
    static function setAccountAttrs(value)
    {
        accountAttrs = value;
    } // End of the function
    static function setDenunciations(value)
    {
        denunciationsCount = value;
    } // End of the function
    static function setExp(value)
    {
        net.wargaming.Account.notifyCallbacks("experience", value);
    } // End of the function
    static function setCredits(value)
    {
        net.wargaming.Account.notifyCallbacks("credits", value);
    } // End of the function
    static function setGold(value)
    {
        net.wargaming.Account.notifyCallbacks("gold", value);
    } // End of the function
    static function setPremium(value)
    {
        net.wargaming.Account.notifyCallbacks("premium", value);
    } // End of the function
    static function setVehicleChange(value)
    {
        net.wargaming.Account.notifyCallbacks("vehicleChange", value);
    } // End of the function
    static function setPlayerSpeaking(dbID, isSpeak, isSelf)
    {
        net.wargaming.Account.notifyCallbacks("speakingPlayer", {playerID: dbID, speaking: isSpeak, self: isSelf});
    } // End of the function
    static function setNations()
    {
        _nations = [];
        while (arguments.length != 0)
        {
            net.wargaming.Account._nations.push(String(arguments.shift()));
        } // end while
    } // End of the function
    static function get nations()
    {
        return (net.wargaming.Account._nations);
    } // End of the function
    static function notifyCallbacks(type, value)
    {
        var _loc5 = net.wargaming.Account.callBackHash[type];
        net.wargaming.Account.setInitialValue(type, value);
        for (var _loc1 = 0; _loc1 < _loc5.length; ++_loc1)
        {
            var _loc2 = _loc5[_loc1];
            var _loc3 = _loc2[0];
            var _loc4 = _loc2[1];
            _loc3[_loc4].apply(_loc3, [value]);
        } // end of for
    } // End of the function
    static function setInitialValue(type, value)
    {
        if (net.wargaming.Account.initialValues[type] != undefined)
        {
            net.wargaming.Account.initialValues[type] = value;
        } // end if
    } // End of the function
    static var ACCOUNT_ATTR = {BATTLE_XP: 1, TRADING: 2, CLAN: 4, MERCENARY: 8, RATING: 16, USER_INFO: 32, STATISTICS: 64, ARENA_CHANGE: 128, CHAT_ADMIN: 256, ADMIN: 512, ROAMING: 1024};
    static var accountAttrs = 0;
    static var denunciationsCount = 0;
    static var initialized = false;
    static var callBackHash = {experience: [], credits: [], gold: [], premium: [], vehicleChange: [], speakingPlayer: []};
    static var initialValues = {experience: 0, credits: 0, gold: 0, denunciations: 0, premium: false};
} // End of Class
