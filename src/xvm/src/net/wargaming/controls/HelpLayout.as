class net.wargaming.controls.HelpLayout extends gfx.core.UIComponent
{
    var _yscale, _xscale, border, connector, textField;
    static var modalBackground;
    function HelpLayout()
    {
        super();
    } // End of the function
    static function create(context, initProperties, relativeTo)
    {
        if (initProperties._text != null && initProperties._text.length > 0)
        {
            return (gfx.managers.PopUpManager.createPopUp(context, net.wargaming.controls.HelpLayout.hlMainSource, initProperties, relativeTo));
        }
        else
        {
            return (null);
        } // end else if
    } // End of the function
    static function createBackground(context)
    {
        net.wargaming.controls.HelpLayout.destroyBackground();
        modalBackground = gfx.managers.PopUpManager.createPopUp(context, "PopUpModal", {_x: 0, _y: 0, _alpha: 50}, _level0);
        if (net.wargaming.controls.HelpLayout.modalBackground != null)
        {
            net.wargaming.controls.HelpLayout.modalBackground._width = Stage.width;
            net.wargaming.controls.HelpLayout.modalBackground._height = Stage.height;
            net.wargaming.controls.HelpLayout.modalBackground.tabEnabled = false;
            net.wargaming.controls.HelpLayout.modalBackground.useHandCursor = false;
            net.wargaming.controls.HelpLayout.modalBackground.onRelease = function ()
            {
            };
        } // end if
    } // End of the function
    static function destroy(helpLayout)
    {
        if (helpLayout != null)
        {
            gfx.managers.PopUpManager.destroyPopUp(helpLayout);
        } // end if
    } // End of the function
    static function destroyBackground()
    {
        if (net.wargaming.controls.HelpLayout.modalBackground != null)
        {
            net.wargaming.controls.HelpLayout.modalBackground.removeMovieClip();
            modalBackground = null;
        } // end if
    } // End of the function
    function configUI()
    {
        super.configUI();
    } // End of the function
    function draw()
    {
        _xscale = _yscale = 100;
        border._width = _borderWidth;
        border._height = _borderHeight;
        this.setConnectorPosition();
        this.setTextFieldPosition();
        super.draw();
    } // End of the function
    function setConnectorPosition()
    {
        if (connector == null)
        {
            return;
        } // end if
        connector._height = _connectorLength;
        switch (_direction)
        {
            case "T":
            {
                connector._rotation = 180;
                connector._x = _borderWidth >> 1;
                connector._y = 0;
                break;
            } 
            case "R":
            {
                connector._rotation = -90;
                connector._x = _borderWidth;
                connector._y = (_borderHeight >> 1) - (connector._height >> 1);
                break;
            } 
            case "B":
            {
                connector._x = _borderWidth >> 1;
                connector._y = _borderHeight;
                break;
            } 
            case "L":
            {
                connector._rotation = 90;
                connector._x = 0;
                connector._y = (_borderHeight >> 1) - (connector._height >> 1);
                break;
            } 
        } // End of switch
    } // End of the function
    function setTextFieldPosition()
    {
        if (textField == null)
        {
            return;
        } // end if
        textField.wordWrap = true;
        var _loc2 = textField.getNewTextFormat();
        switch (_direction)
        {
            case "T":
            {
                textField.autoSize = "center";
                _loc2.align = "center";
                textField.text = _text;
                textField._x = (_borderWidth >> 1) - (textField._width >> 1);
                textField._y = -(connector._height + textField.textHeight + 2);
                break;
            } 
            case "R":
            {
                textField.autoSize = "left";
                _loc2.align = "left";
                textField.text = _text;
                textField._x = _borderWidth + connector._width;
                textField._y = (_borderHeight >> 1) - (textField.textHeight >> 1) - 4;
                break;
            } 
            case "B":
            {
                textField.autoSize = "center";
                _loc2.align = "center";
                textField.text = _text;
                textField._x = (_borderWidth >> 1) - (textField._width >> 1);
                textField._y = _borderHeight + connector._height + 2;
                break;
            } 
            case "L":
            {
                textField.autoSize = "right";
                _loc2.align = "right";
                textField.text = _text;
                textField._x = -(connector._width + textField._width);
                textField._y = (_borderHeight >> 1) - (textField.textHeight >> 1) - 4;
                break;
            } 
        } // End of switch
        textField.setTextFormat(_loc2);
    } // End of the function
    var _text = "";
    var _direction = "T";
    var _borderWidth = 256;
    var _borderHeight = 256;
    var _connectorLength = 12;
    static var hlMainSource = "HelpLayout";
    static var hlBorderSource = "HelpLayoutBorder";
    static var hlConnectorSource = "HelpLayoutConnector";
} // End of Class
