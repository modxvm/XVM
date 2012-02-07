class net.wargaming.ingame.PlayerListItemRenderer extends gfx.core.UIComponent
{
    var iconLoader, voice_waves, hit, dispatchEvent, _parent, vehicleLevel, gotoAndPlay, bg, vehicleActionMarker;
    function PlayerListItemRenderer()
    {
        super();
    } // End of the function
    function configUI()
    {
        super.configUI();
        iconLoader.addEventListener("ioError", this, "errorLoad");
        iconLoader.addEventListener("complete", this, "completeLoad");
        this.update();
        if (voice_waves instanceof net.wargaming.controls.VoiceWave)
        {
            voice_waves.setSpeaking(_speaking);
        } // end if
        hit.topmostLevel = true;
    } // End of the function
    function errorLoad(event)
    {
        event.target.source = "../maps/icons/vehicle/contour/noImage.tga";
    } // End of the function
    function get speaking()
    {
        return (_speaking);
    } // End of the function
    function set speaking(value)
    {
        _speaking = value;
        if (voice_waves instanceof net.wargaming.controls.VoiceWave && !data.muted)
        {
            voice_waves.setSpeaking(_speaking);
        } // end if
        //return (this.speaking());
        //null;
    } // End of the function
    function completeLoad(event)
    {
        event.target.visible = true;
    } // End of the function
    function get selected()
    {
        return (_selected);
    } // End of the function
    function set selected(value)
    {
        if (_selected == value)
        {
            return;
        } // end if
        _selected = value;
        this.setState();
        if (dispatchEvent != null)
        {
            this.dispatchEvent({type: "select", selected: _selected});
        } // end if
        //return (this.selected());
        //null;
    } // End of the function
    function __getColorTransform(schemeName)
    {
        //return (net.wargaming.managers.ColorSchemeManager.instance().getScheme(schemeName).transform);
    } // End of the function
    function setState()
    {
        var _loc4 = data.vehicleState;
        var _loc2 = (_loc4 & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0;
        var _loc5 = (_loc4 & net.wargaming.ingame.VehicleStateInBattle.IS_UNKNOWN) != 0;
        var _loc6 = _parent._parent.isColorBlind;
        vehicleLevel._alpha = _loc2 ? (100) : (50);
        this.gotoAndPlay(_loc2 ? ("up") : ("disabled"));
        var _loc3 = new flash.geom.Transform(iconLoader);
        if (!_loc5)
        {
            if (data.teamKiller)
            {
                _loc3.colorTransform = this.__getColorTransform(_loc2 ? ("teamkiller") : ("teamkiller_dead"));
            }
            else if (data.squad > 10)
            {
                _loc3.colorTransform = this.__getColorTransform(_loc2 ? ("squad") : ("squad_dead"));
            }
            else if (data.VIP)
            {
                _loc3.colorTransform = this.__getColorTransform(_loc2 ? ("VIP") : ("VIP_dead"));
            }
            else if (_selected)
            {
                _loc3.colorTransform = this.__getColorTransform(_loc2 ? ("selected") : ("selected_dead"));
            }
            else
            {
                _loc3.colorTransform = this.__getColorTransform(_loc2 ? ("normal") : ("normal_dead"));
            } // end else if
        }
        else
        {
            _loc3.colorTransform = this.__getColorTransform("normal_dead");
        } // end else if
        bg.gotoAndPlay(Boolean(data.isPostmortemView) ? ("self") : ("normal"));
    } // End of the function
    function update()
    {
        if (data)
        {
            this.__set__visible(true);
            iconLoader.__set__visible(true);
            this.__set__speaking(data.speaking);
            vehicleLevel._visible = data.level > 0;
            vehicleLevel.gotoAndStop(data.level);
            if (iconLoader instanceof gfx.controls.UILoader && iconLoader.__get__source() != data.icon)
            {
                iconLoader.__set__source(data.icon);
            } // end if
            if (voice_waves instanceof net.wargaming.controls.VoiceWave)
            {
                voice_waves.setMuted(data.muted);
            } // end if
            if (vehicleActionMarker instanceof net.wargaming.controls.VehicleActionMarker)
            {
                vehicleActionMarker.__set__action(data.vehAction);
                vehicleActionMarker.__set__team(data.team == _root.statsData.playerTeam ? ("myteam") : ("enemy"));
            } // end if
        }
        else
        {
            this.__set__visible(false);
            if (voice_waves instanceof net.wargaming.controls.VoiceWave)
            {
                voice_waves.setMuted(false);
                voice_waves.setSpeaking(false, true);
            } // end if
            if (vehicleActionMarker instanceof net.wargaming.controls.VehicleActionMarker)
            {
                vehicleActionMarker.__set__action(0);
            } // end if
        } // end else if
    } // End of the function
    function setData(data)
    {
        this.data = data;
        this.update();
        this.setState();
    } // End of the function
    function setListData(index, label, selected)
    {
        this.__set__selected(selected);
    } // End of the function
    var _speaking = false;
    var _selected = false;
    var data = null;
} // End of Class
