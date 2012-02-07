class net.wargaming.controls.buttons.SoundButton extends gfx.controls.Button implements net.wargaming.interfaces.IHelpLayoutComponent
{
    var addEventListener, __width, __height, helpLayout, _disabled, dispatchEvent, _focused, _displayFocus, focusIndicator, setState, _disableFocus, autoRepeat, buttonRepeatDelay, buttonRepeatInterval;
    function SoundButton()
    {
        super();
    } // End of the function
    function configUI()
    {
        super.configUI();
        this.addEventListener("rollOver", this, "onSoundOver");
        this.addEventListener("rollOut", this, "onSoundOut");
        this.addEventListener("press", this, "onSoundPress");
    } // End of the function
    function showHelpLayout()
    {
        helpLayout = net.wargaming.controls.HelpLayout.create(_root, {_borderWidth: __width, _borderHeight: __height, _direction: helpDirection, _text: helpText, _x: 0, _y: 0, _connectorLength: helpConnectorLength}, this);
    } // End of the function
    function closeHelpLayout()
    {
        net.wargaming.controls.HelpLayout.destroy(helpLayout);
    } // End of the function
    function onSoundOver(e)
    {
        this.playSound("over");
    } // End of the function
    function onSoundOut(e)
    {
        this.playSound("out");
    } // End of the function
    function onSoundPress(e)
    {
        this.playSound("press");
    } // End of the function
    function playSound(state)
    {
        gfx.io.GameDelegate.call("GuiSound.Button", [state, soundType]);
    } // End of the function
    function handleMouseRollOver(mouseIndex)
    {
        if (_disabled)
        {
            this.dispatchEvent({type: "rollOverDisabled", mouseIndex: mouseIndex});
            return;
        } // end if
        if (!_focused && !_displayFocus || focusIndicator != null)
        {
            this.setState("over");
        } // end if
        this.dispatchEvent({type: "rollOver", mouseIndex: mouseIndex});
    } // End of the function
    function handleMouseRollOut(mouseIndex)
    {
        if (_disabled)
        {
            this.dispatchEvent({type: "rollOutDisabled", mouseIndex: mouseIndex});
            return;
        } // end if
        if (!_focused && !_displayFocus || focusIndicator != null)
        {
            this.setState("out");
        } // end if
        this.dispatchEvent({type: "rollOut", mouseIndex: mouseIndex});
    } // End of the function
    function handleMousePress(mouseIndex, button)
    {
        if (_disabled)
        {
            this.dispatchEvent({type: "pressDisabled", mouseIndex: mouseIndex, button: button});
            return;
        } // end if
        if (!_disableFocus)
        {
            Selection.setFocus(this);
        } // end if
        this.setState("down");
        this.dispatchEvent({type: "press", mouseIndex: mouseIndex, button: button});
        if (autoRepeat)
        {
            buttonRepeatInterval = setInterval(this, "beginButtonRepeat", buttonRepeatDelay, mouseIndex, button);
        } // end if
    } // End of the function
    var soundType = "normal";
    var helpText = "";
    var helpDirection = "T";
    var helpConnectorLength = 12;
} // End of Class
