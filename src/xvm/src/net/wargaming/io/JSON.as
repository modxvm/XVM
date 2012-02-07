class net.wargaming.io.JSON
{
    function JSON()
    {
    } // End of the function
    static function stringify(arg)
    {
        var _loc3;
        var _loc2;
        var _loc6;
        var _loc1 = "";
        var _loc4;
        switch (typeof(arg))
        {
            case "object":
            {
                if (arg)
                {
                    if (arg instanceof Array)
                    {
                        for (var _loc2 = 0; _loc2 < arg.length; ++_loc2)
                        {
                            _loc4 = net.wargaming.io.JSON.stringify(arg[_loc2]);
                            if (_loc1)
                            {
                                _loc1 = _loc1 + ",";
                            } // end if
                            _loc1 = _loc1 + _loc4;
                        } // end of for
                        return ("[" + _loc1 + "]");
                    }
                    else if (typeof(arg.toString) != "undefined")
                    {
                        for (var _loc2 in arg)
                        {
                            _loc4 = arg[_loc2];
                            if (typeof(_loc4) != "undefined" && typeof(_loc4) != "function")
                            {
                                _loc4 = net.wargaming.io.JSON.stringify(_loc4);
                                if (_loc1)
                                {
                                    _loc1 = _loc1 + ",";
                                } // end if
                                _loc1 = _loc1 + (net.wargaming.io.JSON.stringify(_loc2) + ":" + _loc4);
                            } // end if
                        } // end of for...in
                        return ("{" + _loc1 + "}");
                    } // end if
                } // end else if
                return ("null");
            } 
            case "number":
            {
                return (isFinite(arg) ? (String(arg)) : ("null"));
            } 
            case "string":
            {
                _loc6 = arg.length;
                _loc1 = "\"";
                for (var _loc2 = 0; _loc2 < _loc6; _loc2 = _loc2 + 1)
                {
                    _loc3 = arg.charAt(_loc2);
                    if (_loc3 >= " ")
                    {
                        if (_loc3 == "\\" || _loc3 == "\"")
                        {
                            _loc1 = _loc1 + "\\";
                        } // end if
                        _loc1 = _loc1 + _loc3;
                        continue;
                    } // end if
                    switch (_loc3)
                    {
                        case "\b":
                        {
                            _loc1 = _loc1 + "\\b";
                            break;
                        } 
                        case "\f":
                        {
                            _loc1 = _loc1 + "\\f";
                            break;
                        } 
                        case "\n":
                        {
                            _loc1 = _loc1 + "\\n";
                            break;
                        } 
                        case "\r":
                        {
                            _loc1 = _loc1 + "\\r";
                            break;
                        } 
                        case "\t":
                        {
                            _loc1 = _loc1 + "\\t";
                            break;
                        } 
                        default:
                        {
                            _loc3 = _loc3.charCodeAt();
                            _loc1 = _loc1 + ("\\u00" + Math.floor(_loc3 / 16).toString(16) + (_loc3 % 16).toString(16));
                        } 
                    } // End of switch
                } // end of for
                return (_loc1 + "\"");
            } 
            case "boolean":
            {
                return (String(arg));
            } 
        } // End of switch
        return ("null");
    } // End of the function
    static function parse(text)
    {
        var at = 0;
        var ch = " ";
        var _value;
        var _error = function (m)
        {
            throw {name: "JSONError", message: m, at: at - 1, text: text};
        };
        var _next = function ()
        {
            ch = text.charAt(at);
            at = at + 1;
            return (ch);
        };
        var _white = function ()
        {
            while (ch)
            {
                if (ch <= " ")
                {
                    _next();
                    continue;
                } // end if
                if (ch == "/")
                {
                    switch (_next())
                    {
                        case "/":
                        {
                            while (_next() && ch != "\n" && ch != "\r")
                            {
                            } // end while
                            break;
                        } 
                        case "*":
                        {
                            _next();
                            if (ch)
                            {
                                if (ch == "*")
                                {
                                    if (_next() == "/")
                                    {
                                        _next();
                                    } // end if
                                }
                                else
                                {
                                    _next();
                                } // end else if
                            }
                            else
                            {
                                _error("Unterminated comment");
                            } // end else if
                            
                            break;
                        } 
                        default:
                        {
                            _error("Syntax error");
                        } 
                    } // End of switch
                    continue;
                } // end if
                break;
            } // end while
        };
        var _string = function ()
        {
            var _loc4;
            var _loc1 = "";
            var _loc3;
            var _loc2;
            var _loc5 = false;
            if (ch == "\"")
            {
                while (_next())
                {
                    if (ch == "\"")
                    {
                        _next();
                        return (_loc1);
                        continue;
                    } // end if
                    if (ch == "\\")
                    {
                        switch (_next())
                        {
                            case "b":
                            {
                                _loc1 = _loc1 + "\b";
                                break;
                            } 
                            case "f":
                            {
                                _loc1 = _loc1 + "\f";
                                break;
                            } 
                            case "n":
                            {
                                _loc1 = _loc1 + "\n";
                                break;
                            } 
                            case "r":
                            {
                                _loc1 = _loc1 + "\r";
                                break;
                            } 
                            case "t":
                            {
                                _loc1 = _loc1 + "\t";
                                break;
                            } 
                            case "u":
                            {
                                _loc2 = 0;
                                for (var _loc4 = 0; _loc4 < 4; _loc4 = _loc4 + 1)
                                {
                                    _loc3 = parseInt(_next(), 16);
                                    if (!isFinite(_loc3))
                                    {
                                        _loc5 = true;
                                        break;
                                    } // end if
                                    _loc2 = _loc2 * 16 + _loc3;
                                } // end of for
                                if (_loc5)
                                {
                                    _loc5 = false;
                                    break;
                                } // end if
                                _loc1 = _loc1 + String.fromCharCode(_loc2);
                                break;
                            } 
                            default:
                            {
                                _loc1 = _loc1 + ch;
                            } 
                        } // End of switch
                        continue;
                    } // end if
                    _loc1 = _loc1 + ch;
                } // end while
            } // end if
            _error("Bad string");
        };
        var _array = function ()
        {
            var _loc1 = [];
            if (ch == "[")
            {
                _next();
                _white();
                if (ch == "]")
                {
                    _next();
                    return (_loc1);
                } // end if
                while (ch)
                {
                    _loc1.push(_value());
                    _white();
                    if (ch == "]")
                    {
                        _next();
                        return (_loc1);
                    }
                    else if (ch != ",")
                    {
                        break;
                    } // end else if
                    _next();
                    _white();
                } // end while
            } // end if
            _error("Bad array");
        };
        var _object = function ()
        {
            var _loc2;
            var _loc1 = {};
            if (ch == "{")
            {
                _next();
                _white();
                if (ch == "}")
                {
                    _next();
                    return (_loc1);
                } // end if
                while (ch)
                {
                    _loc2 = _string();
                    _white();
                    if (ch != ":")
                    {
                        break;
                    } // end if
                    _next();
                    _loc1[_loc2] = _value();
                    _white();
                    if (ch == "}")
                    {
                        _next();
                        return (_loc1);
                    }
                    else if (ch != ",")
                    {
                        break;
                    } // end else if
                    _next();
                    _white();
                } // end while
            } // end if
            _error("Bad object");
        };
        var _number = function ()
        {
            var _loc1 = "";
            var _loc2;
            if (ch == "-")
            {
                _loc1 = "-";
                _next();
            } // end if
            while (ch >= "0" && ch <= "9")
            {
                _loc1 = _loc1 + ch;
                _next();
            } // end while
            if (ch == ".")
            {
                for (var _loc1 = _loc1 + "."; _next() && ch >= "0" && ch <= "9"; _loc1 = _loc1 + ch)
                {
                } // end of for
            } // end if
            _loc2 = 1 * _loc1;
            if (!isFinite(_loc2))
            {
                _error("Bad number");
            }
            else
            {
                return (_loc2);
            } // end else if
        };
        var _word = function ()
        {
            switch (ch)
            {
                case "t":
                {
                    if (_next() == "r" && _next() == "u" && _next() == "e")
                    {
                        _next();
                        return (true);
                    } // end if
                    break;
                } 
                case "f":
                {
                    if (_next() == "a" && _next() == "l" && _next() == "s" && _next() == "e")
                    {
                        _next();
                        return (false);
                    } // end if
                    break;
                } 
                case "n":
                {
                    if (_next() == "u" && _next() == "l" && _next() == "l")
                    {
                        _next();
                        return (null);
                    } // end if
                    break;
                } 
            } // End of switch
            _error("Syntax error");
        };
        _value = function ()
        {
            _white();
            switch (ch)
            {
                case "{":
                {
                    return (_object());
                } 
                case "[":
                {
                    return (_array());
                } 
                case "\"":
                {
                    return (_string());
                } 
                case "-":
                {
                    return (_number());
                } 
            } // End of switch
            return (ch >= "0" && ch <= "9" ? (_number()) : (_word()));
        };
        return (_value());
    } // End of the function
} // End of Class
