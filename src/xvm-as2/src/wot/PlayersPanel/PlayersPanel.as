/**
 * @author sirmax2, ilitvinov87
 */
import com.xvm.*;
import wot.Minimap.*;
//import wot.PlayersPanel.*;

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

    function updateWidthOfLongestName()
    {
        // stub
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private var m_data:Object;
    private var m_dead_noticed:Object = { };

    private var m_knownPlayersCount:Number = 0; // for Fog of War mode.
    private var m_postmortemIndex:Number = 0;

    public function PlayersPanelCtor()
    {
        Utils.TraceXvmModule("PlayersPanel");

        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, this, onConfigLoaded);
        GlobalEventDispatcher.addEventListener(Defines.E_STAT_LOADED, wrapper, wrapper.update);
        GlobalEventDispatcher.addEventListener(Defines.E_BATTLE_STATE_CHANGED, wrapper, wrapper.update);

        /** Minimap needs to know loaded status */
        checkLoading();
    }

    // PRIVATE

    private var _init:Boolean = false;

    // Centered _y value of text field
    private var centeredTextY:Number;
    private var leadingNames:Number;
    private var leadingVehicles:Number;

    private function onConfigLoaded()
    {
        setStartMode(Config.config.playersPanel.startMode, wrapper);
    }

    private function setStartMode(mode:String, wrapper:net.wargaming.ingame.PlayersPanel)
    {
        if (wrapper.state == "none")
        {
            var $this = this;
            setTimeout(function() { $this.setStartMode(mode, wrapper); }, 1);
            return;
        }

        wrapper.state = mode;
    }

    private function setDataImpl(data, sel, postmortemIndex, isColorBlind, knownPlayersCount, dead_players_count, fragsStrOrig, vehiclesStrOrig, namesStrOrig)
    {
        //Logger.add("PlayersPanel.setData(): " + wrapper.state);
        //Logger.addObject(data, 3);
        //Logger.add(vehiclesStrOrig);
        //Logger.add(namesStr);
        try
        {
            m_data = data;

            if (data == null)
                return;

            //wrapper.m_list._visible = true; // _visible == false for "none" mode
            wrapper.m_names.condenseWhite = !Stat.s_loaded;
            wrapper.m_vehicles.condenseWhite = !Stat.s_loaded;

            if (!_init)
            {
                _init = true;
                centeredTextY = wrapper.m_names._y - 5;
                wrapper.m_names.verticalAlign = "top"; // for incomplete team - cannot set to "center"
                wrapper.m_vehicles.verticalAlign = "top"; // for incomplete team - cannot set to "center"
            }

            var namesStr:String = "";
            var vehiclesStr:String = "";
            var values:Array = vehiclesStrOrig.split("<br/>");
            var len = data.length;
            for (var i = 0; i < len; ++i)
            {
                var item = data[i];
                var value = values[i];

                // fix battlestate
                var obj = BattleState.getUserData(item.userName);
                obj.frags = item.frags || NaN;
                obj.dead = (item.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) == 0;
                if (obj.dead == true && obj.curHealth > 0)
                    obj.curHealth = 0;
                if (item.himself)
                    BattleState.setSelfUserName(item.userName);

                Macros.RegisterPlayerData(item.userName, item, wrapper.type == "left" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);

                if (i != 0)
                {
                    namesStr += "<br/>";
                    vehiclesStr += "<br/>";
                }
                namesStr += value.split(item.vehicle).join(getTextValue(Defines.FIELDTYPE_NICK, item, item.userName));
                vehiclesStr += value.split(item.vehicle).join(getTextValue(Defines.FIELDTYPE_VEHICLE, item, item.vehicle));
            }

            //Logger.add(vehiclesStr);

            var deadCountPrev:Number = wrapper.saved_params[wrapper.m_type].dPC;

            base.setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount, dead_players_count, fragsStrOrig, vehiclesStr, namesStr);
            base.saveData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount, dead_players_count, fragsStrOrig, vehiclesStrOrig, namesStrOrig);

            wrapper.players_bg._alpha = Config.config.playersPanel.alpha;
            wrapper.m_list._alpha = Config.config.playersPanel.iconAlpha;

            // new player added in the FoW mode
            if (m_knownPlayersCount != data.length)
                m_knownPlayersCount = data.length;

            XVMAdjustPanelSize();

            // FIXIT: this code is not optimal. Find how to set default leading for text fields and remove this code.
            wrapper.m_names.htmlText = wrapper.m_names.htmlText.split('LEADING="9"').join('LEADING="' + leadingNames + '"');
            wrapper.m_names._y = centeredTextY + leadingNames / 2.0; // centering on cell, because of align=top

            wrapper.m_vehicles.htmlText = wrapper.m_vehicles.htmlText.split('LEADING="9"').join('LEADING="' + leadingVehicles + '"');
            wrapper.m_vehicles._y = centeredTextY + leadingVehicles / 2.0; // centering on cell, because of align=top

            // notice about dead players
            if (dead_players_count != deadCountPrev)
            {
                for (var i = len - dead_players_count; i < len; ++i)
                {
                    var item = data[i];
                    var uid:Number = item.uid;
                    if (!m_dead_noticed.hasOwnProperty(uid.toString()))
                    {
                        m_dead_noticed[uid] = true;
                        //Logger.add("dead: " + item.uid);
                        GlobalEventDispatcher.dispatchEvent( { type: Defines.E_PLAYER_DEAD, value: item.uid } );
                    }
                }
            }
        }
        catch (e:Error)
        {
            Logger.add(e.toString());
        }
    }

    private function selectPlayer(event):Void
    {
        if (m_data == null)
            return;
        var pos:Number = event.details.code == 48 ? 9 : event.details.code - 49;
        if (pos >= m_data.length)
            return;
        Logger.add("selectPlayer: " + m_data[pos].vehId);
        gfx.io.GameDelegate.call("Battle.selectPlayer", [m_data[pos].vehId]);
    }

    private function onRecreateDeviceImpl(width, height)
    {
        //Logger.add("PlayersPanel.onRecreateDevice()");
        base.onRecreateDevice(width, height);
        wrapper.update();
    }

    // PRIVATE

    private function getTextValue(fieldType, data, text)
    {
        //Logger.add("getTextValue()");
        var format:String = null;
        switch (wrapper.state)
        {
            case "medium":
                if (fieldType == Defines.FIELDTYPE_VEHICLE)
                    break;
                format = (wrapper.type == "left")
                    ? Config.config.playersPanel.medium.formatLeft
                    : Config.config.playersPanel.medium.formatRight;
                break;
            case "medium2":
                if (fieldType == Defines.FIELDTYPE_NICK)
                    break;
                format = (wrapper.type == "left")
                    ? Config.config.playersPanel.medium2.formatLeft
                    : Config.config.playersPanel.medium2.formatRight;
                break;
            case "large":
                if (fieldType == Defines.FIELDTYPE_NICK)
                {
                    format = (wrapper.type == "left")
                        ? Config.config.playersPanel.large.nickFormatLeft
                        : Config.config.playersPanel.large.nickFormatRight;
                }
                else if (fieldType == Defines.FIELDTYPE_VEHICLE)
                {
                    format = (wrapper.type == "left")
                        ? Config.config.playersPanel.large.vehicleFormatLeft
                        : Config.config.playersPanel.large.vehicleFormatRight;
                }
                break;
            default:
                break;
        }

        if (format == null)
            return text;

        //Logger.add("before: " + text);
        var obj:Object = BattleState.getUserData(data.userName);
        var fmt:String = Macros.Format(data.userName, format, obj);
        //Logger.add("after: " + fmt);
        return fmt;
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
                namesWidth = Math.max(XVMGetMaximumFieldWidth(wrapper.m_names), Config.config.playersPanel.medium.width);
                widthDelta = namesWidthDefault - namesWidth;
                break;
            case "medium2":
                vehiclesWidth = Config.config.playersPanel.medium2.width;
                widthDelta = vehiclesWidthDefault - vehiclesWidth;
                break;
            case "large":
                namesWidthDefault = 296;
                namesWidth = Math.max(XVMGetMaximumFieldWidth(wrapper.m_names), Config.config.playersPanel.large.width);
                vehiclesWidth = XVMGetMaximumFieldWidth(wrapper.m_vehicles);
                //Logger.add("w: " + vehiclesWidth + " " + wrapper.m_vehicles.htmlText);
                squadSize = Config.config.playersPanel.removeSquadIcon ? 0 : net.wargaming.ingame.PlayersPanel.SQUAD_SIZE;
                widthDelta = namesWidthDefault - namesWidth + vehiclesWidthDefault - vehiclesWidth - squadSize + net.wargaming.ingame.PlayersPanel.SQUAD_SIZE;
                break;
            default:
                wrapper.m_list._x = wrapper.players_bg._x = (wrapper.type == "left")
                    ? net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x
                    : wrapper.players_bg._width - net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x;
                GlobalEventDispatcher.dispatchEvent( {
                    type: wrapper.type == "left" ? Defines.E_LEFT_PANEL_SIZE_ADJUSTED : Defines.E_RIGHT_PANEL_SIZE_ADJUSTED,
                    state: wrapper.state
                } );
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
                wrapper.m_list.updateSquadIconPosition(-440 + wrapper.m_frags._width + wrapper.m_names._width + wrapper.m_vehicles._width + squadSize);
        }

        GlobalEventDispatcher.dispatchEvent( {
            type: wrapper.type == "left" ? Defines.E_LEFT_PANEL_SIZE_ADJUSTED : Defines.E_RIGHT_PANEL_SIZE_ADJUSTED,
            state: wrapper.state
        } );
    }

    private function XVMGetMaximumFieldWidth(field:TextField)
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

    private function XVMGetMaximumFieldHeight(field:TextField)
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
        //Logger.add("PlayersPanel.checkLoading()");

        wrapper.m_list.onEnterFrame = function()
        {
            //Logger.add("PlayersPanel.checkLoading(): frame");
            if (this._dataProvider != null && this._dataProvider.length > 0)
            {
                delete this.onEnterFrame;

                GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.PANEL_READY));
            }
        }
    }
}
