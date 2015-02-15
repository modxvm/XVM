/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy(at)gmail.com>
 * @author ilitvinov87
 */
import com.xvm.*;
import com.xvm.events.*;
import gfx.controls.*;
import wot.Minimap.*;

class wot.PlayersPanel.PlayersPanel extends XvmComponent
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

    function update()
    {
        return this.updateImpl.apply(this, arguments);
    }

    function updateAlphas()
    {
        return this.updateAlphasImpl.apply(this, arguments);
    }

    function updateWidthOfLongestName()
    {
        // stub
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private var m_data_arguments:Array;
    private var m_data:Object;
    private var m_dead_noticed:Object = { };

    private var m_knownPlayersCount:Number = 0; // for Fog of War mode.
    private var m_postmortemIndex:Number = 0;

    public function PlayersPanelCtor()
    {
        Utils.TraceXvmModule("PlayersPanel");

        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, this, onConfigLoaded);
        GlobalEventDispatcher.addEventListener(Defines.E_UPDATE_STAGE, this, updateWithoutHideMenu);
        GlobalEventDispatcher.addEventListener(Defines.E_STAT_LOADED, this, updateWithoutHideMenu);
        GlobalEventDispatcher.addEventListener(Events.E_BATTLE_STATE_CHANGED, this, updateWithoutHideMenu);
    }

    // PRIVATE

    // Centered _y value of text field
    private var centeredTextY:Number;

    private var m_altMode:String = null;
    private var m_savedState:String = null;
    private var m_initialized = false;

    private function onConfigLoaded()
    {
        var cfg:Object = Config.config.playersPanel;
        var startMode:String = String(cfg.startMode).toLowerCase();
        if (net.wargaming.ingame.PlayersPanel.STATES[startMode] == null)
            startMode = net.wargaming.ingame.PlayersPanel.STATES.large.name;
        cfg[startMode].enabled = true;
        setStartMode(startMode, wrapper);

        m_savedState = null;
        m_altMode = String(cfg.altMode).toLowerCase();
        if (net.wargaming.ingame.PlayersPanel.STATES[m_altMode] == null)
            m_altMode = null;
        if (m_altMode != null)
            GlobalEventDispatcher.addEventListener(Defines.E_PP_ALT_MODE, this, setAltMode);

        _root.switcher_mc.noneBtn.enabled = cfg[net.wargaming.ingame.PlayersPanel.STATES.none.name].enabled;
        _root.switcher_mc.shortBtn.enabled = cfg[net.wargaming.ingame.PlayersPanel.STATES.short.name].enabled;
        _root.switcher_mc.mediumBtn.enabled = cfg[net.wargaming.ingame.PlayersPanel.STATES.medium.name].enabled;
        _root.switcher_mc.mediumBtn2.enabled = cfg[net.wargaming.ingame.PlayersPanel.STATES.medium2.name].enabled;
        _root.switcher_mc.largeBtn.enabled = cfg[net.wargaming.ingame.PlayersPanel.STATES.large.name].enabled;
        _root.switcher_mc.noneBtn._alpha = _root.switcher_mc.noneBtn.enabled ? 100 : 50;
        _root.switcher_mc.shortBtn._alpha = _root.switcher_mc.shortBtn.enabled ? 100 : 50;
        _root.switcher_mc.mediumBtn._alpha = _root.switcher_mc.mediumBtn.enabled ? 100 : 50;
        _root.switcher_mc.mediumBtn2._alpha = _root.switcher_mc.mediumBtn2.enabled ? 100 : 50;
        _root.switcher_mc.largeBtn._alpha = _root.switcher_mc.largeBtn.enabled ? 100 : 50;
    }

    private function setStartMode(mode:String, wrapper:net.wargaming.ingame.PlayersPanel)
    {
        if (wrapper.state == "none")
        {
            var $this = this;
            setTimeout(function() { $this.setStartMode(mode, wrapper); }, 1);
            return;
        }

        m_initialized = true;

        wrapper.state = mode;
        updateSwitcherButton();

        // initialize

        centeredTextY = wrapper.m_names._y - 5;
        wrapper.m_names.condenseWhite = false;
        wrapper.m_vehicles.condenseWhite = false;
        wrapper.m_frags.wordWrap = false;
        wrapper.m_names.verticalAlign = "top"; // for incomplete team - cannot set to "center"
        wrapper.m_vehicles.verticalAlign = "top"; // for incomplete team - cannot set to "center"
    }

    private var isAltMode:Boolean = false;
    private function setAltMode(e:Object)
    {
        //Logger.add("setAltMode: " + e.isDown + " " + m_altMode + " " + wrapper.state);

        if (m_altMode == null)
            return;

        if (Config.config.hotkeys.playersPanelAltMode.onHold)
            isAltMode = e.isDown;
        else if (e.isDown)
            isAltMode = !isAltMode;
        else
            return;

        if (isAltMode)
        {
            if (m_savedState == null)
                m_savedState = wrapper.state;
            wrapper.state = m_altMode;
        }
        else
        {
            if (m_savedState != null)
                wrapper.state = m_savedState;
            m_savedState = null;
        }

        updateSwitcherButton();
    }

    private function setDataImpl()
    {
        m_data_arguments = arguments;
        validateNow();
        //invalidate(10);
    }

    private function draw()
    {
        setDataInternal.apply(this, m_data_arguments);
    }

    var prevNamesStr:String = null;
    var prevVehiclesStr:String = null;
    private function setDataInternal(data, sel, postmortemIndex, isColorBlind, knownPlayersCount, dead_players_count, fragsStrOrig, vehiclesStrOrig, namesStrOrig)
    {
        //Logger.add("PlayersPanel.setData(): " + wrapper.state);
        //Logger.addObject(data, 3);
        //Logger.addObject(wrapper.m_list, 3);
        //Logger.add(vehiclesStrOrig);
        //Logger.add(namesStr);
        try
        {
            m_data = data;

            if (data == null)
                return;

            //wrapper.m_list._visible = true; // _visible == false for "none" mode
            var values:Array = vehiclesStrOrig.split("<br/>");
            var len = data.length;
            var namesArr:Array = [];
            var vehiclesArr:Array = [];
            var fragsArr:Array = [];
            for (var i = 0; i < len; ++i)
            {
                var item = data[i];
                var value = values[i];

                fixBattleState(item);

                //Logger.addObject(item);
                Macros.RegisterPlayerData(item.userName, item, wrapper.type == "left" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);

                var value_splitted:Array = value.split(item.vehicle);
                namesArr.push(value_splitted.join(getTextValue(Defines.FIELDTYPE_NICK, item, item.userName)));
                vehiclesArr.push(value_splitted.join(getTextValue(Defines.FIELDTYPE_VEHICLE, item, item.vehicle)));
                fragsArr.push(value_splitted.join(getTextValue(Defines.FIELDTYPE_FRAGS, item, item.frags)));
            }

            var namesStr:String = namesArr.join("\n");
            var vehiclesStr:String = vehiclesArr.join("\n");
            var fragsStr:String = fragsArr.join("\n");

            //Logger.add(vehiclesStr);

            var deadCountPrev:Number = wrapper.saved_params[wrapper.m_type].dPC;

            var needAdjustSize:Boolean = false;
            if (prevNamesStr != namesStr)
            {
                needAdjustSize = true;
                prevNamesStr = namesStr;
                wrapper.m_names.htmlText = namesStr;
                AdjustLeading(wrapper.m_names);
            }

            base.setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount, dead_players_count, fragsStr, vehiclesStr, wrapper.m_names.htmlText);
            base.saveData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount, dead_players_count, fragsStrOrig, vehiclesStrOrig, namesStrOrig);

            // new player added in the FoW mode
            if (m_knownPlayersCount != data.length)
                m_knownPlayersCount = data.length;

            if (prevVehiclesStr != vehiclesStr)
            {
                needAdjustSize = true;
                prevVehiclesStr = vehiclesStr;
                AdjustLeading(wrapper.m_vehicles);
            }

            if (needAdjustSize)
                XVMAdjustPanelSize();

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
        catch (ex:Error)
        {
            Logger.add(ex.toString());
        }
    }

    private function fixBattleState(data)
    {
        // fix battlestate
        var obj = BattleState.getUserData(data.userName);
        obj.frags = data.frags || NaN;
        //Logger.addObject(data);
        obj.ready = (data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVATAR_READY) != 0 && !Boolean(data.isOffline);
        obj.dead = (data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_ALIVE) == 0;
        if (obj.dead == true && (!isNaN(obj.curHealth) && obj.curHealth > 0))
            obj.curHealth = 0;
        obj.blowedUp = obj.dead && (!isNaN(obj.curHealth) && obj.curHealth < 0);
        obj.teamKiller = data.teamKiller == true;
        obj.entityName = wrapper.type != "left" ? "enemy" : data.squad > 10 ? "squadman" : obj.teamKiller ? "teamKiller" : "ally";
        obj.selected = data.isPostmortemView;
        if (obj.position == null)
            obj.position = data.position;

        if (data.himself)
            BattleState.setSelfUserName(data.userName);
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

    private function updateImpl()
    {
        //Logger.add("up: " + wrapper.state);
        if (m_initialized && m_savedState == null && Config.config.playersPanel[wrapper.state].enabled == false)
        {
            switch (wrapper.state)
            {
                case net.wargaming.ingame.PlayersPanel.STATES.none.name:
                    wrapper.state = net.wargaming.ingame.PlayersPanel.STATES.short.name;
                    break;
                case net.wargaming.ingame.PlayersPanel.STATES.short.name:
                    wrapper.state = net.wargaming.ingame.PlayersPanel.STATES.medium.name;
                    break;
                case net.wargaming.ingame.PlayersPanel.STATES.medium.name:
                    wrapper.state = net.wargaming.ingame.PlayersPanel.STATES.medium2.name;
                    break;
                case net.wargaming.ingame.PlayersPanel.STATES.medium2.name:
                    wrapper.state = net.wargaming.ingame.PlayersPanel.STATES.large.name;
                    break;
                case net.wargaming.ingame.PlayersPanel.STATES.large.name:
                    wrapper.state = net.wargaming.ingame.PlayersPanel.STATES.none.name;
                    break;
            }
            updateSwitcherButton();
            return;
        }

        base.update();
    }

    private function updateAlphasImpl()
    {
        wrapper.players_bg._alpha = Config.config.playersPanel.alpha;
        wrapper.m_list._alpha = 100;
    }

    // PRIVATE

    private function updateSwitcherButton()
    {
        var btn:Object;
        switch (wrapper.state)
        {
            case net.wargaming.ingame.PlayersPanel.STATES.none.name:
                btn = _root.switcher_mc.noneBtn;
                break;
            case net.wargaming.ingame.PlayersPanel.STATES.short.name:
                btn = _root.switcher_mc.shortBtn;
                break;
            case net.wargaming.ingame.PlayersPanel.STATES.medium.name:
                btn = _root.switcher_mc.mediumBtn;
                break;
            case net.wargaming.ingame.PlayersPanel.STATES.medium2.name:
                btn = _root.switcher_mc.mediumBtn2;
                break;
            case net.wargaming.ingame.PlayersPanel.STATES.large.name:
                btn = _root.switcher_mc.largeBtn;
                break;
        }
        //currentType = value;
        btn.selected = true;
    }

    // update without hide menu
    private function updateWithoutHideMenu()
    {
        if (wrapper.m_list instanceof ScrollingList)
        {
            var p = wrapper.saved_params[wrapper.m_type];
            wrapper.setData(p.data, p.sel, p.pIdx, p.isCB, p.kPC, p.dPC, p.fragsStr, p.vehiclesStr, p.namesStr);
        } // end if
    }

    private function getTextValue(fieldType, data, text)
    {
        //Logger.add("getTextValue()");
        var format:String = null;
        var cfg:Object = Config.config.playersPanel[wrapper.state];
        var isLeftPanel:Boolean = wrapper.type == "left";
        if (fieldType == Defines.FIELDTYPE_FRAGS)
        {
            format = isLeftPanel ? cfg.fragsFormatLeft : cfg.fragsFormatRight;
        }
        else
        {
            switch (wrapper.state)
            {
                case "medium":
                    if (fieldType == Defines.FIELDTYPE_NICK)
                        format = isLeftPanel ? cfg.formatLeft : cfg.formatRight;
                    break;
                case "medium2":
                    if (fieldType == Defines.FIELDTYPE_VEHICLE)
                        format = isLeftPanel ? cfg.formatLeft : cfg.formatRight;
                    break;
                case "large":
                    if (fieldType == Defines.FIELDTYPE_NICK)
                        format = isLeftPanel ? cfg.nickFormatLeft : cfg.nickFormatRight;
                    else if (fieldType == Defines.FIELDTYPE_VEHICLE)
                        format = isLeftPanel ? cfg.vehicleFormatLeft : cfg.vehicleFormatRight;
                    break;
            }
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

        var namesWidthDefault:Number = 46;
        var namesWidth:Number = namesWidthDefault;
        var vehiclesWidthDefault:Number = 65;
        var vehiclesWidth:Number = vehiclesWidthDefault;
        var widthDelta:Number = 0;
        var squadSize:Number = 0;

        var cfg:Object = Config.config.playersPanel;
        var w:Number = Macros.FormatGlobalNumberValue(cfg[wrapper.state].width);
        var value:Number;

        switch (wrapper.state)
        {
            case "short":
                widthDelta = -w;
                break;
            case "medium":
                namesWidth = Math.max(XVMGetMaximumFieldWidth(wrapper.m_names), w);
                widthDelta = namesWidthDefault - namesWidth;
                break;
            case "medium2":
                vehiclesWidth = w;
                widthDelta = vehiclesWidthDefault - vehiclesWidth;
                break;
            case "large":
                namesWidthDefault = 296;
                namesWidth = Math.max(XVMGetMaximumFieldWidth(wrapper.m_names), w);
                vehiclesWidth = XVMGetMaximumFieldWidth(wrapper.m_vehicles);
                //Logger.add("w: " + vehiclesWidth + " " + wrapper.m_vehicles.htmlText);
                squadSize = cfg.removeSquadIcon ? 0 : net.wargaming.ingame.PlayersPanel.SQUAD_SIZE;
                widthDelta = namesWidthDefault - namesWidth + vehiclesWidthDefault - vehiclesWidth - squadSize + net.wargaming.ingame.PlayersPanel.SQUAD_SIZE;
                break;
            default:
                value = (wrapper.type == "left")
                    ? net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x
                    : wrapper.players_bg._width - net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x;
                if (wrapper.m_list._x != value || wrapper.players_bg._x != value)
                {
                    wrapper.m_list._x = value;
                    wrapper.players_bg._x = value;
                    GlobalEventDispatcher.dispatchEvent({
                        type: wrapper.type == "left" ? Defines.E_LEFT_PANEL_SIZE_ADJUSTED : Defines.E_RIGHT_PANEL_SIZE_ADJUSTED,
                        state: wrapper.state
                    });
                }
                return;
        }

        var changed:Boolean = false;

        if (wrapper.m_names._visible && wrapper.m_names._width != namesWidth)
        {
            changed = true;
            wrapper.m_names._width = namesWidth;
        }

        if (wrapper.m_vehicles._visible && wrapper.m_vehicles._width != vehiclesWidth)
        {
            changed = true;
            wrapper.m_vehicles._width = vehiclesWidth;
        }

        if (wrapper.type == "left")
        {
            value = squadSize;
            if (wrapper.m_names._x != value)
            {
                changed = true;
                wrapper.m_names._x = value;
            }

            value = wrapper.m_names._x + wrapper.m_names._width;
            if (wrapper.m_frags._x != value)
            {
                changed = true;
                wrapper.m_frags._x = value;
            }

            value = wrapper.m_frags._x + wrapper.m_frags._width;
            if (wrapper.m_vehicles._x != value)
            {
                changed = true;
                wrapper.m_vehicles._x = wrapper.m_frags._x + wrapper.m_frags._width;
            }

            value = wrapper.players_bg._x = net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x - widthDelta;
            if (wrapper.m_list._x != value)
            {
                changed = true;
                wrapper.m_list._x = value;
            }

            if (squadSize > 0 && changed)
                wrapper.m_list.updateSquadIconPosition(-wrapper.m_list._x);
        }
        else
        {
            value = wrapper.players_bg._width - wrapper.m_names._width - squadSize;
            if (wrapper.m_names._x != value)
            {
                changed = true;
                wrapper.m_names._x = value;
            }

            value = wrapper.m_names._x - wrapper.m_frags._width;
            if (wrapper.m_frags._x != value)
            {
                changed = true;
                wrapper.m_frags._x = value;
            }

            value = wrapper.m_frags._x - wrapper.m_vehicles._width;
            if (wrapper.m_vehicles._x != value)
            {
                changed = true;
                wrapper.m_vehicles._x = value;
            }

            value = wrapper.players_bg._x = wrapper.players_bg._width - net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x + widthDelta;
            if (wrapper.m_list._x != value)
            {
                changed = true;
                wrapper.m_list._x = value;
            }

            if (squadSize > 0 && changed)
                wrapper.m_list.updateSquadIconPosition(-440 + wrapper.m_frags._width + wrapper.m_names._width + wrapper.m_vehicles._width + squadSize);
        }

        if (changed)
        {
            GlobalEventDispatcher.dispatchEvent({
                type: wrapper.type == "left" ? Defines.E_LEFT_PANEL_SIZE_ADJUSTED : Defines.E_RIGHT_PANEL_SIZE_ADJUSTED,
                state: wrapper.state
            });
        }
    }

    private function XVMGetMaximumFieldWidth(field:TextField)
    {
        var max_width = 0;
        var len:Number = field.numLines;
        for (var i = 0; i < len; ++i)
        {
            var w:Number = field.getLineMetrics(i).width;
            if (w > max_width)
                max_width = w;
        }
        return Math.round(max_width) + 4; // 4 is the size of gutters
    }

    // set leading and centering on cell, because of align=top
    private function AdjustLeading(field:TextField)
    {
        if (!field._visible)
            return;

        var leading:Number = Math.round(33.95 - (field.textHeight + 9) / field.numLines);
        if (leading != 9)
        {
            field.htmlText = field.htmlText.split('LEADING="9"').join('LEADING="' + leading + '"');
            field._y = centeredTextY + leading / 2.0;
        }
        //Logger.add(field.htmlText);
    }
}
