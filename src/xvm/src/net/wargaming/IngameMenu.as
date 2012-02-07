class net.wargaming.IngameMenu extends net.wargaming.Dialog
{
    var mustReopen, settingsBtn, quitBattleBtn, quitBtn, _name;
    function IngameMenu()
    {
        super();
        mustReopen = true;
    } // End of the function
    function getReopenCallerObject()
    {
        return ({scope: net.wargaming.IngameMenu, method: "show"});
    } // End of the function
    static function show()
    {
        var _loc2 = net.wargaming.Dialog.show(_root, net.wargaming.IngameMenu.menuSource, {}, true);
        _loc2.addEventListener("close", net.wargaming.IngameMenu, "hideCursor");
        _loc2.isShow = true;
        net.wargaming.IngameMenu.showCursor();
        return (_loc2);
    } // End of the function
    static function leave()
    {
        gfx.controls.Dialog.hide();
        fscommand("battle.leave");
    } // End of the function
    static function hideCursor()
    {
        _root.disableShowCursor = false;
        _root.hideCursor();
    } // End of the function
    static function showCursor()
    {
        _root.showCursor();
        _root.disableShowCursor = true;
    } // End of the function
    function populateUI()
    {
        if (settingsBtn != null)
        {
            settingsBtn.addEventListener(gfx.events.EventTypes.CLICK, this, "handleClickSettingsButton");
        } // end if
        if (quitBattleBtn != null)
        {
            quitBattleBtn.addEventListener(gfx.events.EventTypes.CLICK, this, "handleClickQuitBattleButton");
        } // end if
        if (quitBtn != null)
        {
            quitBtn.addEventListener(gfx.events.EventTypes.CLICK, this, "handleClickQuitButton");
        } // end if
        if (isShow && _name != "ingameMenu")
        {
            _name = "ingameMenu";
        } // end if
    } // End of the function
    function handleClickSettingsButton(event)
    {
        var _loc1 = net.wargaming.SettingsDialog.show();
    } // End of the function
    function handleClickQuitBattleButton(event)
    {
        var _loc1 = net.wargaming.notification.MessageDialog.show("quitBattle");
        _loc1._name = "QuitBattleConfirmDialog";
        _loc1.addEventListener("submit", net.wargaming.IngameMenu, "leave");
    } // End of the function
    function handleClickQuitButton(event)
    {
        var _loc1 = net.wargaming.notification.MessageDialog.show("quit");
        _loc1.addEventListener("submit", net.wargaming.GameCommands, "quit");
    } // End of the function
    static var menuSource = "IngameMenu";
    var isShow = false;
} // End of Class
