class net.wargaming.ingame.IngameHelpDialog extends net.wargaming.Dialog
{
    var dispatchEvent, settingsButton, onMouseDown, hiddenButton;
    function IngameHelpDialog()
    {
        super();
    } // End of the function
    static function show(lobbyMode)
    {
        return (net.wargaming.Dialog.show(_root, net.wargaming.ingame.IngameHelpDialog.menuSource, {lobbyMode: lobbyMode}, lobbyMode));
    } // End of the function
    static function showCursor()
    {
        if (_root.showCursor)
        {
            _root.showCursor();
        } // end if
        _root.disableShowCursor = true;
    } // End of the function
    static function hideCursor()
    {
        _root.disableShowCursor = false;
        if (_root.hideCursor)
        {
            _root.hideCursor();
        } // end if
    } // End of the function
    function handleInput(details, pathToFocus)
    {
        if (lobbyMode)
        {
            switch (details.navEquivalent)
            {
                case gfx.ui.NavigationCode.ENTER:
                {
                    if (details.value == "keyDown")
                    {
                        this.dispatchEvent({type: "close"});
                    } // end if
                    return (true);
                } 
            } // End of switch
        } // end if
        return (super.handleInput(details, pathToFocus));
    } // End of the function
    function configUI()
    {
        if (settingsButton != null)
        {
            settingsButton.addEventListener("click", this, "handleClickSettingsButton");
        } // end if
        if (lobbyMode)
        {
            onMouseDown = handleStageClick;
        } // end if
        Selection.setFocus(hiddenButton);
        gfx.io.GameDelegate.call("battle.ingameHelp.getCommandMapping", [], this, "onGetCommandMapping");
    } // End of the function
    function handleClickSettingsButton(event)
    {
        var _loc1 = net.wargaming.SettingsDialog.show();
        net.wargaming.ingame.IngameHelpDialog.showCursor();
        _loc1.addEventListener("close", net.wargaming.ingame.IngameHelpDialog, "hideCursor");
        _loc1.addEventListener("submit", net.wargaming.ingame.IngameHelpDialog, "hideCursor");
    } // End of the function
    function onGetCommandMapping()
    {
        var _loc8 = 2;
        var _loc9 = arguments.length / _loc8;
        for (var _loc3 = 0; _loc3 < _loc9; ++_loc3)
        {
            var _loc4 = _loc3 * _loc8;
            if (arguments[_loc4] != null)
            {
                var _loc5 = arguments[_loc4];
                var _loc6 = arguments[_loc4 + 1];
                if (this[_loc5] != null && _loc6 != null)
                {
                    var _loc7 = net.wargaming.utils.StringUtils.stringToKey(_loc6);
                    this[_loc5].text = net.wargaming.utils.StringUtils.keyToUserString(_loc7);
                } // end if
            } // end if
        } // end of for
    } // End of the function
    function handleStageClick(event)
    {
        if (!lobbyMode || settingsButton.hitTest(_root._xmouse, _root._ymouse, true))
        {
            return;
        } // end if
        this.dispatchEvent({type: "close"});
    } // End of the function
    var lobbyMode = false;
    static var menuSource = "IngameHelpDialog";
} // End of Class
