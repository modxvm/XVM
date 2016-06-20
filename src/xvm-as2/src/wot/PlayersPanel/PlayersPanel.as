/**
/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 * @author ilitvinov87
 */
import com.xvm.*;
import com.xvm.DataTypes.*;
import com.xvm.events.*;

class wot.PlayersPanel.PlayersPanel extends XvmComponent
{
// AS3:DONE     /////////////////////////////////////////////////////////////////
// AS3:DONE     // wrapped methods
// AS3:DONE
// AS3:DONE     private var wrapper:net.wargaming.ingame.PlayersPanel;
// AS3:DONE     private var base:net.wargaming.ingame.PlayersPanel;
// AS3:DONE
// AS3:DONE     public function PlayersPanel(wrapper:net.wargaming.ingame.PlayersPanel, base:net.wargaming.ingame.PlayersPanel)
// AS3:DONE     {
// AS3:DONE         this.wrapper = wrapper;
// AS3:DONE         this.base = base;
// AS3:DONE         wrapper.xvm_worker = this;
// AS3:DONE         PlayersPanelCtor();
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function setData()
// AS3:DONE     {
// AS3:DONE         if (!Utils.isArenaGuiTypeWithPlayerPanels())
// AS3:DONE             return base.setData.apply(base, arguments);
// AS3:DONE         return this.setDataImpl.apply(this, arguments);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function onRecreateDevice()
// AS3:DONE     {
// AS3:DONE         if (!Utils.isArenaGuiTypeWithPlayerPanels())
// AS3:DONE             return base.onRecreateDevice.apply(base, arguments);
// AS3:DONE         return this.onRecreateDeviceImpl.apply(this, arguments);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function update()
// AS3:DONE     {
// AS3:DONE         if (!Utils.isArenaGuiTypeWithPlayerPanels())
// AS3:DONE             return base.update.apply(base, arguments);
// AS3:DONE         return this.updateImpl.apply(this, arguments);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function updateAlphas()
// AS3:DONE     {
// AS3:DONE         if (!Utils.isArenaGuiTypeWithPlayerPanels())
// AS3:DONE             return base.updateAlphas.apply(base, arguments);
// AS3:DONE         return this.updateAlphasImpl.apply(this, arguments);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function updatePositions()
// AS3:DONE     {
// AS3:DONE         if (!Utils.isArenaGuiTypeWithPlayerPanels())
// AS3:DONE             return base.updatePositions.apply(base, arguments);
// AS3:DONE         // stub
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function updateSquadIcons()
// AS3:DONE     {
// AS3:DONE         if (!Utils.isArenaGuiTypeWithPlayerPanels())
// AS3:DONE             return base.updateSquadIcons.apply(base, arguments);
// AS3:DONE         // stub
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function setIsShowExtraModeActive()
// AS3:DONE     {
// AS3:DONE         if (!Utils.isArenaGuiTypeWithPlayerPanels())
// AS3:DONE             return base.setIsShowExtraModeActive.apply(base, arguments);
// AS3:DONE         return this.setIsShowExtraModeActiveImpl.apply(this, arguments);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     // wrapped methods
// AS3:DONE     /////////////////////////////////////////////////////////////////

    public static var DEFAULT_SQUAD_SIZE:Number;

    private var DEFAULT_WIDTH:Number = 33;
    private var DEFAULT_NAMES_WIDTH_LARGE:Number = 263;
    private var DEFAULT_NAMES_WIDTH_MEDIUM:Number = 79;
    private var DEFAULT_VEHICLES_WIDTH:Number = 98;

    private var m_data_arguments:Array;
    private var m_data:Object;

    private var m_knownPlayersCount:Number = 0; // for Fog of War mode.
    private var m_postmortemIndex:Number = 0;

    private var m_lastPosition:Number = 0;

// AS3:DONE     private var cfg:Object;
// AS3:DONE
// AS3:DONE     public function PlayersPanelCtor()
// AS3:DONE     {
// AS3:DONE         Utils.TraceXvmModule("PlayersPanel");
// AS3:DONE
// AS3:DONE         GlobalEventDispatcher.addEventListener(Events.E_CONFIG_LOADED, this, onConfigLoaded);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     // PRIVATE
// AS3:DONE
// AS3:DONE     // Centered _y value of text field
// AS3:DONE     private var centeredTextY:Number;
// AS3:DONE
// AS3:DONE     private var _initialized:Boolean = false;
// AS3:DONE
// AS3:DONE     private var m_altMode:String = null;
// AS3:DONE     private var m_savedState:String = null;
// AS3:DONE     private var m_initialized = false;

