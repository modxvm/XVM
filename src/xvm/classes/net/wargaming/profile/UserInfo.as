intrinsic class net.wargaming.profile.UserInfo extends gfx.core.UIComponent
{
	var blocksArea;
	function setCommonInfo();
	function setStat();

    /*
    var clanEmblem, gotoAndStop, nameField, registrationDateField, lastBattleDateField, clanField, clanJoinDataField, clanPositionField, achievements, dispatchEvent, _parent, list, title, blocksArea;
    function UserInfo()
    {
        super();
    } // End of the function
    function configUI()
    {
        super.configUI();
    } // End of the function
    function setClanEmblem(clanEmblemId)
    {
        clanEmblem.setImage(clanEmblemId);
        clanEmblem._visible = true;
    } // End of the function
    function setCommonInfo()
    {
        var _loc3 = Boolean(arguments.shift());
        this.gotoAndStop(_loc3 ? (USER_INFO_FRAME.CLAN) : (USER_INFO_FRAME.NORMAL));
        nameField.htmlText = String(arguments.shift());
        registrationDateField.htmlText = String(arguments.shift());
        lastBattleDateField.htmlText = String(arguments.shift());
        clanField.htmlText = String(arguments.shift());
        clanJoinDataField.htmlText = String(arguments.shift());
        clanPositionField.htmlText = String(arguments.shift());
        var _loc4 = arguments.shift();
        clanEmblem.setImage(_loc4);
        clanEmblem._visible = false;
        achievements._y = _loc3 ? (11) : (-23);
        function onEnterFrame()
        {
            this.dispatchEvent({type: "completed"});
            delete this.onEnterFrame;
        } // End of the function
    } // End of the function
    function __hideWaiting()
    {
        _parent._parent._parent.hideWaiting();
    } // End of the function
    function updateActionMedal(id)
    {
        var _loc4 = new Object();
        _loc4.type = arguments.shift();
        _loc4.inactive = arguments.shift();
        _loc4.icon = arguments.shift();
        _loc4.rank = arguments.shift();
        _loc4.unic = arguments.shift();
        _loc4.rare = arguments.shift();
        _loc4.title = arguments.shift();
        _loc4.description = arguments.shift();
        _loc4.rareIconId = arguments.shift();
        _loc4.vehicles = new Array();
        var _loc5 = Number(arguments.shift());
        for (var _loc3 = 0; _loc3 < _loc5; ++_loc3)
        {
            _loc4.vehicles.push(String(arguments.shift()));
        } // end of for
        _loc4.last = arguments.shift();
        achievements.updateActionMedal(id, _loc4);
    } // End of the function
    function setList()
    {
        var _loc12 = new Array();
        while (arguments.length > 0)
        {
            var _loc3 = {id: arguments.shift(), name: arguments.shift(), icon: arguments.shift(), level: arguments.shift(), nation: arguments.shift(), fights: arguments.shift(), wins: arguments.shift(), vehicleClass: arguments.shift()};
            _loc12.push(_loc3);
        } // end while
        list.__set__dataProvider(_loc12);
        list.__set__selectedIndex(0);
        this.__hideWaiting();
    } // End of the function
    function setStat()
    {
        title.titleTF.text = arguments.shift();
        var _loc8 = new Array();
        var _loc9 = Number(arguments.shift());
        while (_loc9-- > 0)
        {
            var _loc3 = {name: arguments.shift()};
            _loc3.items = new Array();
            var _loc7 = Number(arguments.shift());
            while (_loc7-- > 0)
            {
                _loc3.items.push({name: arguments.shift(), value: arguments.shift(), extra: arguments.shift()});
            } // end while
            _loc8.push(_loc3);
        } // end while
        blocksArea.setData(_loc8);
        this.__hideWaiting();
    } // End of the function
    function setAchievements()
    {
        achievements.__set__dossierType(Number(arguments.shift()));
        achievements.__set__dossierCompDescr(String(arguments.shift()));
        var _loc6 = new Array();
        while (arguments.length > 0)
        {
            var _loc3 = new Object();
            _loc3.type = arguments.shift();
            _loc3.inactive = arguments.shift();
            _loc3.icon = arguments.shift();
            _loc3.rank = arguments.shift();
            _loc3.unic = arguments.shift();
            _loc3.rare = arguments.shift();
            _loc3.title = arguments.shift();
            _loc3.description = arguments.shift();
            _loc3.rareIconId = arguments.shift();
            _loc3.vehicles = new Array();
            var _loc5 = Number(arguments.shift());
            for (var _loc4 = 0; _loc4 < _loc5; ++_loc4)
            {
                _loc3.vehicles.push(String(arguments.shift()));
            } // end of for
            _loc3.last = arguments.shift();
            _loc6.push(_loc3);
        } // end while
        achievements.offsetContent = -10;
        achievements.__set__dataProvider(_loc6);
        achievements.setScrollPosition(0);
        this.__hideWaiting();
    } // End of the function
    var USER_INFO_FRAME = {CLAN: 1, NORMAL: 2};
    */
}
