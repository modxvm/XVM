intrinsic class gfx.controls.Button extends gfx.core.UIComponent
{
/*    var _disabled, tabEnabled, focusEnabled, inspectableGroupName, __set__group, __set__label, __get__labelID, _label, textField, initialized, _width, __width, __get__label, __get__disabled, _focused, __get__displayFocus, focusIndicator, dispatchEvent, __get__selected, _group, __get__groupName, _parent, __get__group, __get__disableFocus, __get__disableConstraints, __set__width, __get__autoSize, _name, constraints, sizeIsInvalid, onRollOver, onRollOut, onPress, onRelease, onDragOver, onDragOut, onReleaseOutside, __height, _height, validateNow, __get__height, __get__width, invalidate, gotoAndPlay, _displayFocus, buttonRepeatInterval, doubleClickInterval, __set__selected, __set__autoSize, __set__disableConstraints, __set__disableFocus, __set__disabled, __set__groupName, __set__labelID;
    function Button()
    {
        super();
        focusEnabled = tabEnabled = _disableFocus ? (false) : (!_disabled);
        if (inspectableGroupName != null && inspectableGroupName != "")
        {
            this.__set__group(inspectableGroupName);
        } // end if
    } // End of the function
    function get labelID()
    {
        return (null);
    } // End of the function
    function set labelID(value)
    {
        if (value != "")
        {
            this.__set__label(gfx.utils.Locale.getTranslatedString(value));
        } // end if
        //return (this.labelID());
        null;
    } // End of the function
    function get label()
    {
        return (_label);
    } // End of the function
    function set label(value)
    {
        _label = value;
        if (textField != null)
        {
            textField.text = _label;
        } // end if
        if (_autoSize && textField != null && initialized)
        {
            __width = _width = this.calculateWidth();
        } // end if
        this.updateAfterStateChange();
        //return (this.label());
        null;
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
        this.clearRepeatInterval();
        focusEnabled = tabEnabled = _disableFocus ? (false) : (!_disabled);
        this.setState(_disabled ? ("disabled") : ("up"));
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
        if (!_disabled)
        {
            if (!_focused)
            {
                this.setState(this.__get__displayFocus() && focusIndicator == null ? ("over") : ("up"));
            }
            else if (pressedByKeyboard && focusIndicator != null)
            {
                this.setState("kb_selecting");
            }
            else
            {
                this.setState("selecting");
            } // end else if
        }
        else
        {
            this.setState("disabled");
        } // end else if
        if (dispatchEvent != null)
        {
            this.dispatchEvent({type: "select", selected: _selected});
        } // end if
        //return (this.selected());
        null;
    } // End of the function
    function get groupName()
    {
        return (_group == null ? (null) : (_group.name));
    } // End of the function
    function set groupName(value)
    {
        this.__set__group(value);
        //return (this.groupName());
        null;
    } // End of the function
    function get group()
    {
        return (_group);
    } // End of the function
    function set group(value)
    {
        var _loc2 = (gfx.controls.ButtonGroup)(value);
        if (typeof(value) == "string")
        {
            _loc2 = _parent["_buttonGroup_" + value];
            if (_loc2 == null)
            {
                _loc2 = new gfx.controls.ButtonGroup(value.toString(), _parent);
                _parent["_buttonGroup_" + value] = new gfx.controls.ButtonGroup(value.toString(), _parent);
            } // end if
        } // end if
        if (_group == _loc2)
        {
            return;
        } // end if
        if (_group != null)
        {
            _group.removeButton(this);
        } // end if
        _group = _loc2;
        if (_group != null)
        {
            _loc2.addButton(this);
        } // end if
        //return (this.group());
        null;
    } // End of the function
    function get disableFocus()
    {
        return (_disableFocus);
    } // End of the function
    function set disableFocus(value)
    {
        _disableFocus = value;
        focusEnabled = tabEnabled = _disableFocus ? (false) : (!_disabled);
        //return (this.disableFocus());
        null;
    } // End of the function
    function get disableConstraints()
    {
        return (_disableConstraints);
    } // End of the function
    function set disableConstraints(value)
    {
        _disableConstraints = value;
        //return (this.disableConstraints());
        null;
    } // End of the function
    function get autoSize()
    {
        return (_autoSize);
    } // End of the function
    function set autoSize(value)
    {
        _autoSize = value;
        if (value && initialized)
        {
            this.__set__width(this.calculateWidth());
        } // end if
        //return (this.autoSize());
        null;
    } // End of the function
    function setSize(width, height)
    {
        super.setSize(width, height);
    } // End of the function
    function handleInput(details, pathToFocus)
    {
        switch (details.navEquivalent)
        {
            case gfx.ui.NavigationCode.ENTER:
            {
                if (details.value == "keyDown")
                {
                    if (!pressedByKeyboard)
                    {
                        this.handlePress();
                    } // end if
                }
                else
                {
                    this.handleRelease();
                } // end else if
                return (true);
            }
        } // End of switch
        return (false);
    } // End of the function
    function toString()
    {
        return ("[Scaleform Button " + _name + "]");
    } // End of the function
    function configUI()
    {
        constraints = new gfx.utils.Constraints(this, true);
        if (!_disableConstraints)
        {
            constraints.addElement(textField, gfx.utils.Constraints.ALL);
        } // end if
        super.configUI();
        if (_autoSize)
        {
            sizeIsInvalid = true;
        } // end if
        onRollOver = handleMouseRollOver;
        onRollOut = handleMouseRollOut;
        onPress = handleMousePress;
        onRelease = handleMouseRelease;
        onDragOver = handleDragOver;
        onDragOut = handleDragOut;
        onReleaseOutside = handleReleaseOutside;
        if (focusIndicator != null && !_focused && focusIndicator._totalFrames == 1)
        {
            focusIndicator._visible = false;
        } // end if
        this.updateAfterStateChange();
    } // End of the function
    function draw()
    {
        if (sizeIsInvalid)
        {
            if (_autoSize && textField != null)
            {
                __width = this.calculateWidth();
            } // end if
            _width = __width;
            _height = __height;
        } // end if
        constraints.update(__width, __height);
    } // End of the function
    function updateAfterStateChange()
    {
        if (!initialized)
        {
            return;
        } // end if
        this.validateNow();
        if (textField != null && _label != null)
        {
            textField.text = _label;
        } // end if
        if (constraints != null)
        {
            constraints.update(this.__get__width(), this.__get__height());
        } // end if
        this.dispatchEvent({type: "stateChange", state: state});
    } // End of the function
    function calculateWidth()
    {
        if (constraints == null)
        {
            this.invalidate();
            return;
        } // end if
        var _loc2 = constraints.getElement(textField).metrics;
        var _loc3 = textField.textWidth + _loc2.left + _loc2.right + 5;
        return (_loc3);
    } // End of the function
    function setState(state)
    {
        this.state = state;
        var _loc5 = this.getStatePrefixes();
        var _loc3 = stateMap[state];
        if (_loc3 == null || _loc3.length == 0)
        {
            return;
        } // end if
        do
        {
            var _loc4 = _loc5.pop().toString();
            for (var _loc2 = _loc3.length - 1; _loc2 >= 0; --_loc2)
            {
                this.gotoAndPlay(_loc4 + _loc3[_loc2]);
            } // end of for
        } while (_loc5.length > 0)
        this.updateAfterStateChange();
    } // End of the function
    function getStatePrefixes()
    {
        return (_selected ? (["selected_", ""]) : ([""]));
    } // End of the function
    function changeFocus()
    {
        if (_disabled)
        {
            return;
        } // end if
        if (focusIndicator == null)
        {
            this.setState(_focused || _displayFocus ? ("over") : ("out"));
            if (pressedByKeyboard && !_focused)
            {
                pressedByKeyboard = false;
            } // end if
        } // end if
        if (focusIndicator != null)
        {
            if (focusIndicator._totalframes == 1)
            {
                focusIndicator._visible = _focused != 0;
            }
            else
            {
                focusIndicator.gotoAndPlay(_focused ? ("show") : ("hide"));
                focusIndicator.gotoAndPlay("state" + _focused);
            } // end else if
            if (pressedByKeyboard && !_focused)
            {
                this.setState("kb_release");
                pressedByKeyboard = false;
            } // end if
        } // end if
    } // End of the function
    function handleMouseRollOver(mouseIndex)
    {
        if (_disabled)
        {
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
    function handlePress()
    {
        if (_disabled)
        {
            return;
        } // end if
        pressedByKeyboard = true;
        this.setState(focusIndicator == null ? ("down") : ("kb_down"));
        this.dispatchEvent({type: "press"});
    } // End of the function
    function handleMouseRelease(mouseIndex, button)
    {
        if (_disabled)
        {
            return;
        } // end if
        clearInterval(buttonRepeatInterval);
        delete this.buttonRepeatInterval;
        if (doubleClickEnabled)
        {
            if (doubleClickInterval == null)
            {
                doubleClickInterval = setInterval(this, "doubleClickExpired", doubleClickDuration);
            }
            else
            {
                this.doubleClickExpired();
                this.dispatchEvent({type: "doubleClick", mouseIndex: mouseIndex, button: button});
                this.setState("release");
                return;
            } // end if
        } // end else if
        this.setState("release");
        this.handleClick(mouseIndex, button);
    } // End of the function
    function handleRelease()
    {
        if (_disabled)
        {
            return;
        } // end if
        this.setState(focusIndicator == null ? ("release") : ("kb_release"));
        this.handleClick(null);
        pressedByKeyboard = false;
    } // End of the function
    function handleClick(mouseIndex, button)
    {
        if (toggle)
        {
            this.__set__selected(!_selected);
        } // end if
        this.dispatchEvent({type: "click", mouseIndex: mouseIndex, button: button});
    } // End of the function
    function handleDragOver(mouseIndex)
    {
        if (_disabled || lockDragStateChange)
        {
            return;
        } // end if
        if (_focused || _displayFocus)
        {
            this.setState(focusIndicator == null ? ("down") : ("kb_down"));
        }
        else
        {
            this.setState("over");
        } // end else if
        this.dispatchEvent({type: "dragOver", mouseIndex: mouseIndex});
    } // End of the function
    function handleDragOut(mouseIndex)
    {
        if (_disabled || lockDragStateChange)
        {
            return;
        } // end if
        if (_focused || _displayFocus)
        {
            this.setState(focusIndicator == null ? ("release") : ("kb_release"));
        }
        else
        {
            this.setState("out");
        } // end else if
        this.dispatchEvent({type: "dragOut", mouseIndex: mouseIndex});
    } // End of the function
    function handleReleaseOutside(mouseIndex, button)
    {
        this.clearRepeatInterval();
        if (_disabled)
        {
            return;
        } // end if
        if (lockDragStateChange)
        {
            if (_focused || _displayFocus)
            {
                this.setState(focusIndicator == null ? ("release") : ("kb_release"));
            }
            else
            {
                this.setState("kb_release");
            } // end if
        } // end else if
        this.dispatchEvent({type: "releaseOutside", state: state, button: button});
    } // End of the function
    function doubleClickExpired()
    {
        clearInterval(doubleClickInterval);
        delete this.doubleClickInterval;
    } // End of the function
    function beginButtonRepeat(mouseIndex, button)
    {
        this.clearRepeatInterval();
        buttonRepeatInterval = setInterval(this, "handleButtonRepeat", buttonRepeatDuration, mouseIndex, button);
    } // End of the function
    function handleButtonRepeat(mouseIndex, button)
    {
        this.dispatchEvent({type: "click", mouseIndex: mouseIndex, button: button});
    } // End of the function
    function clearRepeatInterval()
    {
        clearInterval(buttonRepeatInterval);
        delete this.buttonRepeatInterval;
    } // End of the function
    var state = "up";
    var toggle = false;
    var doubleClickEnabled = false;
    var autoRepeat = false;
    var lockDragStateChange = false;
    var _selected = false;
    var _autoSize = false;
    var _disableFocus = false;
    var _disableConstraints = false;
    var doubleClickDuration = 250;
    var buttonRepeatDuration = 100;
    var buttonRepeatDelay = 100;
    var pressedByKeyboard = false;
    var stateMap = {up: ["up"], over: ["over"], down: ["down"], release: ["release", "over"], out: ["out", "up"], disabled: ["disabled"], selecting: ["selecting", "over"], kb_selecting: ["kb_selecting", "up"], kb_release: ["kb_release", "out", "up"], kb_down: ["kb_down", "down"]};
*/
}