    private function init()
    {
// AS3:DONE         if (_initialized)
// AS3:DONE             return;
// AS3:DONE
// AS3:DONE         _initialized = true;
// AS3:DONE
// AS3:DONE         if (!Utils.isArenaGuiTypeWithPlayerPanels())
// AS3:DONE             return;

        if (!DEFAULT_SQUAD_SIZE)
            DEFAULT_SQUAD_SIZE = net.wargaming.ingame.PlayersPanel.SQUAD_SIZE + net.wargaming.ingame.PlayersPanel.SQUAD_ICO_MARGIN * 2;

        GlobalEventDispatcher.addEventListener(Events.E_UPDATE_STAGE, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.E_STAT_LOADED, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.XMQP_HOLA, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.XMQP_FIRE, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.XMQP_VEHICLE_TIMER, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.XMQP_SPOTTED, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.E_BATTLE_STATE_CHANGED, this, onBattleStateChanged);
    }

// AS3:DONE     private function onConfigLoaded()
// AS3:DONE     {
// AS3:DONE         init();
// AS3:DONE
// AS3:DONE         cfg = Config.config.playersPanel;
// AS3:DONE         var startMode:String = String(cfg.startMode).toLowerCase();
// AS3:DONE         if (net.wargaming.ingame.PlayersPanel.STATES[startMode] == null)
// AS3:DONE             startMode = net.wargaming.ingame.PlayersPanel.STATES.large.name;
// AS3:DONE         cfg[startMode].enabled = true;
// AS3:DONE         setStartMode(startMode, wrapper);
// AS3:DONE
// AS3:DONE         m_savedState = null;
// AS3:DONE         m_altMode = String(cfg.altMode).toLowerCase();
// AS3:DONE         if (net.wargaming.ingame.PlayersPanel.STATES[m_altMode] == null)
// AS3:DONE             m_altMode = null;
// AS3:DONE         if (m_altMode != null)
// AS3:DONE             GlobalEventDispatcher.addEventListener(Events.E_PP_ALT_MODE, this, setAltMode);
// AS3:DONE
// AS3:DONE         _root.switcher_mc.noneBtn.enabled = cfg[net.wargaming.ingame.PlayersPanel.STATES.none.name].enabled;
// AS3:DONE         _root.switcher_mc.shortBtn.enabled = cfg[net.wargaming.ingame.PlayersPanel.STATES.short.name].enabled;
// AS3:DONE         _root.switcher_mc.mediumBtn.enabled = cfg[net.wargaming.ingame.PlayersPanel.STATES.medium.name].enabled;
// AS3:DONE         _root.switcher_mc.mediumBtn2.enabled = cfg[net.wargaming.ingame.PlayersPanel.STATES.medium2.name].enabled;
// AS3:DONE         _root.switcher_mc.largeBtn.enabled = cfg[net.wargaming.ingame.PlayersPanel.STATES.large.name].enabled;
// AS3:DONE         _root.switcher_mc.noneBtn._alpha = _root.switcher_mc.noneBtn.enabled ? 100 : 50;
// AS3:DONE         _root.switcher_mc.shortBtn._alpha = _root.switcher_mc.shortBtn.enabled ? 100 : 50;
// AS3:DONE         _root.switcher_mc.mediumBtn._alpha = _root.switcher_mc.mediumBtn.enabled ? 100 : 50;
// AS3:DONE         _root.switcher_mc.mediumBtn2._alpha = _root.switcher_mc.mediumBtn2.enabled ? 100 : 50;
// AS3:DONE         _root.switcher_mc.largeBtn._alpha = _root.switcher_mc.largeBtn.enabled ? 100 : 50;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function setStartMode(mode:String, wrapper:net.wargaming.ingame.PlayersPanel)
// AS3:DONE     {
// AS3:DONE         if (wrapper.state == "none")
// AS3:DONE         {
// AS3:DONE             var $this = this;
// AS3:DONE             _global.setTimeout(function() { $this.setStartMode(mode, wrapper); }, 1);
// AS3:DONE             return;
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         m_initialized = true;
// AS3:DONE
// AS3:DONE         wrapper.state = mode;
// AS3:DONE         updateSwitcherButton();
// AS3:DONE
// AS3:DONE         // initialize
// AS3:DONE
// AS3:DONE         centeredTextY = wrapper.m_names._y - 5;
// AS3:DONE
// AS3:DONE         // for incomplete team - cannot set to "center"
// AS3:DONE         wrapper.m_names.verticalAlign = "top";
// AS3:DONE         wrapper.m_vehicles.verticalAlign = "top";
// AS3:DONE         wrapper.m_frags.verticalAlign = "top";
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private var isAltMode:Boolean = false;
// AS3:DONE     private function setAltMode(e:Object)
// AS3:DONE     {
// AS3:DONE         //Logger.add("setAltMode: " + e.isDown + " " + m_altMode + " " + wrapper.state);
// AS3:DONE
// AS3:DONE         if (m_altMode == null)
// AS3:DONE             return;
// AS3:DONE
// AS3:DONE         if (Config.config.hotkeys.playersPanelAltMode.onHold)
// AS3:DONE             isAltMode = e.isDown;
// AS3:DONE         else if (e.isDown)
// AS3:DONE             isAltMode = !isAltMode;
// AS3:DONE         else
// AS3:DONE             return;
// AS3:DONE
// AS3:DONE         if (isAltMode)
// AS3:DONE         {
// AS3:DONE             if (m_savedState == null)
// AS3:DONE                 m_savedState = wrapper.state;
// AS3:DONE             wrapper.state = m_altMode;
// AS3:DONE         }
// AS3:DONE         else
// AS3:DONE         {
// AS3:DONE             if (m_savedState != null)
// AS3:DONE                 wrapper.state = m_savedState;
// AS3:DONE             m_savedState = null;
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         updateSwitcherButton();
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     private function setDataImpl()
// AS3:DONE     {
// AS3:DONE         m_data_arguments = arguments;
// AS3:DONE         validateNow();
// AS3:DONE         //invalidate(10);
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     private function draw()
// AS3:DONE     {
// AS3:DONE         setDataInternal.apply(this, m_data_arguments);
// AS3:DONE     }

