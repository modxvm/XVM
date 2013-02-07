intrinsic class net.wargaming.hangar.FinalStatistic.TeamStats extends gfx.core.UIComponent
{
    var tankHead1, tankHead2;
    var healthHead1, healthHead2;
    //var xpHead1, xpHead2;
    var iconTypeToKey;

    function configUI();
    function applySort(iconType, sortDirection);
/*
 var tankHead2, tankHead1, medalHead1, xpHead1, fragHead1, healthHead1, playerHead1, sqadHead1, team1buttons, medalHead2, xpHead2, fragHead2, healthHead2, playerHead2, sqadHead2, team2buttons, __get__parent, team1Stats, team1List, team2Stats, team2List, _parent;
    function TeamStats()
    {
        super();
    } // End of the function
    function configUI()
    {
        super.configUI();
        tankHead1.__set__selected(tankHead2.__set__selected(true));
        team1buttons = [sqadHead1, playerHead1, tankHead1, healthHead1, fragHead1, xpHead1, medalHead1];
        team2buttons = [sqadHead2, playerHead2, tankHead2, healthHead2, fragHead2, xpHead2, medalHead2];
        this.subscribeHeaders(team1buttons);
        this.subscribeHeaders(team2buttons);
        var _loc3 = this.__get__parent().__get__data();
        net.wargaming.utils.DebugUtils.LOG_DEBUG("FinalStatistic.TeamStats", _loc3);
        team1Stats.list = team1List;
        team2Stats.list = team2List;
        team2Stats._visible = team1Stats._visible = false;
        team1List.addEventListener("change", this, "onItemSelect");
        team2List.addEventListener("change", this, "onItemSelect");
        team1List.__set__dataProvider(_loc3.team1);
        team2List.__set__dataProvider(_loc3.team2);
        this.applySort("tank", "desc");
    } // End of the function
    function get parent()
    {
        return ((net.wargaming.hangar.FinalStatistic.FinalStatisticForm)(_parent._parent._parent));
    } // End of the function
    function subscribeHeaders(headers)
    {
        var _loc2 = 0;
        var _loc4 = headers.length;
        var _loc3;
        while (_loc2 < _loc4)
        {
            _loc3 = headers[_loc2];
            _loc3.addEventListener("click", this, "onHeaderClick");
            ++_loc2;
        } // end while
    } // End of the function
    function clearHeadersSelection(headers, except)
    {
        var _loc1 = 0;
        var _loc3 = headers.length;
        var _loc2;
        while (_loc1 < _loc3)
        {
            _loc2 = headers[_loc1];
            if (_loc2 != except)
            {
                _loc2.__set__selected(false);
            } // end if
            ++_loc1;
        } // end while
    } // End of the function
    function showHeaders(headers, isVisible)
    {
        var _loc1 = 0;
        var _loc3 = headers.length;
        var _loc2;
        while (_loc1 < _loc3)
        {
            _loc2 = headers[_loc1];
            _loc2.__set__visible(isVisible);
            ++_loc1;
        } // end while
    } // End of the function
    function getHeaderIndex(headers, target)
    {
        var _loc1 = 0;
        var _loc4 = headers.length;
        var _loc2;
        var _loc3 = -1;
        while (_loc1 < _loc4)
        {
            _loc2 = headers[_loc1];
            if (_loc2 == target)
            {
                _loc3 = _loc1;
                break;
            } // end if
            ++_loc1;
        } // end while
        return (_loc3);
    } // End of the function
    function onItemSelect(event)
    {
        if (event)
        {
            var _loc3 = event.target == team1List ? (team2List) : (team1List);
            _loc3.__set__selectedIndex(-1);
        } // end if
        this.showHeaders(team1buttons, team2List.__get__selectedIndex() == -1);
        team1List.__set__visible(team2List.__get__selectedIndex() == -1);
        team1Stats.__set__visible(team1List.__get__selectedIndex() > -1);
        team1Stats.__set__data(team1List.__get__selectedIndex() > -1 ? (team1List.__get__dataProvider()[event.index]) : (null));
        this.showHeaders(team2buttons, team1List.__get__selectedIndex() == -1);
        team2List.__set__visible(team1List.__get__selectedIndex() == -1);
        team2Stats.__set__visible(team2List.__get__selectedIndex() > -1);
        team2Stats.__set__data(team2List.__get__selectedIndex() > -1 ? (team2List.__get__dataProvider()[event.index]) : (null));
    } // End of the function
    function onHeaderClick(event)
    {
        var _loc2 = event.target;
        this.clearHeadersSelection(team1buttons, _loc2);
        this.clearHeadersSelection(team2buttons, _loc2);
        var _loc3 = this.getHeaderIndex(team1buttons, _loc2);
        var _loc4;
        if (_loc3 > -1)
        {
            _loc4 = team2buttons[_loc3];
        }
        else
        {
            _loc3 = this.getHeaderIndex(team2buttons, _loc2);
            _loc4 = team1buttons[_loc3];
        } // end else if
        if (_loc4)
        {
            _loc4.__set__selected(true);
            _loc4.__set__sortDirection(_loc2.sortDirection);
        } // end if
        this.applySort(event.iconType, event.sortDirection);
        this.onItemSelect();
    } // End of the function
    function applySort(iconType, sortDirection)
    {
        var _loc2 = 0;
        if (iconTypeToKey[iconType].isNumeric)
        {
            _loc2 = _loc2 | Array.NUMERIC;
        }
        else
        {
            _loc2 = _loc2 | Array.CASEINSENSITIVE;
        } // end else if
        if (sortDirection == "desc")
        {
            _loc2 = _loc2 | Array.DESCENDING;
        } // end if
        var _loc3 = team1List.__get__dataProvider().slice();
        _loc3.sortOn(iconTypeToKey[iconType].key, _loc2);
        team1List.__set__selectedIndex(-1);
        team1List.__set__dataProvider(_loc3);
        _loc3 = team2List.__get__dataProvider().slice();
        _loc3.sortOn(iconTypeToKey[iconType].key, _loc2);
        team2List.__set__selectedIndex(-1);
        team2List.__set__dataProvider(_loc3);
    } // End of the function
    static var MAX_TEAM_LEN = 15;
    var iconTypeToKey = {squad: {key: "prebattleID", isNumeric: true}, player: {key: "playerName", isNumeric: false}, tank: {key: "vehicleSort", isNumeric: true}, health: {key: "healthPercents", isNumeric: true}, frag: {key: "realKills", isNumeric: true}, xp: {key: "xp", isNumeric: true}, medal: {key: "medalsCount", isNumeric: true}};
*/
}
