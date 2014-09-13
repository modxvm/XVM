package net.wg.gui.lobby.header.headerButtonBar
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.header.vo.HeaderButtonVo;
    import scaleform.clik.interfaces.IDataProvider;
    import scaleform.clik.data.DataProvider;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.lobby.header.vo.HBC_SettingsVo;
    import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;
    import net.wg.gui.lobby.header.vo.HBC_PremDataVo;
    import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;
    import net.wg.gui.lobby.header.vo.HBC_BattleTypeVo;
    import net.wg.gui.lobby.header.vo.HBC_FinanceVo;
    import net.wg.data.constants.Values;
    
    public class HeaderButtonsHelper extends Object implements IDisposable
    {
        
        public function HeaderButtonsHelper(param1:HeaderButtonBar)
        {
            this.settingsData = new HeaderButtonVo({"id":ITEM_ID_SETTINGS,
            "linkage":"HBC_Settings_UI",
            "direction":TextFieldAutoSize.LEFT,
            "align":TextFieldAutoSize.LEFT,
            "isUseFreeSize":false,
            "tooltip":null,
            "data":new HBC_SettingsVo(),
            "helpText":LOBBY_HELP.HEADER_SETTINGS_BUTTON,
            "helpDirection":"B",
            "helpConnectorLength":12,
            "enabled":true
        });
        this.accountData = new HeaderButtonVo({"id":ITEM_ID_ACCOUNT,
        "linkage":"HBC_Account_UI",
        "direction":TextFieldAutoSize.LEFT,
        "align":TextFieldAutoSize.LEFT,
        "isUseFreeSize":true,
        "tooltip":TOOLTIPS.HEADER_ACCOUNT,
        "data":new HBC_AccountDataVo(),
        "helpText":LOBBY_HELP.HEADER_ACCOUNT_BUTTON,
        "helpDirection":"B",
        "helpConnectorLength":39,
        "enabled":true
    });
    this.premData = new HeaderButtonVo({"id":ITEM_ID_PREM,
    "linkage":"HBC_Prem_UI",
    "direction":TextFieldAutoSize.LEFT,
    "align":TextFieldAutoSize.LEFT,
    "isUseFreeSize":false,
    "tooltip":null,
    "data":new HBC_PremDataVo(),
    "helpText":LOBBY_HELP.HEADER_PREMIUM_BUTTON,
    "helpDirection":"B",
    "helpConnectorLength":39,
    "enabled":true
});
this.squadData = new HeaderButtonVo({"id":ITEM_ID_SQUAD,
"linkage":"HBC_Squad_UI",
"direction":TextFieldAutoSize.LEFT,
"align":TextFieldAutoSize.RIGHT,
"isUseFreeSize":false,
"tooltip":null,
"data":new HBC_SquadDataVo(),
"helpText":LOBBY_HELP.HEADER_SQUAD_BUTTON,
"helpDirection":"B",
"helpConnectorLength":39,
"enabled":true
});
this.battleSelectorData = new HeaderButtonVo({"id":ITEM_ID_BATTLE_SELECTOR,
"linkage":"HBC_BattleSelector_UI",
"direction":TextFieldAutoSize.RIGHT,
"align":TextFieldAutoSize.LEFT,
"isUseFreeSize":true,
"tooltip":TOOLTIPS.HEADER_BATTLETYPE,
"data":new HBC_BattleTypeVo(),
"helpText":LOBBY_HELP.HEADER_BATTLETYPE_BUTTON,
"helpDirection":"B",
"helpConnectorLength":39,
"enabled":true
});
this.goldData = new HeaderButtonVo({"id":ITEM_ID_GOLD,
"linkage":"HBC_Finance_UI",
"direction":TextFieldAutoSize.RIGHT,
"align":TextFieldAutoSize.RIGHT,
"isUseFreeSize":false,
"tooltip":TOOLTIPS.HEADER_REFILL,
"data":new HBC_FinanceVo(),
"helpText":Values.EMPTY_STR,
"helpDirection":"B",
"helpConnectorLength":39,
"enabled":true
});
this.silverData = new HeaderButtonVo({"id":ITEM_ID_SILVER,
"linkage":"HBC_Finance_UI",
"direction":TextFieldAutoSize.RIGHT,
"align":TextFieldAutoSize.RIGHT,
"isUseFreeSize":false,
"tooltip":TOOLTIPS.HEADER_GOLD_EXCHANGE,
"data":new HBC_FinanceVo(),
"helpText":Values.EMPTY_STR,
"helpDirection":"B",
"helpConnectorLength":39,
"enabled":true
});
this.freeXPData = new HeaderButtonVo({"id":ITEM_ID_FREEXP,
"linkage":"HBC_Finance_UI",
"direction":TextFieldAutoSize.RIGHT,
"align":TextFieldAutoSize.RIGHT,
"isUseFreeSize":false,
"tooltip":TOOLTIPS.HEADER_XP_GATHERING,
"data":new HBC_FinanceVo(),
"helpText":Values.EMPTY_STR,
"helpDirection":"B",
"helpConnectorLength":39,
"enabled":true
});
super();
this._buttonsArrData = new Array(this.settingsData,this.accountData,this.premData,this.squadData,this.battleSelectorData,this.goldData,this.silverData,this.freeXPData);
this._headerButtonBar = param1;
}

public static var ITEM_ID_SETTINGS:String = "settings";

public static var ITEM_ID_ACCOUNT:String = "account";

public static var ITEM_ID_PREM:String = "prem";

public static var ITEM_ID_SQUAD:String = "squad";

public static var ITEM_ID_BATTLE_SELECTOR:String = "battleSelector";

public static var ITEM_ID_GOLD:String = "gold";

public static var ITEM_ID_SILVER:String = "silver";

public static var ITEM_ID_FREEXP:String = "freeXP";

private var settingsData:HeaderButtonVo;

private var accountData:HeaderButtonVo;

private var premData:HeaderButtonVo;

private var squadData:HeaderButtonVo;

private var battleSelectorData:HeaderButtonVo;

private var goldData:HeaderButtonVo;

private var silverData:HeaderButtonVo;

private var freeXPData:HeaderButtonVo;

private var _buttonsArrData:Array = null;

private var _headerButtonBar:HeaderButtonBar = null;

public function setData() : void
{
this._headerButtonBar.dataProvider = this.getHeaderDataProvider();
}

public function getContentDataById(param1:String) : Object
{
var _loc3_:HeaderButtonVo = null;
var _loc2_:Number = 0;
while(_loc2_ < this._buttonsArrData.length)
{
_loc3_ = this._buttonsArrData[_loc2_];
if(param1 == _loc3_.id)
{
return _loc3_.data;
}
_loc2_++;
}
return null;
}

private function getButtonDataById(param1:String) : HeaderButtonVo
{
var _loc3_:HeaderButtonVo = null;
var _loc2_:Number = 0;
while(_loc2_ < this._buttonsArrData.length)
{
_loc3_ = this._buttonsArrData[_loc2_];
if(param1 == _loc3_.id)
{
return _loc3_;
}
_loc2_++;
}
return null;
}

public function invalidateDataById(param1:String) : void
{
var _loc2_:HeaderButton = this.searchButtonById(param1);
if(_loc2_)
{
_loc2_.updateContentData();
}
}

public function setButtonEnabled(param1:String, param2:Boolean) : void
{
var _loc3_:HeaderButtonVo = this.getButtonDataById(param1);
_loc3_.enabled = param2;
if(_loc3_.headerButton)
{
_loc3_.headerButton.enabled = param2;
}
}

private function searchButtonById(param1:String) : HeaderButton
{
var _loc4_:HeaderButtonVo = null;
var _loc2_:HeaderButton = null;
var _loc3_:Number = 0;
while(_loc3_ < this._buttonsArrData.length)
{
_loc4_ = this._buttonsArrData[_loc3_];
if(param1 == _loc4_.id)
{
if(_loc4_.headerButton)
{
_loc2_ = _loc4_.headerButton;
}
break;
}
_loc3_++;
}
return _loc2_;
}

private function getHeaderDataProvider() : IDataProvider
{
return new DataProvider(this._buttonsArrData);
}

public function dispose() : void
{
}
}
}
