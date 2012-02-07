class gfx.controls.TextInput extends gfx.core.UIComponent
{
    var _disabled, tabEnabled, focusEnabled, textField, defaultTextFormat, __set__text, __get__textID, isHtml, __get__text, __get__htmlText, __get__editable, _password, __get__password, __get__maxChars, __get__noTranslate, initialized, __get__disabled, _name, constraints, _focused, gotoAndPlay, onRollOver, onRollOut, onPress, dispatchEvent, __height, __width, sizeIsInvalid, _width, _height, _selectable, __set__disabled, __set__editable, __set__htmlText, __get__length, __set__maxChars, __set__noTranslate, __set__password, __set__textID;
    function TextInput()
    {
        super();
        tabEnabled = !_disabled;
        focusEnabled = !_disabled;
        defaultTextFormat = textField.getNewTextFormat();
        defaultTextFormat.italic = true;
        defaultTextFormat.color = 11184810;
        _global.gfxExtensions = true;
    } // End of the function
    function get textID()
    {
        return (null);
    } // End of the function
    function set textID(value)
    {
        if (value != "")
        {
            this.__set__text(gfx.utils.Locale.getTranslatedString(value));
        } // end if
        //return (this.textID());
        null;
    } // End of the function
    function get text()
    {
        return (_text);
    } // End of the function
    function set text(value)
    {
        _text = value;
        isHtml = false;
        this.updateText();
        //return (this.text());
        null;
    } // End of the function
    function get htmlText()
    {
        return (_text);
    } // End of the function
    function set htmlText(value)
    {
        _text = value;
        isHtml = true;
        this.updateText();
        //return (this.htmlText());
        null;
    } // End of the function
    function get editable()
    {
        return (_editable);
    } // End of the function
    function set editable(value)
    {
        _editable = value;
        tabEnabled = !_disabled && !_editable;
        this.updateTextField();
        //return (this.editable());
        null;
    } // End of the function
    function get password()
    {
        return (textField.password);
    } // End of the function
    function set password(value)
    {
        _password = textField.password = value;
        //return (this.password());
        null;
    } // End of the function
    function get maxChars()
    {
        return (_maxChars);
    } // End of the function
    function set maxChars(value)
    {
        _maxChars = textField.maxChars = value;
        //return (this.maxChars());
        null;
    } // End of the function
    function get noTranslate()
    {
        return (_noTranslate);
    } // End of the function
    function set noTranslate(value)
    {
        _noTranslate = textField.noTranslate = value;
        //return (this.noTranslate());
        null;
    } // End of the function
    function get disabled()
    {
        return (_disabled);
    } // End of the function
    function set disabled(value)
    {
        super.__set__disabled(value);
        tabEnabled = !_disabled;
        focusEnabled = !_disabled;
        if (initialized)
        {
            this.setState();
            this.updateTextField();
        } // end if
        //return (this.disabled());
        null;
    } // End of the function
    function appendText(text)
    {
        _text = _text + text;
        isHtml = false;
        this.updateText();
    } // End of the function
    function appendHtml(text)
    {
        _text = _text + text;
        isHtml = true;
        this.updateText();
    } // End of the function
    function get length()
    {
        return (textField.length);
    } // End of the function
    function handleInput(details, pathToFocus)
    {
        if (details.value != "keyDown")
        {
            return (false);
        } // end if
        if (Selection.getFocus() != null)
        {
            return (false);
        } // end if
        Selection.setFocus(textField);
        return (true);
    } // End of the function
    function toString()
    {
        return ("[Scaleform TextInput " + _name + "]");
    } // End of the function
    function configUI()
    {
        super.configUI();
        constraints = new gfx.utils.Constraints(this, true);
        constraints.addElement(textField, gfx.utils.Constraints.ALL);
        this.setState();
        this.updateTextField();
        this.setMouseHandlers();
    } // End of the function
    function setState()
    {
        this.gotoAndPlay(_disabled ? ("disabled") : (_focused ? ("focused") : ("default")));
    } // End of the function
    function setMouseHandlers()
    {
        if (actAsButton == false)
        {
            return;
        } // end if
        if (_disabled || _focused)
        {
            delete this.onRollOver;
            delete this.onRollOut;
            delete this.onPress;
        }
        else if (_editable)
        {
            onRollOver = handleMouseRollOver;
            onRollOut = handleMouseRollOut;
            onPress = handleMousePress;
        } // end else if
    } // End of the function
    function handleMousePress(mouseIndex, button)
    {
        this.dispatchEvent({type: "press", mouseIndex: mouseIndex, button: button});
        Selection.setFocus(this);
    } // End of the function
    function handleMouseRollOver(mouseIndex)
    {
        this.gotoAndPlay("default");
        this.gotoAndPlay("over");
        if (constraints)
        {
            constraints.update(__width, __height);
        } // end if
        this.updateTextField();
        this.dispatchEvent({type: "rollOver", mouseIndex: mouseIndex});
    } // End of the function
    function handleMouseRollOut(mouseIndex)
    {
        this.gotoAndPlay("default");
        this.gotoAndPlay("out");
        if (constraints)
        {
            constraints.update(__width, __height);
        } // end if
        this.updateTextField();
        this.dispatchEvent({type: "rollOut", mouseIndex: mouseIndex});
    } // End of the function
    function draw()
    {
        if (sizeIsInvalid)
        {
            _width = __width;
            _height = __height;
        } // end if
        super.draw();
        constraints.update(__width, __height);
    } // End of the function
    function changeFocus()
    {
        tabEnabled = !_disabled;
        if (!_focused)
        {
            hscroll = textField.hscroll;
        } // end if
        this.setState();
        if (constraints)
        {
            constraints.update(__width, __height);
        } // end if
        this.updateTextField();
        if (_focused && Selection.getFocus() != textField && textField.type == "input")
        {
            tabEnabled = false;
            Selection.setFocus(textField);
            Selection.setSelection(0, textField.htmlText.length);
        } // end if
        this.setMouseHandlers();
        textField.hscroll = hscroll;
    } // End of the function
    function updateText()
    {
        if (_text != "")
        {
            if (isHtml)
            {
                textField.html = true;
                textField.htmlText = _text;
            }
            else
            {
                textField.html = false;
                textField.text = _text;
            } // end else if
        }
        else
        {
            textField.text = "";
            if (!_focused && defaultText != "")
            {
                textField.text = defaultText;
                textField.setTextFormat(defaultTextFormat);
            } // end if
        } // end else if
    } // End of the function
    function updateTextField()
    {
        if (textField != null)
        {
            if (!_selectable)
            {
                _selectable = textField.selectable;
            } // end if
            textField.noTranslate = _noTranslate;
            this.updateText();
            textField.maxChars = _maxChars;
            textField.password = _password;
            textField.selectable = _disabled ? (false) : (_selectable || _editable);
            textField.type = _editable && !_disabled ? ("input") : ("dynamic");
            textField.focusTarget = this;
            textField.hscroll = hscroll;
            textField.addListener(this);
        } // end if
    } // End of the function
    function onChanged(target)
    {
        if (!changeLock)
        {
            _text = isHtml ? (textField.htmlText) : (textField.text);
            this.dispatchEvent({type: "textChange"});
        } // end if
    } // End of the function
    var defaultText = "";
    var _text = "";
    var _maxChars = 0;
    var _noTranslate = false;
    var _editable = true;
    var actAsButton = false;
    var hscroll = 0;
    var changeLock = false;
} // End of Class
