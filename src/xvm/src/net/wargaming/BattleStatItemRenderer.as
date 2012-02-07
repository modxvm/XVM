class net.wargaming.BattleStatItemRenderer extends net.wargaming.controls.TextFieldShort
{
    var iconLoader, data, __set__visible, squad, __set__text, col3, playerStatus, col4, col5, vehicleActionMarker, __set__shadowColor, vip_killer, gotoAndPlay, __get__selected, textField, self_bg, initialized, validateNow, constraints, __get__height, __get__width, state, dispatchEvent;
    function BattleStatItemRenderer()
    {
        super();
    } // End of the function
    function configUI()
    {
        super.configUI();
        iconLoader.addEventListener("ioError", this, "errorLoad");
        iconLoader.addEventListener("complete", this, "completeLoad");
    } // End of the function
    function errorLoad(event)
    {
        if (event.target.source)
        {
            event.target.source = "../maps/icons/vehicle/contour/noImage.tga";
        } // end if
    } // End of the function
    function completeLoad(event)
    {
        event.target.visible = true;
    } // End of the function
    function updateData()
    {
        if (data)
        {
            this.__set__visible(true);
            if (squad && squad.setSquad)
            {
                squad.setSquad(data.squad);
            } // end if
            if (data.clanAbbrev && data.clanAbbrev != "")
            {
                this.__set__text(data.label + "[" + data.clanAbbrev + "]");
            }
            else
            {
                this.__set__text(data.label);
            } // end else if
            col3.text = data.vehicle;
            if (iconLoader instanceof gfx.controls.UILoader)
            {
                iconLoader.__set__visible(true);
                if (iconLoader.__get__source() != data.icon)
                {
                    iconLoader.__set__source(data.icon);
                } // end if
            } // end if
            if (playerStatus)
            {
                playerStatus.gotoAndStop(data.vehicleState + 1);
            } // end if
            if (col4)
            {
                col4.text = "#ingame_gui:statistics/playerState/" + String(data.vehicleState);
                if (data.vehicleState != net.wargaming.ingame.VehicleStateInBattle.IS_UNKNOWN)
                {
                    col4.text = "#ingame_gui:statistics/playerState/" + String(data.vehicleState);
                }
                else
                {
                    col4.text = "#ingame_gui:players_panel/unknown_vehicleState";
                } // end if
            } // end else if
            col5.text = data.frags;
            if (data.vipKilled > 0)
            {
                col5.text = col5.text + ("/" + data.vipKilled.toString());
            } // end if
            if (vehicleActionMarker instanceof net.wargaming.controls.VehicleActionMarker)
            {
                vehicleActionMarker.__set__action(data.vehAction);
                vehicleActionMarker.__set__team(data.team == _root.statsData.playerTeam ? ("myteam") : ("enemy"));
            } // end if
            this.__set__shadowColor("Black");
            this.updateState();
            vip_killer._visible = data.vipKilled > 0;
        }
        else
        {
            this.__set__visible(false);
        } // end else if
    } // End of the function
    function updateState()
    {
        var _loc6 = new flash.geom.ColorTransform();
        var _loc4 = data.vehicleState;
        var _loc3 = (_loc4 & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0;
        this.gotoAndPlay(_loc3 ? ("up") : ("disabled"));
        var _loc2 = null;
        if (data.squad > 10 && !this.__get__selected())
        {
            _loc2 = net.wargaming.managers.ColorSchemeManager.__get__instance().getScheme(_loc3 ? ("squad") : ("squad_dead"));
        }
        else if (this.__get__selected())
        {
            _loc2 = net.wargaming.managers.ColorSchemeManager.__get__instance().getScheme(_loc3 ? ("selected") : ("selected_dead"));
        }
        else if (data.teamKiller)
        {
            _loc2 = net.wargaming.managers.ColorSchemeManager.__get__instance().getScheme(_loc3 ? ("teamkiller") : ("teamkiller_dead"));
        }
        else if (data.VIP)
        {
            _loc2 = net.wargaming.managers.ColorSchemeManager.__get__instance().getScheme(_loc3 ? ("VIP") : ("VIP_dead"));
        }
        else
        {
            _loc2 = net.wargaming.managers.ColorSchemeManager.__get__instance().getScheme(_loc3 ? ("normal") : ("normal_dead"));
        } // end else if
        if (_loc2)
        {
            textField.textColor = _loc2.rgb;
            col3.textColor = _loc2.rgb;
            col5.textColor = _loc2.rgb;
            if (col4)
            {
                col4.textColor = _loc2.rgb;
            } // end if
            var _loc5 = new flash.geom.Transform(iconLoader);
            _loc5.colorTransform = _loc2.transform;
        } // end if
        self_bg._visible = data.isPostmortemView;
    } // End of the function
    function setData(data)
    {
        this.data = data;
        this.updateData();
    } // End of the function
    function updateAfterStateChange()
    {
        if (!initialized)
        {
            return;
        } // end if
        this.validateNow();
        this.updateData();
        if (constraints != null)
        {
            constraints.update(this.__get__width(), this.__get__height());
        } // end if
        this.dispatchEvent({type: "stateChange", state: state});
    } // End of the function
    function _getHTMLText(colorScheme, text)
    {
        var _loc1 = net.wargaming.managers.ColorSchemeManager.__get__instance().getScheme(colorScheme).rgb;
        if (_loc1)
        {
            return ("<font color=\'#" + _loc1.toString(16) + "\'>" + text + "</font><br/>");
        } // end if
        return ("<font>" + text + "</font><br/>");
    } // End of the function
} // End of Class
