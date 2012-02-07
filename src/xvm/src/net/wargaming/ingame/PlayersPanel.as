class net.wargaming.ingame.PlayersPanel extends gfx.core.UIComponent
{
    var __set__state, m_list, m_frags, m_names, m_vehicles, players_bg, __get__type, m_state, gotoAndPlay, __get__state, panel_width, _x, gotoAndStop, __set__type;
    function PlayersPanel()
    {
        super();
        Mouse.addListener(this);
        this.__set__state(net.wargaming.ingame.PlayersPanel.STATES.NONE);
    } // End of the function
    function setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount)
    {
        m_list.invalidateData();
        m_list.tabEnabled = false;
        m_list.focusEnabled = false;
        m_list.__set__dataProvider(data);
        m_list.__set__selectedIndex(sel);
        m_list.postmortemIndex = postmortemIndex;
        m_list.isColorBlind = isColorBlind;
        this._setFragsStr(data, sel, isColorBlind, knownPlayersCount);
        this._setNamesStr(data, sel, isColorBlind, knownPlayersCount);
        this._setVehiclesStr(data, sel, isColorBlind, knownPlayersCount);
        m_frags.hitTestDisable = true;
        m_names.hitTestDisable = true;
        m_vehicles.hitTestDisable = true;
        var _loc4 = 0;
        for (var _loc2 = 0; _loc2 < data.length; ++_loc2)
        {
            if ((data[_loc2].vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) == 0 && (data[_loc2].vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_UNKNOWN) == 0)
            {
                ++_loc4;
            } // end if
        } // end of for
        players_bg.setPlayersCount(knownPlayersCount != undefined ? (knownPlayersCount) : (data.length));
        players_bg.setDeadPlayers(_loc4);
        players_bg.setShowUnknowns(knownPlayersCount != undefined);
        saved_params[m_type].data = data;
        saved_params[m_type].sel = sel;
        saved_params[m_type].pIdx = postmortemIndex;
        saved_params[m_type].isCB = isColorBlind;
        saved_params[m_type].kPC = knownPlayersCount;
    } // End of the function
    function setPlayerSpeaking(vehicleId, flag)
    {
        m_list.setPlayerSpeaking(vehicleId, flag);
    } // End of the function
    function get type()
    {
        return (m_type);
    } // End of the function
    function set type(type)
    {
        if (type == "")
        {
            return;
        } // end if
        m_type = type;
        //return (this.type());
        null;
    } // End of the function
    function __getStateName(state)
    {
        return (m_type + "_" + state);
    } // End of the function
    function get state()
    {
        return (m_state);
    } // End of the function
    function set state(state)
    {
        m_state = state;
        this.gotoAndPlay(this.__getStateName(state));
        this.update();
        //return (this.state());
        null;
    } // End of the function
    function update()
    {
        if (m_list instanceof gfx.controls.ScrollingList)
        {
            this.setData(saved_params[m_type].data, saved_params[m_type].sel, saved_params[m_type].pIdx, saved_params[m_type].isCB, saved_params[m_type].kPC);
        } // end if
        net.wargaming.ingame.BattleContextMenuHandler.hideMenu();
    } // End of the function
    function onRecreateDevice(width, height)
    {
        _x = m_type == "left" ? (0) : (width - panel_width);
    } // End of the function
    function configUI()
    {
        this.gotoAndStop(m_type);
        panel_width = m_list._width;
        m_list.__set__itemRenderer(m_type == "left" ? ("LeftItemRendererIcon") : ("RightItemRendererIcon"));
        function onMouseDown(button, target)
        {
			/* fix decompiler errors (sirmax2)
			if (Mouse.RIGHT == button)
            {
                for (var _loc2 = Mouse.getTopMostEntity(); _loc2; _loc2 = _loc2._parent)
                {
                    if (_loc2 instanceof net.wargaming.ingame.PlayerListItemRenderer)
                    {
                        var _loc3 = new net.wargaming.managers.XMLKeyConverter();
                        net.wargaming.ingame.BattleContextMenuHandler.showMenu(this, _loc2.data, [[net.wargaming.messenger.MessengerUtils.isFriend(_loc2.data) ? ("removeFromFriends") : ("addToFriends")], [net.wargaming.messenger.MessengerUtils.isIgnored(_loc2.data) ? ("removeFromIgnored") : ("addToIgnored")], [{id: "appeal", label: _loc3.convert("#menu:contextMenu/appeal") + " (" + _loc2.data.denunciations + ")", disabled: _loc2.data.denunciations == 0 || _loc2.data.squad > 10}, "offend", "notFairPlay", "teamKill", "bot"], [!net.wargaming.messenger.MessengerUtils.isIgnored(_loc2.data) ? (net.wargaming.messenger.MessengerUtils.isMuted(_loc2.data) ? ("unsetMuted") : ("setMuted")) : (null)]]);
                        break;
                    } // end if
                } // end of for
            } // end if
			*/
        } // End of the function
    } // End of the function
    function getHeight()
    {
        return (players_bg.getHeight());
    } // End of the function
    function _setFragsStr(data, sel, isColorBlind, knownPlayersCount)
    {
        var _loc7 = "";
        var _loc5 = "";
        var _loc8 = 0;
        for (var _loc2 = 0; _loc2 < data.length; ++_loc2)
        {
            _loc5 = data[_loc2].frags.toString();
            _loc8 = data[_loc2].vehicleState;
            var _loc3 = (_loc8 & net.wargaming.ingame.VehicleStateInBattle.IS_AVATAR_READY) != 0;
            var _loc4 = (_loc8 & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0;
            if (_loc2 == sel)
            {
                _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("selected") : ("selected_dead"), _loc5);
                continue;
            } // end if
            if (data[_loc2].VIP)
            {
                _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("VIP") : ("VIP_dead"), _loc5);
                continue;
            } // end if
            if (data[_loc2].squad > 10)
            {
                _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("squad") : ("squad_dead"), _loc5);
                continue;
            } // end if
            if (data[_loc2].teamKiller)
            {
                _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("teamkiller") : ("teamkiller_dead"), _loc5);
                continue;
            } // end if
            _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("normal") : ("normal_dead"), _loc5);
        } // end of for
        m_frags.htmlText = _loc7;
    } // End of the function
    function _setVehiclesStr(data, sel, isColorBlind, knownPlayersCount)
    {
        var _loc7 = "";
        var _loc5 = "";
        var _loc8 = 0;
        for (var _loc2 = 0; _loc2 < data.length; ++_loc2)
        {
            _loc5 = data[_loc2].vehicle.toString();
            _loc8 = data[_loc2].vehicleState;
            var _loc3 = (_loc8 & net.wargaming.ingame.VehicleStateInBattle.IS_AVATAR_READY) != 0;
            var _loc4 = (_loc8 & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0;
            if (_loc2 == sel)
            {
                _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("selected") : ("selected_dead"), _loc5);
                continue;
            } // end if
            if (data[_loc2].VIP)
            {
                _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("VIP") : ("VIP_dead"), _loc5);
                continue;
            } // end if
            if (data[_loc2].squad > 10)
            {
                _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("squad") : ("squad_dead"), _loc5);
                continue;
            } // end if
            if (data[_loc2].teamKiller)
            {
                _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("teamkiller") : ("teamkiller_dead"), _loc5);
                continue;
            } // end if
            _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("normal") : ("normal_dead"), _loc5);
        } // end of for
        m_vehicles.htmlText = _loc7;
    } // End of the function
    function _setNamesStr(data, sel, isColorBlind, knownPlayersCount)
    {
        var _loc7 = "";
        var _loc5 = "";
        var _loc8 = 0;
        for (var _loc2 = 0; _loc2 < data.length; ++_loc2)
        {
            _loc5 = data[_loc2].label.slice(0, net.wargaming.ingame.PlayersPanel.PLAYER_NAME_LENGTH[m_state]);
            _loc8 = data[_loc2].vehicleState;
            var _loc3 = (_loc8 & net.wargaming.ingame.VehicleStateInBattle.IS_AVATAR_READY) != 0;
            var _loc4 = (_loc8 & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0;
            if (_loc2 == sel)
            {
                _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("selected") : ("selected_dead"), _loc5);
                continue;
            } // end if
            if (data[_loc2].VIP)
            {
                _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("VIP") : ("VIP_dead"), _loc5);
                continue;
            } // end if
            if (data[_loc2].squad > 10)
            {
                _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("squad") : ("squad_dead"), _loc5);
                continue;
            } // end if
            if (data[_loc2].teamKiller)
            {
                _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("teamkiller") : ("teamkiller_dead"), _loc5);
                continue;
            } // end if
            _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("normal") : ("normal_dead"), _loc5);
        } // end of for
        m_names.htmlText = _loc7;
    } // End of the function
    function _getHTMLText(colorScheme, text)
    {
        var _loc1 = net.wargaming.managers.ColorSchemeManager.__get__instance().getScheme(colorScheme).rgb;
        if (_loc1)
        {
            return ("<font color=\'#" + _loc1.toString(16) + "\'>" + text + "</font><br/>");
        } // end if
        return ("<font>" + text + "</font><br/>");
    } // End of the function
    static var STATES = {NONE: "none", SHORT: "short", MEDIUM: "medium", LARGE: "large"};
    static var PLAYERS_PANEL_COUNT = 15;
    static var PLAYER_NAME_LENGTH = {medium: 8, large: 31};
    var m_type = "";
    var saved_params = {left: {}, right: {}};
} // End of Class
