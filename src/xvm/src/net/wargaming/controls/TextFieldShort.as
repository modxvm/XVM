class net.wargaming.controls.TextFieldShort extends gfx.controls.ListItemRenderer
{
    var textField, _textFormat, converter, _toolTip, _textFont, invalidate, _textSize, _textColor, _shadowColor, _text, _name;
    function TextFieldShort()
    {
        super();
        _global.gfxExtensions = 1;
        _textFormat = textField.getTextFormat();
        converter = new net.wargaming.managers.XMLKeyConverter();
    } // End of the function
    function configUI()
    {
        super.configUI();
/* fix decompiler error (sirmax2)
        function onRollOver(args)
        {
            if (_toolTip)
            {
                net.wargaming.managers.ToolTipManager.show(_toolTip);
            } // end if
        } // End of the function
        function onRollOut(args)
        {
            net.wargaming.managers.ToolTipManager.hide();
        } // End of the function
*/
		} // End of the function
    function get textFont()
    {
        return (_textFont);
    } // End of the function
    function set textFont(value)
    {
        if (_textFont == value)
        {
            return;
        } // end if
        _textFont = value;
        this.invalidate();
        //return (this.textFont());
        //null;
    } // End of the function
    function get textSize()
    {
        return (_textSize);
    } // End of the function
    function set textSize(value)
    {
        if (_textSize == value)
        {
            return;
        } // end if
        _textSize = value;
        this.invalidate();
        //return (this.textSize());
        //null;
    } // End of the function
    function get textColor()
    {
        return (_textColor);
    } // End of the function
    function set textColor(value)
    {
        if (_textColor == value)
        {
            return;
        } // end if
        _textColor = value;
        this.invalidate();
        //return (this.textColor());
        //null;
    } // End of the function
    function get shadowColor()
    {
        return (_shadowColor);
    } // End of the function
    function set shadowColor(value)
    {
        if (_shadowColor == value)
        {
            return;
        } // end if
        _shadowColor = value;
        this.invalidate();
        //return (this.shadowColor());
        //null;
    } // End of the function
    function get toolTip()
    {
        return (_toolTip);
    } // End of the function
    function set toolTip(value)
    {
        if (_toolTip == value)
        {
            return;
        } // end if
        if (!converter)
        {
            converter = new net.wargaming.managers.XMLKeyConverter();
        } // end if
        _toolTip = converter.convert(value);
        this.invalidate();
        //return (this.toolTip());
        //null;
    } // End of the function
    function get text()
    {
        return (_text);
    } // End of the function
    function set text(value)
    {
        if (_text == value)
        {
            return;
        } // end if
        _text = value;
        this.invalidate();
        //return (this.text());
        //null;
    } // End of the function
    function get label()
    {
        //return (this.text());
    } // End of the function
    function set label(value)
    {
        this.__set__text(value);
        //return (this.label());
        //null;
    } // End of the function
    function draw()
    {
        super.draw();
        if (textField)
        {
            _textFormat.color = _textColor;
            _textFormat.size = _textSize;
            _textFormat.font = _textFont;
            textField.wordWrap = true;
            textField.selectable = false;
            textField.text = text;
            textField.setTextFormat(_textFormat);
            if (_shadowColor == "Black")
            {
                textField.shadowBlurX = 3;
                textField.shadowBlurY = 3;
                textField.shadowStrength = 0.500000;
                textField.shadowQuality = 2;
                textField.shadowAngle = 45;
                textField.shadowDistance = 0;
                textField.shadowColor = 0;
            }
            else
            {
                textField.shadowBlurX = 0;
                textField.shadowBlurY = 0;
                textField.shadowStrength = 0.400000;
                textField.shadowQuality = 3;
                textField.shadowAngle = 90;
                textField.shadowDistance = 1;
                textField.shadowColor = 16777215;
            } // end else if
            if (textField.getLineLength(0) < textField.text.length)
            {
                textField.text = textField.text.substr(0, textField.getLineLength(0) - 2) + "..";
                textField.setTextFormat(_textFormat);
            } // end if
            _toolTip = converter.convert(this.__get__text());
        } // end if
    } // End of the function
    function toString()
    {
        return ("[Wargaming TextFieldShort " + _name);
    } // End of the function
    function handleInput(details, pathToFocus)
    {
        if (!handleKeyboard)
        {
            return (false);
        } // end if
        return (super.handleInput(details, pathToFocus));
    } // End of the function
    var handleKeyboard = true;
} // End of Class
