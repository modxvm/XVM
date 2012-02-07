class net.wargaming.managers.ToolTipManager
{
    static var tooltip_mc;
    function ToolTipManager()
    {
    } // End of the function
    static function initialize()
    {
        initialized = true;
        var _loc1 = new Object();
        var hideToolTipFunction = function (args)
        {
            net.wargaming.managers.ToolTipManager.hide();
        };
        _loc1.onMouseDown = hideToolTipFunction;
        _loc1.onMouseWheel = hideToolTipFunction;
        _loc1.onKeyDown = function ()
        {
            if (Key.getCode() != 17)
            {
                hideToolTipFunction();
            } // end if
        };
        Mouse.addListener(_loc1);
        Key.addListener(_loc1);
    } // End of the function
    static function show(string, initProps)
    {
        if (!net.wargaming.managers.ToolTipManager.initialized)
        {
            net.wargaming.managers.ToolTipManager.initialize();
        } // end if
        net.wargaming.managers.ToolTipManager.hide();
        if (!string || !_root.g_cursorVisible)
        {
            return;
        } // end if
        tooltip_mc = gfx.managers.PopUpManager.createPopUp(_root, "ToolTip", initProps);
        if (net.wargaming.managers.ToolTipManager.tooltip_mc)
        {
            net.wargaming.managers.ToolTipManager.tooltip_mc.show(string, initProps);
        } // end if
    } // End of the function
    static function __getTags(block_type, format_type)
    {
        return ([net.wargaming.managers.ToolTipManager.BLOCK_TAGS_MAP[block_type][format_type][0] || "", net.wargaming.managers.ToolTipManager.BLOCK_TAGS_MAP[block_type][format_type][1] || ""]);
    } // End of the function
    static function __getFormattedText(text, block_type, format_type)
    {
        var _loc1 = net.wargaming.managers.ToolTipManager.__getTags(block_type, format_type || "INFO");
        return (_loc1[0] + text + _loc1[1] + "\n<font size=\'1\' > </font>\n");
    } // End of the function
    static function __getToolTipFromText(string, props)
    {
        var _loc8 = "";
        for (var _loc9 in net.wargaming.managers.ToolTipManager.BLOCK_ORDER)
        {
            var _loc2 = {open: "{" + net.wargaming.managers.ToolTipManager.BLOCK_ORDER[_loc9] + "}", close: "{/" + net.wargaming.managers.ToolTipManager.BLOCK_ORDER[_loc9] + "}"};
            var _loc1 = {start: string.indexOf(_loc2.open), end: string.indexOf(_loc2.close)};
            if (_loc1.start != undefined && _loc1.end != undefined && _loc1.start != -1 && _loc1.end != -1)
            {
                _loc1.start = _loc1.start + _loc2.open.length;
                _loc8 = _loc8 + net.wargaming.managers.ToolTipManager.__getFormattedText(string.substr(_loc1.start, _loc1.end - _loc1.start), net.wargaming.managers.ToolTipManager.BLOCK_ORDER[_loc9], props.type);
            } // end if
        } // end of for...in
        return (_loc8);
    } // End of the function
    static function __getToolTipFromKey(key, props)
    {
        var _loc1 = "";
        var _loc7 = key + "/header";
        var _loc6 = key + "/body";
        var _loc5 = key + "/note";
        var _loc3 = net.wargaming.managers.ToolTipManager.converter.convert(_loc7);
        var _loc4 = net.wargaming.managers.ToolTipManager.converter.convert(_loc6);
        var _loc2 = net.wargaming.managers.ToolTipManager.converter.convert(_loc5);
        if (_loc3 != undefined && _loc3.length != 0 && _loc3 != _loc7)
        {
            _loc1 = _loc1 + net.wargaming.managers.ToolTipManager.__getFormattedText(_loc3, "HEADER", props.type);
        } // end if
        if (_loc4 != undefined && _loc4.length != 0 && _loc4 != _loc6)
        {
            _loc1 = _loc1 + net.wargaming.managers.ToolTipManager.__getFormattedText(_loc4, "BODY", props.type);
        } // end if
        if (_loc2 != undefined && _loc2.length != 0 && _loc2 != _loc5)
        {
            _loc1 = _loc1 + net.wargaming.managers.ToolTipManager.__getFormattedText(_loc2, "NOTE", props.type);
        } // end if
        return (_loc1);
    } // End of the function
    static function showComplex(str, props)
    {
        net.wargaming.managers.ToolTipManager.show(str.substr(0, 1) == "#" ? (net.wargaming.managers.ToolTipManager.__getToolTipFromKey(str, props)) : (net.wargaming.managers.ToolTipManager.__getToolTipFromText(str, props)), props);
    } // End of the function
    static function hide()
    {
        if (net.wargaming.managers.ToolTipManager.tooltip_mc != null)
        {
            net.wargaming.managers.ToolTipManager.tooltip_mc.hide();
            net.wargaming.managers.ToolTipManager.tooltip_mc.removeMovieClip();
            delete net.wargaming.managers.ToolTipManager.tooltip_mc;
        } // end if
    } // End of the function
    static function setContent(content)
    {
        if (net.wargaming.managers.ToolTipManager.tooltip_mc != null)
        {
            net.wargaming.managers.ToolTipManager.tooltip_mc.content = content;
        } // end if
    } // End of the function
    static var initialized = false;
    static var converter = new net.wargaming.managers.XMLKeyConverter();
    static var BLOCK_ORDER = ["NOTE", "BODY", "HEADER"];
    static var BLOCK_TAGS_MAP = {HEADER: {INFO: ["<font color=\'#FFCB65\'><b>", "</b></font>"], WARNING: ["<font color=\'#9b0202\'><b>", "</b></font>"]}, BODY: {}, NOTE: {INFO: ["<font color=\'#777777\'>", "</font>"], WARNING: ["<font color=\'#777777\'>", "</font>"]}};
} // End of Class
