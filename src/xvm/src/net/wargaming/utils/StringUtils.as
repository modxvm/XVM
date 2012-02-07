class net.wargaming.utils.StringUtils
{
    function StringUtils()
    {
    } // End of the function
    static function init()
    {
        if (net.wargaming.utils.StringUtils.__init)
        {
            return;
        } // end if
        __init = true;
        net.wargaming.utils.StringUtils.__mapping[0] = {command: "NONE", to_show: ""};
		/* fix decompiler errors (sirmax2)
        net.wargaming.utils.StringUtils.__mapping[Mouse.LEFT] = {command: "LEFTMOUSE", to_show: "#controls:mouse/key_left"};
        net.wargaming.utils.StringUtils.__mapping[Mouse.MIDDLE] = {command: "MOUSE2", to_show: "#controls:mouse/key_middle"};
		net.wargaming.utils.StringUtils.__mapping[Mouse.RIGHT] = {command: "MOUSE1", to_show: "#controls:mouse/key_right"};
		*/
		net.wargaming.utils.StringUtils.__mapping[5] = {command: "MOUSE4", to_show: "#controls:mouse/key_4"};
        net.wargaming.utils.StringUtils.__mapping[6] = {command: "MOUSE5", to_show: "#controls:mouse/key_5"};
        net.wargaming.utils.StringUtils.__mapping[7] = {command: "MOUSE6", to_show: "#controls:mouse/key_6"};
        net.wargaming.utils.StringUtils.__mapping[8] = {command: "MOUSE7", to_show: "#controls:mouse/key_7"};
        net.wargaming.utils.StringUtils.__mapping[27] = {command: "ESCAPE", to_show: "#controls:keyboard/key_escape"};
        net.wargaming.utils.StringUtils.__mapping[18] = {command: "LALT", to_show: "#controls:keyboard/key_alt"};
        net.wargaming.utils.StringUtils.__mapping[9] = {command: "TAB", to_show: "#controls:keyboard/key_tab"};
        net.wargaming.utils.StringUtils.__mapping[20] = {command: "CAPSLOCK", to_show: "#controls:keyboard/key_capslock"};
        net.wargaming.utils.StringUtils.__mapping[16] = {command: "LSHIFT", to_show: "#controls:keyboard/key_shift"};
        net.wargaming.utils.StringUtils.__mapping[8] = {command: "BACKSPACE", to_show: "#controls:keyboard/key_bacjspace"};
        net.wargaming.utils.StringUtils.__mapping[32] = {command: "SPACE", to_show: "#controls:keyboard/key_space"};
        net.wargaming.utils.StringUtils.__mapping[17] = {command: "LCONTROL", to_show: "#controls:keyboard/key_ctrl"};
        net.wargaming.utils.StringUtils.__mapping[38] = {command: "UPARROW", to_show: "#controls:keyboard/key_uparrow"};
        net.wargaming.utils.StringUtils.__mapping[40] = {command: "DOWNARROW", to_show: "#controls:keyboard/key_downarrow"};
        net.wargaming.utils.StringUtils.__mapping[39] = {command: "RIGHTARROW", to_show: "#controls:keyboard/key_rightarrow"};
        net.wargaming.utils.StringUtils.__mapping[37] = {command: "LEFTARROW", to_show: "#controls:keyboard/key_leftarrow"};
        net.wargaming.utils.StringUtils.__mapping[35] = {command: "END", to_show: "#controls:keyboard/key_end"};
        net.wargaming.utils.StringUtils.__mapping[36] = {command: "HOME", to_show: "#controls:keyboard/key_home"};
        net.wargaming.utils.StringUtils.__mapping[46] = {command: "DELETE", to_show: "#controls:keyboard/key_delete"};
        net.wargaming.utils.StringUtils.__mapping[45] = {command: "INSERT", to_show: "#controls:keyboard/key_insert"};
        net.wargaming.utils.StringUtils.__mapping[33] = {command: "PGUP", to_show: "#controls:keyboard/key_pgup"};
        net.wargaming.utils.StringUtils.__mapping[34] = {command: "PGDN", to_show: "#controls:keyboard/key_pgdn"};
        for (var _loc1 = 96; _loc1 < 106; ++_loc1)
        {
            net.wargaming.utils.StringUtils.__mapping[_loc1] = {command: "NUMPAD" + (_loc1 - 96), to_show: "Numpad " + (_loc1 - 96)};
        } // end of for
        net.wargaming.utils.StringUtils.__mapping[111] = {command: "NUMPADSLASH", to_show: "Numpad divide"};
        net.wargaming.utils.StringUtils.__mapping[109] = {command: "NUMPADMINUS", to_show: "Numpad minus"};
        net.wargaming.utils.StringUtils.__mapping[106] = {command: "NUMPADSTAR", to_show: "Numpad star"};
        net.wargaming.utils.StringUtils.__mapping[13] = {command: "NUMPADENTER", to_show: "Numpad enter"};
        net.wargaming.utils.StringUtils.__mapping[110] = {command: "NUMPADPERIOD", to_show: "Numpad comma"};
        net.wargaming.utils.StringUtils.__mapping[107] = {command: "ADD", to_show: "Numpad add"};
        for (var _loc1 = 112; _loc1 < 124; ++_loc1)
        {
            net.wargaming.utils.StringUtils.__mapping[_loc1] = {command: "F" + (_loc1 - 111), to_show: "F" + (_loc1 - 111)};
        } // end of for
        net.wargaming.utils.StringUtils.__mapping[219] = {command: "LBRACKET", to_show: "["};
        net.wargaming.utils.StringUtils.__mapping[221] = {command: "RBRACKET", to_show: "]"};
        net.wargaming.utils.StringUtils.__mapping[186] = {command: "SEMICOLON", to_show: ";"};
        net.wargaming.utils.StringUtils.__mapping[222] = {command: "APOSTROPHE", to_show: "\'"};
        net.wargaming.utils.StringUtils.__mapping[220] = {command: "BACKSLASH", to_show: "\\"};
        net.wargaming.utils.StringUtils.__mapping[191] = {command: "SLASH", to_show: "/"};
        net.wargaming.utils.StringUtils.__mapping[190] = {command: "STOP", to_show: "."};
        net.wargaming.utils.StringUtils.__mapping[188] = {command: "COMMA", to_show: ","};
        net.wargaming.utils.StringUtils.__mapping[189] = {command: "MINUS", to_show: "-"};
        net.wargaming.utils.StringUtils.__mapping[187] = {command: "EQUALS", to_show: "="};
    } // End of the function
    static function putWrappedText(str, textFields)
    {
        var _loc4 = str.split(" ");
        var _loc3 = 0;
        for (var _loc1 = 0; _loc1 < textFields.length; ++_loc1)
        {
            textFields[_loc1].text = _loc4[_loc3++];
            var _loc6 = textFields[_loc1].getLineMetrics(0).height;
            var _loc5 = Math.floor(textFields[_loc1]._height / _loc6);
            while (textFields[_loc1].numLines <= _loc5)
            {
                if (_loc4[_loc3] == undefined)
                {
                    return;
                } // end if
                textFields[_loc1].text = textFields[_loc1].text + (" " + _loc4[_loc3++]);
            } // end while
            --_loc3;
        } // end of for
    } // End of the function
    static function keyToString(key)
    {
        net.wargaming.utils.StringUtils.init();
        return (net.wargaming.utils.StringUtils.__mapping[key].command || String(chr(key)).toUpperCase());
    } // End of the function
    static function stringToKey(key_string)
    {
        net.wargaming.utils.StringUtils.init();
        for (var _loc2 in net.wargaming.utils.StringUtils.__mapping)
        {
            if (net.wargaming.utils.StringUtils.__mapping[_loc2].command == key_string)
            {
                return (_loc2);
            } // end if
        } // end of for...in
        return (ord(key_string));
    } // End of the function
    static function keyToUserString(key)
    {
        net.wargaming.utils.StringUtils.init();
        return (net.wargaming.utils.StringUtils.__mapping[key].to_show || String(chr(key)).toUpperCase());
    } // End of the function
    static function searchAndReplace(holder, searchfor, replacement)
    {
        var _loc1 = holder.split(searchfor);
        holder = _loc1.join(replacement);
        return (holder);
    } // End of the function
    static function stripWhitespace(text, options)
    {
        var _loc1 = text;
        if (options == undefined || options.indexOf("t", 0) > -1)
        {
            _loc1 = _loc1.split("\t").join(" ");
        } // end if
        if (options == undefined || options.indexOf("r", 0) > -1)
        {
            _loc1 = _loc1.split("\r").join(" ");
        } // end if
        if (options == undefined || options.indexOf("n", 0) > -1)
        {
            _loc1 = _loc1.split("\n").join(" ");
        } // end if
        if (options == undefined || options.indexOf("s", 0) > -1)
        {
            _loc1 = _loc1.split(" ");
            for (var _loc3 in _loc1)
            {
                if (_loc1[_loc3].length == 0)
                {
                    _loc1.splice(_loc3, 1);
                } // end if
            } // end of for...in
            _loc1 = _loc1.join(" ");
        } // end if
        return (_loc1);
    } // End of the function
    static var __mapping = new Object();
    static var __init = false;
} // End of Class
