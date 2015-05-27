/**
/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 * @author ilitvinov87
 */
import com.xvm.*;
import com.xvm.events.*;

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

    function updatePositions()
    {
        // stub
    }

    function updateWidthOfLongestName()
    {
        // stub
    }

    function updateSquadIcons()
    {
        // stub
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    public static var DEFAULT_SQUAD_SIZE:Number;

    private var DEFAULT_WIDTH:Number = 33;
    private var DEFAULT_NAMES_WIDTH_LARGE:Number = 263;
    private var DEFAULT_NAMES_WIDTH_MEDIUM:Number = 79;
    private var DEFAULT_VEHICLES_WIDTH:Number = 98;

    private var m_data_arguments:Array;
    private var m_data:Object;
    private var m_dead_noticed:Object = { };

    private var m_knownPlayersCount:Number = 0; // for Fog of War mode.
    private var m_postmortemIndex:Number = 0;

    private var m_lastPosition:Number = 0;

    private var cfg:Object;

    public function PlayersPanelCtor()
    {
        Utils.TraceXvmModule("PlayersPanel");

        if (!DEFAULT_SQUAD_SIZE)
            DEFAULT_SQUAD_SIZE = net.wargaming.ingame.PlayersPanel.SQUAD_SIZE + net.wargaming.ingame.PlayersPanel.SQUAD_ICO_MARGIN * 2;

        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, this, onConfigLoaded);
        GlobalEventDispatcher.addEventListener(Defines.E_UPDATE_STAGE, this, invalidate);
        GlobalEventDispatcher.addEventListener(Defines.E_STAT_LOADED, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.E_BATTLE_STATE_CHANGED, this, onBattleStateChanged);
    }

    // PRIVATE

    // Centered _y value of text field
    private var centeredTextY:Number;

    private var m_altMode:String = null;
    private var m_savedState:String = null;
    private var m_initialized = false;

    private function onConfigLoaded()
    {
        cfg = Config.config.playersPanel;
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

        // for incomplete team - cannot set to "center"
        wrapper.m_names.verticalAlign = "top";
        wrapper.m_vehicles.verticalAlign = "top";
        wrapper.m_frags.verticalAlign = "top";
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

    var prevState:String = null;
    var prevNamesStr:String = null;
    var prevVehiclesStr:String = null;
    var prevFragsStr:String = null;
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

            Cmd.profMethodStart("PlayersPanel.setData(): " + wrapper.type);

            //wrapper.m_list._visible = true; // _visible == false for "none" mode
            Cmd.profMethodStart("PlayersPanel.setData(): #0 - split");
            var values:Array = vehiclesStrOrig.split("<br/>");
            Cmd.profMethodEnd("PlayersPanel.setData(): #0 - split");
            Cmd.profMethodStart("PlayersPanel.setData(): #1 - prepare");
            var len = data.length;
            var namesArr:Array = [];
            var vehiclesArr:Array = [];
            var fragsArr:Array = [];
            for (var i = 0; i < len; ++i)
            {
                Cmd.profMethodStart("PlayersPanel.setData(): #1.0 - register macros");
                var item = data[i];
                var value = values[i];

                fixBattleState(item);

                //Logger.addObject(item);
                if (item.himself)
                    Macros.UpdateMyFrags(item.frags);
                Macros.RegisterPlayerData(item.userName, item, wrapper.type == "left" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);
                Cmd.profMethodEnd("PlayersPanel.setData(): #1.0 - register macros");

                var value_splitted:Array = value.split(item.vehicle);
                var cfg_state:Object = cfg[wrapper.state];
//                Cmd.profMethodStart("PlayersPanel.setData(): #1.1 - format names");
                namesArr.push(value_splitted.join(getTextValue(cfg_state, Defines.FIELDTYPE_NICK, item, item.userName)));
//                Cmd.profMethodEnd("PlayersPanel.setData(): #1.1 - format names");
//                Cmd.profMethodStart("PlayersPanel.setData(): #1.2 - format vehicle");
                vehiclesArr.push(value_splitted.join(getTextValue(cfg_state, Defines.FIELDTYPE_VEHICLE, item, item.vehicle)));
//                Cmd.profMethodEnd("PlayersPanel.setData(): #1.2 - format vehicle");
//                Cmd.profMethodStart("PlayersPanel.setData(): #1.3 - format frags");
                fragsArr.push(value_splitted.join(getTextValue(cfg_state, Defines.FIELDTYPE_FRAGS, item, item.frags)));
//                Cmd.profMethodEnd("PlayersPanel.setData(): #1.3 - format frags");
            }
            Cmd.profMethodEnd("PlayersPanel.setData(): #1 - prepare");

            Cmd.profMethodStart("PlayersPanel.setData(): #2 - join arrays and set htmlText");
            var namesStr:String = namesArr.join("\n");
            var vehiclesStr:String = vehiclesArr.join("\n");
            var fragsStr:String = fragsArr.join("\n");

            //Logger.add(vehiclesStr);

            var deadCountPrev:Number = wrapper.saved_params[wrapper.m_type].dPC;

            var needAdjustSize:Boolean = false;
            //Logger.addObject(wrapper.m_names.text);
            var text:String = wrapper.m_names.text;
            if (prevNamesStr != namesStr || text == "" || text == "\r")
            {
                needAdjustSize = true;
                prevNamesStr = namesStr;
                wrapper.m_names.htmlText = namesStr;
                AdjustLeading(wrapper.m_names);
            }

            text = wrapper.m_vehicles.text;
            if (prevVehiclesStr != vehiclesStr || text == "" || text == "\r")
            {
                needAdjustSize = true;
                prevVehiclesStr = vehiclesStr;
                wrapper.m_vehicles.htmlText = vehiclesStr;
                AdjustLeading(wrapper.m_vehicles);
            }

            text = wrapper.m_frags.text;
            if (prevFragsStr != fragsStr || text == "" || text == "\r")
            {
                prevFragsStr = fragsStr;
                wrapper.m_frags.htmlText = fragsStr;
                //AdjustLeading(wrapper.m_frags);
            }
            Cmd.profMethodEnd("PlayersPanel.setData(): #2 - join arrays and set htmlText");

            Cmd.profMethodStart("PlayersPanel.setData(): #3 - base.setData()");
            base.setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount, dead_players_count, fragsStrOrig, vehiclesStrOrig, namesStrOrig);
            Cmd.profMethodEnd("PlayersPanel.setData(): #3 - base.setData()");

            Cmd.profMethodStart("PlayersPanel.setData(): #4");
            // new player added in the FoW mode
            if (m_knownPlayersCount != data.length)
                m_knownPlayersCount = data.length;

            if (prevState != wrapper.state)
            {
                needAdjustSize = true;
                prevState = wrapper.state;
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
            Cmd.profMethodEnd("PlayersPanel.setData(): #4");
        }
        catch (ex:Error)
        {
            Logger.add(ex.toString());
        }

        Cmd.profMethodEnd("PlayersPanel.setData(): " + wrapper.type);
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
            obj.position = ++m_lastPosition;

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
        if (wrapper.m_names.condenseWhite)
            wrapper.m_names.condenseWhite = false;
        if (wrapper.m_vehicles.condenseWhite)
            wrapper.m_vehicles.condenseWhite = false;
        if (wrapper.m_frags.wordWrap)
            wrapper.m_frags.wordWrap = false;
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

    private function onBattleStateChanged(e:EBattleStateChanged)
    {
        //updateWithoutHideMenu
        invalidate(300);
    }

    // update without hide menu
    /*
    private function updateWithoutHideMenu()
    {
        if (wrapper.m_list instanceof ScrollingList)
        {
            var p = wrapper.saved_params[wrapper.m_type];
            wrapper.setData(p.data, p.sel, p.pIdx, p.isCB, p.kPC, p.dPC, p.fragsStr, p.vehiclesStr, p.namesStr);
        } // end if
    }
    */

    private function getTextValue(cfg_state, fieldType, data, text)
    {
        //Logger.add("getTextValue()");
        var format:String = null;
        var isLeftPanel:Boolean = wrapper.type == "left";
        if (fieldType == Defines.FIELDTYPE_FRAGS)
        {
            format = isLeftPanel ? cfg_state.fragsFormatLeft : cfg_state.fragsFormatRight;
        }
        else
        {
            switch (wrapper.state)
            {
                case "medium":
                    if (fieldType == Defines.FIELDTYPE_NICK)
                        format = isLeftPanel ? cfg_state.formatLeft : cfg_state.formatRight;
                    break;
                case "medium2":
                    if (fieldType == Defines.FIELDTYPE_VEHICLE)
                        format = isLeftPanel ? cfg_state.formatLeft : cfg_state.formatRight;
                    break;
                case "large":
                    if (fieldType == Defines.FIELDTYPE_NICK)
                        format = isLeftPanel ? cfg_state.nickFormatLeft : cfg_state.nickFormatRight;
                    else if (fieldType == Defines.FIELDTYPE_VEHICLE)
                        format = isLeftPanel ? cfg_state.vehicleFormatLeft : cfg_state.vehicleFormatRight;
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

        //wrapper.m_frags.border = true;
        //wrapper.m_frags.borderColor = 0xFF0000;
        //wrapper.m_names.border = true;
        //wrapper.m_names.borderColor = 0x00FF00;
        //wrapper.m_vehicles.border = true;
        //wrapper.m_vehicles.borderColor = 0x0000FF;

        var namesWidth:Number = DEFAULT_NAMES_WIDTH_MEDIUM;
        var vehiclesWidth:Number = DEFAULT_VEHICLES_WIDTH;
        var widthDelta:Number = 0;

        var isLeftPanel:Boolean = wrapper.type == "left";
        var w:Number = Macros.FormatGlobalNumberValue(cfg[wrapper.state].width);
        var x:Number;

        switch (wrapper.state)
        {
            case "short":
                widthDelta = w;
                break;
            case "medium":
                namesWidth = Math.max(XVMGetMaximumFieldWidth(wrapper.m_names), w);
                widthDelta = DEFAULT_NAMES_WIDTH_MEDIUM - namesWidth - DEFAULT_WIDTH;
                break;
            case "medium2":
                vehiclesWidth = w;
                widthDelta = DEFAULT_VEHICLES_WIDTH - vehiclesWidth - DEFAULT_WIDTH;
                break;
            case "large":
                namesWidth = Math.max(XVMGetMaximumFieldWidth(wrapper.m_names), w);
                vehiclesWidth = XVMGetMaximumFieldWidth(wrapper.m_vehicles);
                //Logger.add("w: " + vehiclesWidth + " " + wrapper.m_vehicles.htmlText);
                widthDelta = DEFAULT_NAMES_WIDTH_LARGE - namesWidth + DEFAULT_VEHICLES_WIDTH - vehiclesWidth;
                break;
            default:
                x = isLeftPanel
                    ? net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x
                    : wrapper.players_bg._width - net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x;
                if (wrapper.m_list._x != x || wrapper.players_bg._x != x)
                {
                    wrapper.players_bg._x = x;
                    wrapper.m_list._x = x;
                    var sqx:Number = isLeftPanel
                        ? -x + net.wargaming.ingame.PlayersPanel.SQUAD_ICO_MARGIN
                        : wrapper.players_bg._width - x - DEFAULT_SQUAD_SIZE + net.wargaming.ingame.PlayersPanel.SQUAD_ICO_MARGIN;
                    wrapper.m_list.updateSquadIconPosition();
                    GlobalEventDispatcher.dispatchEvent({
                        type: isLeftPanel ? Defines.E_LEFT_PANEL_SIZE_ADJUSTED : Defines.E_RIGHT_PANEL_SIZE_ADJUSTED,
                        state: wrapper.state
                    });
                }
                return;
        }

        var squadSize:Number = cfg.removeSquadIcon ? 0 : DEFAULT_SQUAD_SIZE;
        widthDelta += DEFAULT_SQUAD_SIZE - squadSize;

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

        if (isLeftPanel)
        {
            x = net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x - widthDelta;
            if (wrapper.players_bg._x != x)
            {
                changed = true;
                wrapper.players_bg._x = x;
                wrapper.m_list._x = x;
                wrapper.m_list.updateSquadIconPosition(-x + net.wargaming.ingame.PlayersPanel.SQUAD_ICO_MARGIN);
            }

            x = squadSize;

            if (wrapper.m_names._visible)
            {
                if (wrapper.m_names._x != x)
                {
                    changed = true;
                    wrapper.m_names._x = x;
                }
                x += wrapper.m_names._width;
            }

            if (wrapper.m_frags._visible)
            {
                if (wrapper.m_frags._x != x)
                {
                    changed = true;
                    wrapper.m_frags._x = x;
                }
                x += wrapper.m_frags._width;
            }

            if (wrapper.m_vehicles._visible)
            {
                if (wrapper.m_vehicles._x != x)
                {
                    changed = true;
                    wrapper.m_vehicles._x = x;
                }
            }
        }
        else
        {
            x = wrapper.players_bg._width - net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x + widthDelta;
            if (wrapper.players_bg._x != x)
            {
                changed = true;
                wrapper.players_bg._x = x;
                wrapper.m_list._x = x;
                wrapper.m_list.updateSquadIconPosition(wrapper.players_bg._width - x - squadSize + net.wargaming.ingame.PlayersPanel.SQUAD_ICO_MARGIN);
            }

            x = wrapper.players_bg._width - squadSize;

            if (wrapper.m_names._visible)
            {
                x -= wrapper.m_names._width;
                if (wrapper.m_names._x != x)
                {
                    changed = true;
                    wrapper.m_names._x = x;
                }
            }

            if (wrapper.m_frags._visible)
            {
                x -= wrapper.m_frags._width;
                if (wrapper.m_frags._x != x)
                {
                    changed = true;
                    wrapper.m_frags._x = x;
                }
            }

            if (wrapper.m_vehicles._visible)
            {
                x -= wrapper.m_vehicles._width;
                if (wrapper.m_vehicles._x != x)
                {
                    changed = true;
                    wrapper.m_vehicles._x = x;
                }
            }
        }

        if (changed)
        {
            GlobalEventDispatcher.dispatchEvent({
                type: isLeftPanel ? Defines.E_LEFT_PANEL_SIZE_ADJUSTED : Defines.E_RIGHT_PANEL_SIZE_ADJUSTED,
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
            field.htmlText = field.htmlText.split('LEADING="9"').join('LEADING="' + leading + '"');

        field._y = centeredTextY + leading / 2.0;

        //Logger.add(field.htmlText);
    }
}