    var prevState:String = null;
    var prevNamesStr:String = null;
    var prevVehiclesStr:String = null;
    var prevFragsStr:String = null;
    private function setDataInternal(data, sel, postmortemIndex, isColorBlind, knownPlayersCount, dead_players_count, fragsStrOrig, vehiclesStrOrig, namesStrOrig)
    {
        //Logger.add("PlayersPanel.setData(): " + wrapper.state + " " + wrapper.type);
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
            //Cmd.profMethodStart("PlayersPanel.setData(): #0 - split");
            var vehiclesValues:Array = vehiclesStrOrig.split("<br/>");
            //Cmd.profMethodEnd("PlayersPanel.setData(): #0 - split");
            //Cmd.profMethodStart("PlayersPanel.setData(): #1 - prepare");
            var len = data.length;
            var namesArr:Array = [];
            var vehiclesArr:Array = [];
            var fragsArr:Array = [];
            for (var i = 0; i < len; ++i)
            {
                //Cmd.profMethodStart("PlayersPanel.setData(): #1.0 - register macros");
                var item:Object = data[i];
                var uid:Number = item.uid;
                var frags:Number = item.frags;
                var vehicleState:Number = item.vehicleState;
                var userName:String = item.userName;

                // fix battlestate
                var obj:BattleStateData = BattleState.get(uid);
                obj.frags = frags || NaN;
                //Logger.addObject(item);
                obj.ready = (vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVATAR_READY) != 0 && !Boolean(item.isOffline);
                ///////////////////////////////////////////////////////////////////////////////////////////////
                // This comment for "obj.dead" is a temp fix for correct BattleState update from BattleMain.as
                // obj.dead = (vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_ALIVE) == 0;
                ///////////////////////////////////////////////////////////////////////////////////////////////
                if (obj.dead == true && (!isNaN(obj.curHealth) && obj.curHealth > 0))
                    obj.curHealth = 0;
                obj.blowedUp = obj.dead && (!isNaN(obj.curHealth) && obj.curHealth < 0);
                obj.teamKiller = item.teamKiller == true;
                obj.squad = item.squad;
                obj.entityName = wrapper.type != "left" ? "enemy" : obj.squad > 10 ? "squadman" : obj.teamKiller ? "teamKiller" : "ally";
                obj.selected = item.isPostmortemView;
                if (obj.position == null)
                    obj.position = ++m_lastPosition;

                //Logger.addObject(item);

                // register macros
                if (item.himself)
                {
                    BattleState.setSelfPlayerId(uid);
                    Macros.UpdateMyFrags(frags);
                }
                Macros.RegisterPlayerData(userName, item, wrapper.type == "left" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);
                //Cmd.profMethodEnd("PlayersPanel.setData(): #1.0 - register macros");

                // calculate values
                var color:String = vehiclesValues[i].split("'")[1];
                var cfg_state:Object = cfg[wrapper.state];
//                Cmd.profMethodStart("PlayersPanel.setData(): #1.1 - format names");
                namesArr.push("<font color='" + color + "'>" + getTextValue(cfg_state, Defines.FIELDTYPE_NICK, item, userName) + "</font>");
//                Cmd.profMethodEnd("PlayersPanel.setData(): #1.1 - format names");
//                Cmd.profMethodStart("PlayersPanel.setData(): #1.2 - format vehicle");
                vehiclesArr.push("<font color='" + color + "'>" + getTextValue(cfg_state, Defines.FIELDTYPE_VEHICLE, item, item.vehicle) + "</font>");
//                Cmd.profMethodEnd("PlayersPanel.setData(): #1.2 - format vehicle");
//                Cmd.profMethodStart("PlayersPanel.setData(): #1.3 - format frags");
                fragsArr.push("<font color='" + color + "'>" + getTextValue(cfg_state, Defines.FIELDTYPE_FRAGS, item, frags) + "</font>");
//                Cmd.profMethodEnd("PlayersPanel.setData(): #1.3 - format frags");
            }
            //Cmd.profMethodEnd("PlayersPanel.setData(): #1 - prepare");

            //Cmd.profMethodStart("PlayersPanel.setData(): #2 - join arrays and set htmlText");
            var namesStr:String = namesArr.join("\n");
            var vehiclesStr:String = vehiclesArr.join("\n");
            var fragsStr:String = fragsArr.join("\n");

            //Logger.add(vehiclesStr);

            var deadCountPrev:Number = wrapper.saved_params[wrapper.m_type].dPC;

            var needAdjustSize:Boolean = false;
            //Logger.addObject(wrapper.m_names.text);
            var text:String = wrapper.m_names.text;
            if (wrapper.m_names._visible && (prevNamesStr != namesStr || text == "" || text == "\r"))
            {
                needAdjustSize = true;
                prevNamesStr = namesStr;
                wrapper.m_names.htmlText = namesStr;
                AdjustLeading(wrapper.m_names);
            }

            text = wrapper.m_vehicles.text;
            if (wrapper.m_vehicles._visible && (prevVehiclesStr != vehiclesStr || text == "" || text == "\r"))
            {
                needAdjustSize = true;
                prevVehiclesStr = vehiclesStr;
                wrapper.m_vehicles.htmlText = vehiclesStr;
                AdjustLeading(wrapper.m_vehicles);
            }

            text = wrapper.m_frags.text;
            if (wrapper.m_frags._visible && (prevFragsStr != fragsStr || text == "" || text == "\r"))
            {
                prevFragsStr = fragsStr;
                wrapper.m_frags.htmlText = fragsStr;
                //AdjustLeading(wrapper.m_frags);
            }
            //Cmd.profMethodEnd("PlayersPanel.setData(): #2 - join arrays and set htmlText");

            Cmd.profMethodStart("PlayersPanel.setData(): #3 - base.setData()");
            base.setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount, dead_players_count, fragsStrOrig, vehiclesStrOrig, namesStrOrig);
            Cmd.profMethodEnd("PlayersPanel.setData(): #3 - base.setData()");

