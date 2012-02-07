class net.wargaming.controls.LobbyPlayerListItemRenderer extends net.wargaming.controls.TextFieldShort
{
    var iconLoader, onRollOut, onRollOver, data, voiceWave, _disabled, dispatchEvent, gotoAndPlay, _textColor, vehicleField, self_bg, squad, vehicleActionMarker, textField, invalidate;
    function LobbyPlayerListItemRenderer()
    {
        super();
    } // End of the function
    function configUI()
    {
        super.configUI();
        iconLoader.addEventListener("ioError", this, "errorLoad");
        iconLoader.addEventListener("complete", this, "completeLoad");
        this.update();
        this.__set__shadowColor("Black");
        net.wargaming.Account.addPlayerSpeakingCallBack(this, "onPlayerSpeak");
        onRollOver = onRollOut = null;
    } // End of the function
    function onPlayerSpeak(args)
    {
        if (data != null && args.playerID == data.id)
        {
            voiceWave.setSpeaking(args.speaking);
        } // end if
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
    function get disabled()
    {
        return (_disabled);
    } // End of the function
    function set disabled(value)
    {
        if (_disabled == value)
        {
            return;
        } // end if
        super.__set__disabled(value);
        this.setState();
        //return (this.disabled());
        //null;
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
    function setState()
    {
        var _loc3 = null;
        if (_selected || data.squad > 10)
        {
            this.gotoAndPlay(!super.__get__disabled() ? ("selected_up") : ("selected_disabled"));
            _loc3 = net.wargaming.managers.ColorSchemeManager.__get__instance().getScheme(!super.__get__disabled() ? ("selected") : ("selected_dead"));
        }
        else
        {
            this.gotoAndPlay(!super.__get__disabled() ? ("up") : ("disabled"));
            _loc3 = net.wargaming.managers.ColorSchemeManager.__get__instance().getScheme(!super.__get__disabled() ? ("normal") : ("normal_dead"));
        } // end else if
        if (_loc3)
        {
            _textColor = _loc3.rgb;
            vehicleField.textColor = _loc3.rgb;
            var _loc5 = new flash.geom.Transform(iconLoader);
            _loc5.colorTransform = _loc3.transform;
        }
        else
        {
            var _loc4 = !super.__get__disabled() ? (16777215) : (5130300);
            var _loc6 = !super.__get__disabled() ? (new flash.geom.ColorTransform(1, 1, 1, 1, 0, 0, 0, 0)) : (new flash.geom.ColorTransform(0.800000, 0.800000, 0.800000, 0.500000, 0, 0, 0, 0));
            _textColor = _loc4;
            vehicleField.textColor = _loc4;
            var _loc5 = new flash.geom.Transform(iconLoader);
            _loc5.colorTransform = _loc6;
        } // end else if
        this.updateAfterStateChange();
    } // End of the function
    function update()
    {
        if (data)
        {
            self_bg._visible = _selected;
            this.__set__text(data.label);
            vehicleField.text = data.vehicle;
            if (iconLoader instanceof gfx.controls.UILoader)
            {
                iconLoader.__set__visible(true);
                if (iconLoader.__get__source() != data.icon)
                {
                    iconLoader.__set__source(data.icon);
                } // end if
            } // end if
            if (squad && squad.setSquad)
            {
                squad.setSquad(data.squad);
            } // end if
            this.__set__disabled(data.disabled);
            if (voiceWave instanceof net.wargaming.controls.VoiceWave)
            {
                if (data.speak)
                {
                    voiceWave.setSpeaking(true);
                } // end if
                voiceWave.setMuted(data.muted);
            } // end if
            if (vehicleActionMarker instanceof net.wargaming.controls.VehicleActionMarker)
            {
                vehicleActionMarker.__set__action(data.vehAction);
                vehicleActionMarker.__set__team(data.team == "team1" ? ("myteam") : ("enemy"));
            } // end if
        }
        else
        {
            self_bg._visible = false;
            textField.text = "";
            vehicleField.text = "";
            iconLoader._visible = false;
            this.__set__disabled(false);
            if (voiceWave instanceof net.wargaming.controls.VoiceWave)
            {
                voiceWave.setSpeaking(false, true);
                voiceWave.setMuted(false);
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
    } // End of the function
    function updateAfterStateChange()
    {
        this.update();
        this.invalidate();
    } // End of the function
    var _selected = false;
} // End of Class
