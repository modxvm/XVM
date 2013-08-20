/**
 * @author sirmax2, ilitvinov87
 */
import com.xvm.Cache;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Logger;
import com.xvm.Macros;
import com.xvm.StatData;
import com.xvm.StatLoader;
import com.xvm.Strings;
import com.xvm.Utils;
import com.xvm.AutoUpdate;
import wot.Minimap.MinimapEvent;
import wot.PlayersPanel.PlayerListItemRenderer;
import wot.PlayersPanel.SpotStatusModel;

class wot.PlayersPanel.PlayersPanel
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    private var wrapper:net.wargaming.ingame.PlayersPanel;
    private var base:net.wargaming.ingame.PlayersPanel;

    public function PlayersPanel(wrapper:net.wargaming.ingame.PlayersPanel, base:net.wargaming.ingame.PlayersPanel)
    {
        this.wrapper = wrapper;
        this.base = base;
        wrapper.xvm_worker = this;
        PlayersPanelCtor();
    }
    
    function setData()
    {
        return this.setDataImpl.apply(this, arguments);
    }

    function onRecreateDevice()
    {
        return this.onRecreateDeviceImpl.apply(this, arguments);
    }

    function _setVehiclesStr()
    {
        return this._setVehiclesStrImpl.apply(this, arguments);
    }

    function _setNamesStr()
    {
        return this._setNamesStrImpl.apply(this, arguments);
    }

    function updateWidthOfLongestName()
    {
        // stub
    }

    function _getHTMLText()
    {
        return this._getHTMLTextImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

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

    private var spotStatusModel:SpotStatusModel;

    public function PlayersPanelCtor()
    {
        Utils.TraceXvmModule("PlayersPanel");

        GlobalEventDispatcher.addEventListener(Config.E_CONFIG_LOADED, StatLoader.instance, StatLoader.instance.LoadLastStat);
        GlobalEventDispatcher.addEventListener(Config.E_CONFIG_LOADED, this, onConfigLoaded);
        GlobalEventDispatcher.addEventListener(StatData.E_STAT_LOADED, this, onStatLoaded);
        
        GlobalEventDispatcher.addEventListener(AutoUpdate.UPDATE_BY_TIMER_EVENT, this, updateSpotStatusMarkers);
        
        Config.LoadConfig();
        
        /** Minimap needs to know loaded status */
        checkLoading();
    }

    private function onConfigLoaded(event):Void
    {
        // init enemy spotter markers
        if (isEnemyPanel && Config.s_config.playersPanel.enemySpottedMarker.enabled && spotStatusModel == null)
        {
            spotStatusModel = new SpotStatusModel();
        }
    }

    private function onStatLoaded()
    {
        _lastAdjustedState = "";
        wrapper.update();
    }

    /**
     * Refreshes Enemy spot status marker.
     * Invoked by AutoUpdate event each 300ms.
     */
    public function updateSpotStatusMarkers():Void
    {
        if (!isEnemyPanel || !Config.s_config.playersPanel.enemySpottedMarker.enabled)
            return;

        /** Redraw every renderer */
        for (var i in wrapper.m_list.renderers)
        {
            var renderer:PlayerListItemRenderer = net.wargaming.ingame.PlayerListItemRenderer(wrapper.m_list.renderers[i]).xvm_worker;
            var uid:Number = renderer.wrapper.data.uid;
            var status:Number = spotStatusModel.defineStatus(uid, renderer.wrapper.data.vehicleState);
            var subjectIsArtillery:Boolean = spotStatusModel.isArty(uid);
            renderer.spotStatusView.update(status, subjectIsArtillery);
        }
    }

    private function setDataImpl(data, sel, postmortemIndex, isColorBlind, knownPlayersCount)
    {
        //Logger.add("PlayersPanel.setData()");
        // fix WG bug - double redrawing panels on kill
        var me = this;
        wrapper.onEnterFrame = function()
        {
            var start = new Date();
            delete this.onEnterFrame;
            me.setData2(data, sel, postmortemIndex, isColorBlind, knownPlayersCount);
            if (PlayersPanel.DEBUG_TIMES)
                Logger.add("DEBUG TIME: PlayersPanel: setData2(" + this.m_type + "): " + Utils.elapsedMSec(start, new Date()) + " ms");
        }
    }

    private var _init:Boolean = false;
    private var _lastAdjustedState = "";

    // Centered _y value of text field
    private var centeredTextY:Number;
    private var leadingNames:Number;
    private var leadingVehicles:Number;

    private function selectPlayer(event):Void
    {
        if (m_data == null)
            return;
        var pos:Number = event.details.code == 48 ? 9 : event.details.code - 49;
        if (pos < m_data.length)
            Logger.add("selectPlayer: " + m_data[pos].vehId);
            gfx.io.GameDelegate.call("Battle.selectPlayer", [m_data[pos].vehId]);
    }
    
    private function setData2(data, sel, postmortemIndex, isColorBlind, knownPlayersCount)
    {
        //Logger.add("PlayersPanel.setData2()");
        //Logger.add(data);

        m_data = data;

        wrapper.m_names.condenseWhite = !StatData.s_loaded;
        wrapper.m_vehicles.condenseWhite = !StatData.s_loaded;

        if (!_init)
        {
            _init = true;
            centeredTextY = wrapper.m_names._y - 5;
            wrapper.m_names.verticalAlign = "top"; // for incomplete team - cannot set to "center"
            wrapper.m_vehicles.verticalAlign = "top"; // for incomplete team - cannot set to "center"

            // [1/3] fix WG bug - this function is slow, don't call it if not required.
            wrapper.m_list["invalidateData2"] = wrapper.m_list["invalidateData"];
        }

        if (data)
        {
            for (var i in data)
            {
                Macros.RegisterPlayerData(Utils.GetNormalizedPlayerName(data[i].label), data[i],
                    wrapper.type == "left" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);
            }
        }

        // [2/3] fix WG bug - this function is slow, don't call it if not required.
        wrapper.m_list["invalidateData"] = function() {}

        base.setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount);

        // [3/3] fix WG bug - this function is slow, don't call it if not required.
        wrapper.m_list["invalidateData"] = wrapper.m_list["invalidateData2"];

        wrapper.players_bg._alpha = Config.s_config.playersPanel.alpha;
        wrapper.m_list._alpha = Config.s_config.playersPanel.iconAlpha;

        if (data && m_knownPlayersCount != data.length)
        {
            m_knownPlayersCount = data.length;
            XVMAdjustPanelSize();
        }

        if (wrapper.state != _lastAdjustedState)
        {
            XVMAdjustPanelSize();
            _lastAdjustedState = wrapper.state;
        }

        // FIXIT: this code is not optimal. Find how to set default leading for text fields and remove this code.
        wrapper.m_names.htmlText = wrapper.m_names.htmlText.split('LEADING="9"').join('LEADING="' + leadingNames + '"');
        wrapper.m_names._y = centeredTextY + leadingNames / 2.0; // centering on cell, because of align=top

        wrapper.m_vehicles.htmlText = wrapper.m_vehicles.htmlText.split('LEADING="9"').join('LEADING="' + leadingVehicles + '"');
        wrapper.m_vehicles._y = centeredTextY + leadingVehicles / 2.0; // centering on cell, because of align=top
    }

    private function onRecreateDeviceImpl(width, height)
    {
        //Logger.add("PlayersPanel.onRecreateDevice()");
        base.onRecreateDevice(width, height);
        XVMAdjustPanelSize();
    }

    private function _setVehiclesStrImpl(data, sel, isColorBlind, knownPlayersCount)
    {
        //Logger.add("PlayersPanel._setVehiclesStr(): knownPlayersCount=" + knownPlayersCount + " sel=" + sel);
        try
        {
            m_fieldType = Defines.FIELDTYPE_VEHICLE;
            m_item = 0;
            base._setVehiclesStr(data, sel, isColorBlind, knownPlayersCount);
        }
        finally
        {
            m_fieldType = Defines.FIELDTYPE_NONE;
            m_item = 0;
        }
    }

    private function _setNamesStrImpl(data, sel, isColorBlind, knownPlayersCount)
    {
        //Logger.add("PlayersPanel._setNameStr()");
        try
        {
            m_fieldType = Defines.FIELDTYPE_NICK;
            m_item = 0;
            base._setNamesStr(data, sel, isColorBlind, knownPlayersCount);
        }
        finally
        {
            m_fieldType = Defines.FIELDTYPE_NONE;
            m_item = 0;
        }
    }

    private function _getHTMLTextImpl(colorScheme, text)
    {
        //Logger.add("PlayersPanel._getHTMLText()");
        if (m_fieldType == Defines.FIELDTYPE_NONE)
            return base._getHTMLText(colorScheme, text);

        var format: String = null;
        switch (wrapper.state)
        {
            case "medium":
                if (m_fieldType == Defines.FIELDTYPE_VEHICLE)
                    break;
                format = (wrapper.type == "left")
                    ? Config.s_config.playersPanel.medium.formatLeft
                    : Config.s_config.playersPanel.medium.formatRight;
                break;
            case "medium2":
                if (m_fieldType == Defines.FIELDTYPE_NICK)
                    break;
                format = (wrapper.type == "left")
                    ? Config.s_config.playersPanel.medium2.formatLeft
                    : Config.s_config.playersPanel.medium2.formatRight;
                break;
            case "large":
                if (m_fieldType == Defines.FIELDTYPE_NICK)
                {
                    format = (wrapper.type == "left")
                        ? Config.s_config.playersPanel.large.nickFormatLeft
                        : Config.s_config.playersPanel.large.nickFormatRight;
                }
                else if (m_fieldType == Defines.FIELDTYPE_VEHICLE)
                {
                    format = (wrapper.type == "left")
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
            var deadState = Strings.endsWith("dead", colorScheme) ? Defines.DEADSTATE_DEAD : Defines.DEADSTATE_ALIVE;
            var state = wrapper.state;
            var field = state == "medium2" ? wrapper.m_vehicles : wrapper.m_names;
            var pname = Utils.GetNormalizedPlayerName(data.label);
            var key = "PP/" + deadState + "/" + pname + "/" + state + "/" + m_fieldType + "/" +
                (StatData.s_data[pname] ? StatData.s_data[pname].loadstate : "0");
            //Logger.add(key);
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
                    field.getNewTextFormat());
            });
            //Logger.add("after: " + text);
        }

        return base._getHTMLText(colorScheme, text);
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

    private function XVMAdjustPanelSize()
    {
        //Logger.add("PlayersPanel.XVMAdjustPanelSize()");

        var namesWidthDefault = 46;
        var namesWidth = namesWidthDefault;
        var vehiclesWidthDefault = 65;
        var vehiclesWidth = vehiclesWidthDefault;
        var widthDelta = 0;
        var squadSize = 0;
        switch (wrapper.state)
        {
            case "medium":
                namesWidth = Math.max(XVMGetMaximumFieldWidth(wrapper.m_names), Config.s_config.playersPanel.medium.width);
                widthDelta = namesWidthDefault - namesWidth;
                break;
            case "medium2":
                vehiclesWidth = Config.s_config.playersPanel.medium2.width;
                widthDelta = vehiclesWidthDefault - vehiclesWidth;
                break;
            case "large":
                namesWidthDefault = 296;
                namesWidth = Math.max(XVMGetMaximumFieldWidth(wrapper.m_names), Config.s_config.playersPanel.large.width);
                vehiclesWidth = XVMGetMaximumFieldWidth(wrapper.m_vehicles);
                squadSize = Config.s_config.playersPanel.removeSquadIcon ? 0 : net.wargaming.ingame.PlayersPanel.SQUAD_SIZE;
                widthDelta = namesWidthDefault - namesWidth + vehiclesWidthDefault - vehiclesWidth - squadSize + net.wargaming.ingame.PlayersPanel.SQUAD_SIZE;
                break;
            default:
                wrapper.m_list._x = wrapper.players_bg._x = (wrapper.type == "left")
                    ? net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x
                    : wrapper.players_bg._width - net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x;
                return;
        }

        wrapper.m_names._width = namesWidth;
        wrapper.m_vehicles._width = vehiclesWidth;

        if (wrapper.m_names && wrapper.m_names._visible)
            leadingNames = 29 - XVMGetMaximumFieldHeight(wrapper.m_names);

        if (wrapper.m_vehicles && wrapper.m_vehicles._visible)
            leadingVehicles = 29 - XVMGetMaximumFieldHeight(wrapper.m_vehicles);

        if (wrapper.type == "left")
        {
            wrapper.m_names._x = squadSize;
            wrapper.m_frags._x = wrapper.m_names._x + wrapper.m_names._width;
            wrapper.m_vehicles._x = wrapper.m_frags._x + wrapper.m_frags._width;
            wrapper.m_list._x = wrapper.players_bg._x = net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x - widthDelta;
            if (squadSize > 0)
                wrapper.m_list.updateSquadIconPosition(-wrapper.m_list._x);
        }
        else
        {
            wrapper.m_names._x = wrapper.players_bg._width - wrapper.m_names._width - squadSize;
            wrapper.m_frags._x = wrapper.m_names._x - wrapper.m_frags._width;
            wrapper.m_vehicles._x = wrapper.m_frags._x - wrapper.m_vehicles._width;
            wrapper.m_list._x = wrapper.players_bg._x = wrapper.players_bg._width - net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x + widthDelta;
            if (squadSize > 0)
                wrapper.m_list.updateSquadIconPosition(-440 + wrapper.m_names._width + wrapper.m_frags._width + wrapper.m_vehicles._width + squadSize);
        }
    }

    private function XVMGetMaximumFieldWidth(field: TextField)
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

    private function XVMGetMaximumFieldHeight(field: TextField)
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

    /** Informs Minimap when PlayersPanel is loaded */
    private function checkLoading():Void
    {
        wrapper.m_list.onEnterFrame = function()
        {
            if (this._dataProvider.length > 0)
            {
                delete this.onEnterFrame;

                this._parent.updateUids();

                GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.PANEL_READY));
            }
        }
    }

    private function get isEnemyPanel():Boolean
    {
        return wrapper.type == "right";
    }
}