            //Cmd.profMethodStart("PlayersPanel.setData(): #4");
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

            //Cmd.profMethodEnd("PlayersPanel.setData(): #4");
        }
        catch (ex:Error)
        {
            Logger.add(ex.toString());
        }

        Cmd.profMethodEnd("PlayersPanel.setData(): " + wrapper.type);
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

// AS3:DONE     private function onRecreateDeviceImpl(width, height)
// AS3:DONE     {
// AS3:DONE         //Logger.add("PlayersPanel.onRecreateDevice()");
// AS3:DONE         base.onRecreateDevice(width, height);
// AS3:DONE 
// AS3:DONE         wrapper.update();
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     private function updateImpl()
// AS3:DONE     {
// AS3:DONE         //Logger.add("up: " + wrapper.state);
// AS3:DONE         if (m_savedState == null && Config.config.playersPanel[wrapper.state].enabled == false)
// AS3:DONE         {
// AS3:DONE             switch (wrapper.state)
// AS3:DONE             {
// AS3:DONE                 case net.wargaming.ingame.PlayersPanel.STATES.none.name:
// AS3:DONE                     wrapper.state = net.wargaming.ingame.PlayersPanel.STATES.short.name;
// AS3:DONE                     break;
// AS3:DONE                 case net.wargaming.ingame.PlayersPanel.STATES.short.name:
// AS3:DONE                     wrapper.state = net.wargaming.ingame.PlayersPanel.STATES.medium.name;
// AS3:DONE                     break;
// AS3:DONE                 case net.wargaming.ingame.PlayersPanel.STATES.medium.name:
// AS3:DONE                     wrapper.state = net.wargaming.ingame.PlayersPanel.STATES.medium2.name;
// AS3:DONE                     break;
// AS3:DONE                 case net.wargaming.ingame.PlayersPanel.STATES.medium2.name:
// AS3:DONE                     wrapper.state = net.wargaming.ingame.PlayersPanel.STATES.large.name;
// AS3:DONE                     break;
// AS3:DONE                 case net.wargaming.ingame.PlayersPanel.STATES.large.name:
// AS3:DONE                     wrapper.state = net.wargaming.ingame.PlayersPanel.STATES.none.name;
// AS3:DONE                     break;
// AS3:DONE             }
// AS3:DONE             updateSwitcherButton();
// AS3:DONE             return;
// AS3:DONE         }
// AS3:DONE 
// AS3:DONE         base.update();
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     private function updateAlphasImpl()
// AS3:DONE     {
// AS3:DONE         if (wrapper.m_names.condenseWhite)
// AS3:DONE             wrapper.m_names.condenseWhite = false;
// AS3:DONE         if (wrapper.m_vehicles.condenseWhite)
// AS3:DONE             wrapper.m_vehicles.condenseWhite = false;
// AS3:DONE         if (wrapper.m_frags.wordWrap)
// AS3:DONE             wrapper.m_frags.wordWrap = false;
// AS3:DONE         wrapper.players_bg._alpha = Config.config.playersPanel.alpha;
// AS3:DONE         wrapper.m_list._alpha = 100;
// AS3:DONE     }

    private function setIsShowExtraModeActiveImpl(val)
    {
        base.setIsShowExtraModeActive(val);
        XVMAdjustPanelSize();
    }

    // PRIVATE

