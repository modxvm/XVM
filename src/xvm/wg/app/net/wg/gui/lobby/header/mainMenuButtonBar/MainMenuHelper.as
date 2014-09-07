package net.wg.gui.lobby.header.mainMenuButtonBar
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.interfaces.IDataProvider;
    
    public class MainMenuHelper extends Object implements IDisposable
    {
        
        public function MainMenuHelper(param1:MainMenuButtonBar)
        {
            this._buttonsArr = new DataProvider([{"label":MENU.HEADERBUTTONS_HANGAR,
            "value":"hangar",
            "subValues":[],
            "textColor":16764006,
            "textColorOver":16768409,
            "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_HANGAR
        },{"label":MENU.HEADERBUTTONS_INVENTORY,
        "value":"inventory",
        "subValues":[],
        "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_INVENTORY,
        "helpText":LOBBY_HELP.HEADER_MENU_INVENTORY,
        "helpDirection":"B",
        "helpConnectorLength":32
    },{"label":MENU.HEADERBUTTONS_SHOP,
    "value":"shop",
    "subValues":[],
    "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_SHOP,
    "helpText":LOBBY_HELP.HEADER_MENU_SHOP,
    "helpDirection":"B",
    "helpConnectorLength":82
},{"label":MENU.HEADERBUTTONS_PROFILE,
"value":"profile",
"subValues":[],
"tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_PROFILE,
"helpText":LOBBY_HELP.HEADER_MENU_PROFILE,
"helpDirection":"B",
"helpConnectorLength":32
},{"label":MENU.HEADERBUTTONS_TECHTREE,
"value":"techtree",
"subValues":["research"],
"tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_TECHTREE,
"helpText":LOBBY_HELP.HEADER_MENU_TECHTREE,
"helpDirection":"B",
"helpConnectorLength":32
},{"label":MENU.HEADERBUTTONS_BARRACKS,
"value":"barracks",
"subValues":[],
"tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_BARRACKS
}]);
super();
if(App.globalVarsMgr.isChinaS())
{
this._buttonsArr.push({"label":MENU.HEADERBUTTONS_BROWSER,
"value":"browser",
"subValues":[],
"tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_BROWSER
});
}
if(App.globalVarsMgr.isFortificationAvailableS())
{
this._buttonsArr.push({"label":MENU.HEADERBUTTONS_FORTS,
"value":"FortificationsView",
"subValues":[],
"tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_FORTS
});
}
this._headerButtonBar = param1;
this._headerButtonBar.selectedIndex = -1;
this._headerButtonBar.validateNow();
this._headerButtonBar.dataProvider = this.mainMenuDataProvider;
}

private var _current:String = "hangar";

private var _headerButtonBar:MainMenuButtonBar;

private var _buttonsArr:DataProvider;

public function setCurrent(param1:String) : void
{
var _loc3_:* = NaN;
this._current = param1;
this._headerButtonBar.selectedIndex = -1;
this._headerButtonBar.enabled = !(this._current == "prebattle");
var _loc2_:Number = 0;
while(_loc2_ < this._buttonsArr.length)
{
if(this._current == this._buttonsArr[_loc2_].value)
{
this._headerButtonBar.selectedIndex = _loc2_;
}
else
{
_loc3_ = 0;
while(_loc3_ < this._buttonsArr[_loc2_].subValues.length)
{
if(this._current == this._buttonsArr[_loc2_].subValues[_loc3_])
{
this._headerButtonBar.subItemSelectedIndex = _loc2_;
}
_loc3_++;
}
}
_loc2_++;
}
}

private function get mainMenuDataProvider() : IDataProvider
{
return this._buttonsArr;
}

public function dispose() : void
{
this._buttonsArr = null;
this._headerButtonBar = null;
}
}
}
