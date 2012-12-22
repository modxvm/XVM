/**
 * @author sirmax2
 */
import wot.utils.Cache;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher
import wot.utils.Logger;
import wot.utils.Macros;
import wot.utils.StatLoader;
import wot.utils.StatData;
import wot.utils.Utils;
import wot.Minimap.MinimapEvent;

class wot.PlayersPanel extends net.wargaming.ingame.PlayersPanel
{
    /**
     * Sorted list of all UIDs in panel.
     * Used for Minimap syncronization.
     */
    public var m_uids:Array;
    
    static var DEBUG_TIMES = false;

    private var m_fieldType:Number = 0;
    private var m_data:Object = null;
    private var m_item:Number = 0;

    private var m_knownPlayersCount:Number = 0; // for Fog of War mode.
    private var m_postmortemIndex:Number = 0;
    
    function PlayersPanel()
    {
        super();
        Utils.TraceXvmModule("PlayersPanel");

        GlobalEventDispatcher.addEventListener("config_loaded", StatLoader.LoadLastStat);
        Config.LoadConfig("PlayersPanel.as");

        checkLoading();
    }

    // override

    function setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount)
    {
        //Logger.add("PlayersPanel.setData()");
        // fix WG bug - double redrawing panels on kill
        onEnterFrame = function()
        {
            var start = new Date();
            delete this.onEnterFrame;
            this.setData2(data, sel, postmortemIndex, isColorBlind, knownPlayersCount);
            if (PlayersPanel.DEBUG_TIMES)
                Logger.add("DEBUG TIME: PlayersPanel: setData2(" + this.m_type + "): " + Utils.elapsedMSec(start, new Date()) + " ms");
        }
    }

    private var _init:Boolean = false;
    private var _lastAdjustedState = "";

    // Centered _y value of text field
    var centeredTextY:Number;
    var leadingNames:Number;
    var leadingVehicles:Number;

    function setData2(data, sel, postmortemIndex, isColorBlind, knownPlayersCount)
    {
        //Logger.add("PlayersPanel.setData2()");
        //Logger.add(data);

        m_names.condenseWhite = !StatData.s_loaded;
        m_vehicles.condenseWhite = !StatData.s_loaded;

        if (!_init)
        {
            _init = true;
            centeredTextY = m_names._y - 5;
            m_names.verticalAlign = "top"; // for incomplete team - cannot set to "center"
            m_vehicles.verticalAlign = "top"; // for incomplete team - cannot set to "center"

            // [1/3] fix WG bug - this function is slow, don't call it if not required.
            m_list["invalidateData2"] = m_list["invalidateData"];
        }

        if (data)
        {
            for (var i in data)
                Macros.RegisterPlayerData(data[i].label, data[i]);
        }
        
        minimapUnitDeathInformator(data);

        // [2/3] fix WG bug - this function is slow, don't call it if not required.
        m_list["invalidateData"] = function() {}

        super.setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount);

        // [3/3] fix WG bug - this function is slow, don't call it if not required.
        m_list["invalidateData"] = m_list["invalidateData2"];
        
        players_bg._alpha = Config.s_config.playersPanel.alpha;
        m_list._alpha = Config.s_config.playersPanel.iconAlpha;

        if (data && m_knownPlayersCount != data.length)
        {
            m_knownPlayersCount = data.length;
            XVMAdjustPanelSize();
        }

        if (m_state != _lastAdjustedState)
        {
            XVMAdjustPanelSize();
            _lastAdjustedState = m_state;
        }

        // FIXIT: this code is not optimal. Find how to set default leading for text fields and remove this code.
        m_names.htmlText = m_names.htmlText.split('LEADING="9"').join('LEADING="' + leadingNames + '"');
        m_names._y = centeredTextY + leadingNames / 2.0; // centering on cell, because of align=top

        m_vehicles.htmlText = m_vehicles.htmlText.split('LEADING="9"').join('LEADING="' + leadingVehicles + '"');
        m_vehicles._y = centeredTextY + leadingVehicles / 2.0; // centering on cell, because of align=top
    }

    // override
    function onRecreateDevice(width, height)
    {
        //Logger.add("PlayersPanel.onRecreateDevice()");
        super.onRecreateDevice(width, height);
        XVMAdjustPanelSize();
    }

    // override
    function _setVehiclesStr(data, sel, isColorBlind, knownPlayersCount)
    {
        //Logger.add("PlayersPanel._setVehiclesStr(): knownPlayersCount=" + knownPlayersCount + " sel=" + sel);
        try
        {
            m_fieldType = Defines.FIELDTYPE_VEHICLE;
            m_data = data;
            m_item = 0;
            super._setVehiclesStr(data, sel, isColorBlind, knownPlayersCount);
        }
        finally
        {
            m_fieldType = Defines.FIELDTYPE_NONE;
            m_data = null;
            m_item = 0;
        }
    }

    // override
    function _setNamesStr(data, sel, isColorBlind, knownPlayersCount)
    {
        //Logger.add("PlayersPanel._setNameStr()");
        try
        {
            m_fieldType = Defines.FIELDTYPE_NICK;
            m_data = data;
            m_item = 0;
            super._setNamesStr(data, sel, isColorBlind, knownPlayersCount);
        }
        finally
        {
            m_fieldType = Defines.FIELDTYPE_NONE;
            m_data = null;
            m_item = 0;
        }
    }

    // override
    function updateWidthOfLongestName()
    {
        //Logger.add("PlayersPanel.updateWidthOfLongestName()");
        // do nothing
    }

    // override
    function _getHTMLText(colorScheme, text)
    {
        //Logger.add("PlayersPanel._getHTMLText()");
        if (m_fieldType == Defines.FIELDTYPE_NONE)
            return super._getHTMLText(colorScheme, text);

        var format: String = null;
        switch (m_state)
        {
            case "medium":
                if (m_fieldType == Defines.FIELDTYPE_VEHICLE)
                    break;
                format = (m_type == "left")
                    ? Config.s_config.playersPanel.medium.formatLeft
                    : Config.s_config.playersPanel.medium.formatRight;
                break;
            case "medium2":
                if (m_fieldType == Defines.FIELDTYPE_NICK)
                    break;
                format = (m_type == "left")
                    ? Config.s_config.playersPanel.medium2.formatLeft
                    : Config.s_config.playersPanel.medium2.formatRight;
                break;
            case "large":
                if (m_fieldType == Defines.FIELDTYPE_NICK)
                {
                    format = (m_type == "left")
                        ? Config.s_config.playersPanel.large.nickFormatLeft
                        : Config.s_config.playersPanel.large.nickFormatRight;
                }
                else if (m_fieldType == Defines.FIELDTYPE_VEHICLE)
                {
                    format = (m_type == "left")
                        ? Config.s_config.playersPanel.large.vehicleFormatLeft
                        : Config.s_config.playersPanel.large.vehicleFormatRight;
                }
                break;
            default:
                break;
        }

        if (format != null)
        {
            //Logger.add("before: " + text);
            var data = m_data[m_item++];
            var deadState = Utils.endsWith("dead", colorScheme) ? Defines.DEADSTATE_DEAD : Defines.DEADSTATE_ALIVE;
            var state = m_state;
            var names = m_names;
            var key = "PP/" + deadState + "/" + data.label + "/" + data.vehicle + "/" + state + "/" + m_fieldType;
            text = Cache.Get(key, function()
            {
                if ((state != "medium" && state != "medium2" && state != "large") ||
                    (format.indexOf("{{nick}}") == -1 && format.indexOf("{{name}}") == -1 && format.indexOf("{{clan}}") == -1))
                {
                    return Macros.Format(data.label, format, { darken: deadState == Defines.DEADSTATE_DEAD });
                }

                var fmt = Macros.Format(data.label, format,
                    {
                        skip: { nick:1, name:1, clan:1 },
                        darken: deadState == Defines.DEADSTATE_DEAD
                    });
                return PlayersPanel.formatNamesForWidth(
                    fmt,
                    Macros.Format(data.label, "{{nick}}"),
                    Config.s_config.playersPanel[state].width,
                    names.getNewTextFormat());
                
            });
            //Logger.add("after: " + text);
        }

        return super._getHTMLText(colorScheme, text);
    }

    /**
     * XVM
     */

    private static var s_widthTester:TextField;
    private static function createWidthTester(textFormat:TextFormat)
    {
        s_widthTester = _root.createTextField("widthTester", _root.getNextHighestDepth(), 0, 0, 268, 20);
        s_widthTester.autoSize = false;
        s_widthTester.html = true;
        s_widthTester._visible = false;
        s_widthTester.setNewTextFormat(textFormat);
    }

    private static function formatNamesForWidth(format:String, playerName: String, width:Number, textFormat:TextFormat):String
    {
        if (width < 0 || !textFormat)
            return format;

        var pname:String = "";
        var cname:String = "";
        if (width > 0)
        {
            // cut player name for field width
            pname = Utils.GetPlayerName(playerName);
            cname = Utils.GetClanNameWithBrackets(playerName);
            {
                if (s_widthTester == null)
                    createWidthTester();
                s_widthTester.condenseWhite = !StatData.s_loaded;
                while (pname + cname != "")
                {
                    s_widthTester.htmlText = format
                        .split("{{nick}}").join(pname + cname)
                        .split("{{name}}").join(pname)
                        .split("{{clan}}").join(cname);
                    if (Math.round(s_widthTester.getLineMetrics(0).width) + 4 <= width) // 4 is a size of gutters
                    {
                        //Logger.add("width=" + width + " _width=" + s_widthTester._width + " lineWidth=" + Math.round(s_widthTester.getLineMetrics(0).width) + " " + str);
                        break;
                    }
                    if (cname != "")
                        cname = cname.substr(0, cname.length - 1);
                    else
                        pname = pname.substr(0, pname.length - 1);
                }
            }
        }

        format = format.split("{{nick}}").join(pname + cname);
        format = format.split("{{name}}").join(pname);
        format = format.split("{{clan}}").join(cname);
        return format;
    }     
     
    function XVMAdjustPanelSize()
    {
        //Logger.add("PlayersPanel.XVMAdjustPanelSize()");

        var namesWidthDefault = 46;
        var namesWidth = namesWidthDefault;
        var vehiclesWidthDefault = 65;
        var vehiclesWidth = vehiclesWidthDefault;
        var widthDelta = 0;
        var squadSize = 0;
        switch (m_state)
        {
            case "medium":
                namesWidth = Math.max(XVMGetMaximumFieldWidth(m_names), Config.s_config.playersPanel.medium.width);
                widthDelta = namesWidthDefault - namesWidth;
                break;
            case "medium2":
                vehiclesWidth = Config.s_config.playersPanel.medium2.width;
                widthDelta = vehiclesWidthDefault - vehiclesWidth;
                break;
            case "large":
                namesWidthDefault = 296;
                namesWidth = Math.max(XVMGetMaximumFieldWidth(m_names), Config.s_config.playersPanel.large.width);
                vehiclesWidth = XVMGetMaximumFieldWidth(m_vehicles);
                squadSize = Config.s_config.playersPanel.removeSquadIcon ? 0 : SQUAD_SIZE;
                widthDelta = namesWidthDefault - namesWidth + vehiclesWidthDefault - vehiclesWidth - squadSize + SQUAD_SIZE;
                break;
            default:
                m_list._x = players_bg._x = (m_type == "left") ? STATES[m_state].bg_x : players_bg._width - STATES[m_state].bg_x;
                return;
        }

        m_names._width = namesWidth;
        m_vehicles._width = vehiclesWidth;

        if (m_names && m_names._visible)
            leadingNames = 29 - XVMGetMaximumFieldHeight(m_names);

        if (m_vehicles && m_vehicles._visible)
            leadingVehicles = 29 - XVMGetMaximumFieldHeight(m_vehicles);

        if (m_type == "left")
        {
            m_names._x = squadSize;
            m_frags._x = m_names._x + m_names._width;
            m_vehicles._x = m_frags._x + m_frags._width;
            m_list._x = players_bg._x = STATES[m_state].bg_x - widthDelta;
            if (squadSize > 0)
                m_list.updateSquadIconPosition(-m_list._x);
        }
        else
        {
            m_names._x = players_bg._width - m_names._width - squadSize;
            m_frags._x = m_names._x - m_frags._width;
            m_vehicles._x = m_frags._x - m_vehicles._width;
            m_list._x = players_bg._x = players_bg._width - STATES[m_state].bg_x + widthDelta;
            if (squadSize > 0)
                m_list.updateSquadIconPosition(-440 + m_names._width + m_frags._width + m_vehicles._width + squadSize);
        }
    }

    function XVMGetMaximumFieldWidth(field: TextField)
    {
        var max_width = 0;
        for (var i = 0; i < field.numLines; ++i)
        {
            var w = Math.round(field.getLineMetrics(i).width) + 4; // 4 is a size of gutters
            if (w > max_width)
                max_width = w;
        }
        return max_width;
    }

    function XVMGetMaximumFieldHeight(field: TextField)
    {
        var max_height = 0;
        for (var i = 0; i < field.numLines; ++i)
        {
            var w = Math.round(field.getLineMetrics(i).height) + 4; // 4 is a size of gutters
            if (w > max_height)
                max_height = w;
        }
        return max_height;
    }
    
    /**
     * ----------------------------------
     * Code for Minimap interaction below
     */
    
    /** Informs Minimap when both panel are loaded */
    
    private function checkLoading():Void
    {
        m_list.onEnterFrame = function()
        {
            if (this._dataProvider.length > 1)
            {
                delete this.onEnterFrame;
                
                this._parent.updateUids();
                
                if (this._itemRenderer == "RightItemRendererIcon")
                    GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.ENEMY_PLAYERS_PANEL_READY));
                else
                    GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.ALLY_PLAYERS_PANEL_READY));
            }
        }
    }
    
    /**
     * Inform Minimap when player becomes dead.
     * Enemy unit death invokes its last position marker removal.
     * Originally unit can die without event at Minimap.
     * Death event handling is essential for reliable last enemy unit position marker removal.
     */
    
     private function minimapUnitDeathInformator(data):Void
     {
         for (var i in data)
         {
             /** 2 - dead and avatar-ready state. Bitfield. See PlayersPanel\net\wargaming\ingame\VehicleStateInBattle.as */
             if (data[i].vehicleState == 2)
                GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.ENEMY_DIES, { uid: data[i].uid }));
         }
     }
}
