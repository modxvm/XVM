class net.wargaming.controls.TrainingPlayerRenderer extends gfx.core.UIComponent
{
    var iconLoader, _toolTip, data, hiddenTextField, voiceWave, gotoAndPlay, __get__disabled, _disabled, dispatchEvent, __get__selected, vehicleField, textField, vehicleLevelField, stateField, __set__disabled, __set__selected, invalidate;
    function TrainingPlayerRenderer()
    {
        super();
        Mouse.addListener(this);
    } // End of the function
    function configUI()
    {
        super.configUI();
        iconLoader.addEventListener("ioError", this, "errorLoad");
        iconLoader.addEventListener("complete", this, "completeLoad");
        function onRollOver(args)
        {
            if (_toolTip && data)
            {
                net.wargaming.managers.ToolTipManager.show(_toolTip);
            } // end if
        } // End of the function
        function onRollOut(args)
        {
            net.wargaming.managers.ToolTipManager.hide();
        } // End of the function
        this.update();
        hiddenTextField._visible = false;
        hiddenTextField.noTranslate = true;
        voiceWave._visible = _global.wg_isShowVoiceChat;
        net.wargaming.Account.addPlayerSpeakingCallBack(this, "onPlayerSpeak");
    } // End of the function
    function onMouseDown(button, target)
    {
        if (Mouse.RIGHT == button)
        {
            for (var _loc3 = Mouse.getTopMostEntity(); _loc3; _loc3 = _loc3._parent)
            {
                if (_loc3 == this && data)
                {
                    var _loc4 = new net.wargaming.managers.XMLKeyConverter();
                    net.wargaming.messenger.managers.UserContextMenuHandler.showMenu(this, data, [["userInfo"], [Boolean(net.wargaming.Account.__get__attrs() & net.wargaming.Account.ACCOUNT_ATTR.TRADING) ? ("moneyTransfer") : (null)], [{id: "appeal", label: _loc4.convert("#menu:contextMenu/appeal") + " (" + net.wargaming.Account.__get__denunciations() + ")", disabled: net.wargaming.Account.__get__denunciations() == 0}, "offend", "notFairPlay", "teamKill", "bot"], [net.wargaming.messenger.MessengerUtils.isFriend(data) ? ("createPrivateChannel") : (null)], [net.wargaming.messenger.MessengerUtils.isFriend(data) ? ("removeFromFriends") : ("addToFriends")], [net.wargaming.messenger.MessengerUtils.isIgnored(data) ? ("removeFromIgnored") : ("addToIgnored")], ["copyToClipBoard"], [!net.wargaming.messenger.MessengerUtils.isIgnored(data) && _global.wg_isShowVoiceChat ? (net.wargaming.messenger.MessengerUtils.isMuted(data) ? ("unsetMuted") : ("setMuted")) : (null)]]);
                } // end if
            } // end of for
        } // end if
    } // End of the function
    function copyUserNameToClipboard(text)
    {
        hiddenTextField.text = text;
        hiddenTextField.copyToClipboard(false, 0, text.length);
    } // End of the function
    function __speak(isSpeak, forcedStop)
    {
        if (isSpeak)
        {
            forcedStop = false;
        } // end if
        if (voiceWave instanceof net.wargaming.controls.VoiceWave)
        {
            voiceWave.setSpeaking(isSpeak, forcedStop);
        } // end if
    } // End of the function
    function onPlayerSpeak(args)
    {
        if (data != null && args.playerID == data.uid)
        {
            this.__speak(args.speaking);
        } // end if
    } // End of the function
    function errorLoad(event)
    {
        if (data)
        {
            event.target.source = "../maps/icons/vehicle/contour/noImage.tga";
        } // end if
    } // End of the function
    function completeLoad(event)
    {
        event.target.visible = true;
    } // End of the function
    function setState()
    {
        var _loc3 = new flash.geom.ColorTransform();
        if (super.__get__disabled() && _selected)
        {
            this.gotoAndPlay("selected_disabled");
            _loc3.alphaMultiplier = 0.700000;
            _loc3.redOffset = 21;
            _loc3.greenOffset = 9;
            _loc3.blueMultiplier = 0.510000;
            _loc3.greenMultiplier = 0.870000;
        }
        else if (this.__get__disabled())
        {
            this.gotoAndPlay("disabled");
            _loc3.alphaMultiplier = 0.700000;
            _loc3.redMultiplier = 0.100000;
            _loc3.blueMultiplier = 0.100000;
            _loc3.greenMultiplier = 0.100000;
        }
        else if (_selected)
        {
            this.gotoAndPlay("selected_up");
            _loc3.redOffset = 21;
            _loc3.greenOffset = 9;
            _loc3.blueMultiplier = 0.510000;
            _loc3.greenMultiplier = 0.870000;
        }
        else
        {
            this.gotoAndPlay("up");
        } // end else if
        var _loc4 = new flash.geom.Transform(iconLoader);
        _loc4.colorTransform = _loc3;
        if (_state == 1)
        {
            this.gotoAndPlay("suspend");
        }
        else if (_state == 2)
        {
            this.gotoAndPlay("inbattle");
        } // end else if
        this.updateAfterStateChange();
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
        null;
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
        null;
    } // End of the function
    function update()
    {
        if (data)
        {
            vehicleField.text = data.vehicle;
            textField.wordWrap = true;
            textField.selectable = false;
            textField.text = _toolTip = data.label;
            if (textField.getLineLength(0) < textField.text.length)
            {
                textField.text = textField.text.substr(0, textField.getLineLength(0) - 2) + "..";
            } // end if
            vehicleLevelField.text = data.level;
            stateField.text = "#menu:training/info/states/state" + data.state;
            if (iconLoader instanceof gfx.controls.UILoader)
            {
                iconLoader.__set__visible(data.icon != "");
                if (iconLoader.__get__source() != data.icon)
                {
                    iconLoader.__set__source(data.icon);
                } // end if
                if (data.icon == "")
                {
                    iconLoader.__set__source("error_path");
                } // end if
            } // end if
            this.__speak(data.speak, true);
            _state = data.state;
            this.__set__disabled(data.disabled);
            if (voiceWave instanceof net.wargaming.controls.VoiceWave)
            {
                voiceWave.setMuted(net.wargaming.messenger.MessengerUtils.isMuted(data));
            } // end if
        }
        else
        {
            textField.text = "";
            vehicleField.text = "";
            vehicleLevelField.text = "";
            stateField.text = "";
            iconLoader._visible = false;
            this.__set__disabled(false);
            _state = 0;
            this.__speak(false, true);
            if (voiceWave instanceof net.wargaming.controls.VoiceWave)
            {
                voiceWave.setMuted(false);
            } // end if
        } // end else if
    } // End of the function
    function setData(data)
    {
        this.data = data;
        this.update();
    } // End of the function
    function setListData(index, label, selected)
    {
        this.__set__selected(selected);
        this.setState();
    } // End of the function
    function updateAfterStateChange()
    {
        this.update();
        this.invalidate();
    } // End of the function
    var _selected = false;
    var _state = 0;
} // End of Class