// AS3:DONE     private function updateSwitcherButton()
// AS3:DONE     {
// AS3:DONE         var btn:Object;
// AS3:DONE         switch (wrapper.state)
// AS3:DONE         {
// AS3:DONE             case net.wargaming.ingame.PlayersPanel.STATES.none.name:
// AS3:DONE                 btn = _root.switcher_mc.noneBtn;
// AS3:DONE                 break;
// AS3:DONE             case net.wargaming.ingame.PlayersPanel.STATES.short.name:
// AS3:DONE                 btn = _root.switcher_mc.shortBtn;
// AS3:DONE                 break;
// AS3:DONE             case net.wargaming.ingame.PlayersPanel.STATES.medium.name:
// AS3:DONE                 btn = _root.switcher_mc.mediumBtn;
// AS3:DONE                 break;
// AS3:DONE             case net.wargaming.ingame.PlayersPanel.STATES.medium2.name:
// AS3:DONE                 btn = _root.switcher_mc.mediumBtn2;
// AS3:DONE                 break;
// AS3:DONE             case net.wargaming.ingame.PlayersPanel.STATES.large.name:
// AS3:DONE                 btn = _root.switcher_mc.largeBtn;
// AS3:DONE                 break;
// AS3:DONE         }
// AS3:DONE         //currentType = value;
// AS3:DONE         btn.selected = true;
// AS3:DONE     }

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
        var obj:Object = BattleState.get(data.uid);
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
                widthDelta = -w;
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
                        type: isLeftPanel ? Events.E_LEFT_PANEL_SIZE_ADJUSTED : Events.E_RIGHT_PANEL_SIZE_ADJUSTED,
                        state: wrapper.state
                    });
                }
                return;
        }

        var squadSize:Number = cfg[wrapper.state].removeSquadIcon ? 0 : DEFAULT_SQUAD_SIZE;
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
                type: isLeftPanel ? Events.E_LEFT_PANEL_SIZE_ADJUSTED : Events.E_RIGHT_PANEL_SIZE_ADJUSTED,
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
