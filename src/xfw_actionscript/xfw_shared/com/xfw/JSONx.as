/*
Copyright (c) 2005 JSON.org
Copyright (c) 2013 max(at)modxvm.com (JSONx extension)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The Software shall be used for Good, not Evil.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

/*
ported to Actionscript May 2005 by Trannie Carter <tranniec@designvox.com>, wwww.designvox.com
USAGE:
    try {
        var o:Object = JSON.parse(jsonStr);
        var s:String = JSON.stringify(obj);
    } catch(ex) {
        trace(ex.name + ":" + ex.message + ":" + ex.at + ":" + ex.text);
    }

added JSONx extensions 2012-2013 by Maxim Schedriviy "max(at)modxvm.com", https://modxvm.com
    1. Comments:
        Block: /* *_/
        Line: //
    2. References:
        Internal: "obj": ${"path.to.object"}
        External: "obj": ${"filename":"path.to.object"}
        Root object: "obj": ${"."}

        Full format: "obj": { "$ref": { "file": "<filename>", "path":"<path.to.object." } }
        Override referenced values (full format only):
            "obj": {
                "$ref": { "file": "<filename>", "path":"<path.to.object." },
                "name": <value>
            }

ported to AS3 2013-08-23 by Maxim Schedriviy "max(at)modxvm.com", https://modxvm.com
*/

package com.xfw
{
    import com.xfw.*;
    import flash.utils.*;

    public class JSONx
    {
        public static function stringifyDepth(arg:*, depth:int = 1):String
        {
            return (new JSONx(depth))._stringify(arg);
        }

        public static function stringify(arg:*, indent:String = '', compact:Boolean = false):String
        {
            return (new JSONx())._stringify(arg, indent, compact);
        }

        public static function parse(text:String):Object
        {
            return (new JSONx())._parse(text);
        }

        // PRIVATE

        private var maxDepth:int;
        private var curDepth:int;

        function JSONx(depth:int = 0)
        {
            maxDepth = depth;
            curDepth = 0;
        }

        private function _stringify(arg:*, indent:String = '', compact:Boolean = false):String
        {
            var result:Array = [], c:String, n:String;
            var len:int, i:int, cc:int;
            var ac:XML;

            //Logger.add(indent + typeof arg);

            if (arg == null)
                return 'null';

            switch (typeof arg)
            {
                case 'object':
                    if (arg.toString == undefined)
                        return 'null';

                    if (maxDepth > 0)
                    {
                        if (curDepth >= maxDepth)
                            return _stringify(arg.toString(), '', compact);
                    }

                    curDepth++;
                    try
                    {
                        if (arg is Array)
                        {
                            len = arg.length;
                            for (i = 0; i < len; ++i) {
                                c = _stringify(arg[i], compact ? '' : indent + '  ', compact);
                                if (result.length > 0)
                                    result.push(compact ? ',' : ',\n');
                                result.push(compact ? c : indent + '  ' + c);
                            }
                            return compact ? '[' + result.join("") + ']' : '[\n' + result.join("") + '\n' + indent + ']';
                        }
                        else
                        {
                            for (n in arg)
                            {
                                if (result.length > 0)
                                    result.push(compact ? ',' : ',\n');
                                result.push(_stringifyVar(arg, n, indent, compact));
                            }
                            var descr:XML = describeType(arg);
                            var xml:XMLList = descr.accessor;
                            for each (ac in xml)
                            {
                                if (ac.@access != "readonly")
                                {
                                    if (ac.@access != "readwrite")
                                        continue;
                                }
                                if (result.length > 0)
                                    result.push(compact ? ',' : ',\n');
                                result.push(_stringifyVar(arg, ac.@name, indent, compact));
                            }
                            xml = descr.variable;
                            for each (ac in xml)
                            {
                                if (result.length > 0)
                                    result.push(compact ? ',' : ',\n');
                                result.push(_stringifyVar(arg, ac.@name, indent, compact));
                            }
                            if (compact)
                                return '{' + result.join("") + '}';
                            else
                            {
                                var cn:String = getQualifiedClassName(arg);
                                return '{' + (cn != 'Object' ? ' // ' + cn : '') + '\n' + result.join("") + '\n' + indent + '}';
                            }
                        }
                    }
                    finally
                    {
                        curDepth--;
                    }
                    return 'null';

                case 'number':
                    return isFinite(arg) ? String(arg) : 'null';

                case 'boolean':
                    return String(arg);

                case 'string':
                    result = ['"'];
                    // charAt is much slower in Scaleform then array
                    if (arg as String)
                    {
                        var ca:Vector.<String> = Vector.<String>((arg as String).split(''));
                        len = ca.length;
                        for (i = 0; i < len; i += 1)
                        {
                            c = ca[i];
                            if (c >= ' ') {
                                if (c == '\\' || c == '"')
                                    result.push('\\');
                                result.push(c);
                            }
                            else
                            {
                                switch (c) {
                                    case '\b':
                                        result.push('\\b');
                                        break;
                                    case '\f':
                                        result.push('\\f');
                                        break;
                                    case '\n':
                                        result.push('\\n');
                                        break;
                                    case '\r':
                                        result.push('\\r');
                                        break;
                                    case '\t':
                                        result.push('\\t');
                                        break;
                                    default:
                                        cc = c.charCodeAt();
                                        result.push('\\u00' + Math.floor(cc / 16).toString(16) + (cc % 16).toString(16));
                                }
                            }
                        }
                    }
                    return result.join("") + '"';

                case 'xml':
                    return '"' + arg.toString() + '"';

                case 'function':
                    return 'null' + (compact ? '' : ' /* [function] */');

                case 'unknown':
                    return 'null' + (compact ? '' : ' /* [unknown] ' + String(arg) + " */");

                default:
                    return 'null' + (compact ? '' : ' /* unknown type: ' + (typeof arg) + " */");
            }
        }

        private function _stringifyVar(arg:*, name:String, indent:String, compact:Boolean):String
        {
            var c:String = _stringify((arg[name] as Object), compact ? '' : indent + '  ', compact);
            return compact
                ? _stringify(name, '', true) + ':' + c
                : indent + '  ' + _stringify(name, indent + '  ', false) + ': ' + c;
        }

        private function _parse(text:String):Object
        {
            if (text == null || text == '')
                return null;
            // charAt is much slower in Scaleform then array
            var ta:Array = text.split('');
            var talen:int = ta.length;
            var at:int = 0;
            var ch:String = ' ';
            var _value:Function;

            var _error:Function = function(m:String):void {
                throw new JSONxError("PARSE_ERROR", m, at - 1, text);
            }

            var _next:Function = function():String {
                ch = (at >= talen) ? '' : ta[at];
                at++;
                return ch;
            }

            var _white:Function = function():void {
                while (ch) {
                    if (ch <= ' ') {
                        _next();
                    } else if (ch == '/') {
                        switch (_next()) {
                            case '/':
                                while (_next() && ch != '\n' && ch != '\r') {}
                                break;
                            case '*':
                                _next();
                                for (;;) {
                                    if (ch) {
                                        if (ch == '*') {
                                            if (_next() == '/') {
                                                _next();
                                                break;
                                            }
                                        } else {
                                            _next();
                                        }
                                    } else {
                                        _error("Unterminated comment");
                                    }
                                }
                                break;
                            default:
                                _error("Syntax error");
                        }
                    } else {
                        break;
                    }
                }
            }

            var _string:Function = function():String {
                var i:int, result:Array = [], t:Number, u:Number;
                var outer:Boolean = false;

                if (ch == '"') {
                    while (_next()) {
                        if (ch == '"') {
                            _next();
                            return result.join("");
                        } else if (ch == '\\') {
                            switch (_next()) {
                            case 'b':
                                result.push('\b');
                                break;
                            case 'f':
                                result.push('\f');
                                break;
                            case 'n':
                                result.push('\n');
                                break;
                            case 'r':
                                result.push('\r');
                                break;
                            case 't':
                                result.push('\t');
                                break;
                            case 'u':
                                u = 0;
                                for (i = 0; i < 4; i += 1) {
                                    t = parseInt(_next(), 16);
                                    if (!isFinite(t)) {
                                        outer = true;
                                        break;
                                    }
                                    u = u * 16 + t;
                                }
                                if(outer) {
                                    outer = false;
                                    break;
                                }
                                result.push(String.fromCharCode(u));
                                break;
                            default:
                                result.push(ch);
                            }
                        } else {
                            result.push(ch);
                        }
                    }
                }
                _error("Bad string");
                return null;
            }

            var _array:Function = function():Array {
                var a:Array = [];

                _next();
                _white();
                if (ch == ']') {
                    _next();
                    return a;
                }
                while (ch) {
                    a.push(_value());
                    _white();
                    if (ch == ']') {
                        _next();
                        return a;
                    } else if (ch != ',') {
                        break;
                    }
                    _next();
                    _white();
                }
                _error("Bad array");
                return null;
            }

            // {...}
            var _object:Function = function():Object {
                var k:String, o:Object = {};

                _next();
                _white();
                if (ch == '}') {
                    _next();
                    return o;
                }
                while (ch) {
                    k = _string();
                    _white();
                    if (ch != ':') {
                        break;
                    }
                    _next();
                    o[k] = _value();
                    _white();
                    if (ch == '}') {
                        _next();
                        return o;
                    } else if (ch != ',') {
                        break;
                    }
                    _next();
                    _white();
                }
                _error("Bad object");
                return null;
            }

            // ${...}
            var _reference:Function = function():Object {
                var f:String, p:String;

                _next();
                if (ch == '{') {
                    _next();
                    _white();
                    if (ch == '}') {
                        _next();
                        return null;
                    }
                    while (ch) {
                        p = _string();
                        _white();
                        if (ch == ':') {
                            _next();
                            f = p;
                            _white();
                            p = _string();
                            _white();
                        }
                        if (ch != '}')
                            break;
                        _next();
                        return { $ref: { file: f, path: p } };
                    }
                }
                _error("Bad reference");
                return null;
            }

            var _number:Function = function():Number {
                var result:Array = [], v:Number;

                if (ch == '-') {
                    result = ['-'];
                    _next();
                }
                while (ch >= '0' && ch <= '9') {
                    result.push(ch);
                    _next();
                }
                if (ch == '.') {
                    result.push('.');
                    while (_next() && ch >= '0' && ch <= '9') {
                        result.push(ch);
                    }
                }
                //v = +n;
                v = 1 * Number(result.join(""));
                if (!isFinite(v)) {
                    _error("Bad number");
                } else {
                    return v;
                }
                return NaN;
            }

            var _word:Function = function():* {
                switch (ch) {
                    case 't':
                        if (_next() == 'r') {
                            if (_next() == 'u') {
                                if (_next() == 'e') {
                                    _next();
                                    return true;
                                }
                            }
                        }
                        break;
                    case 'f':
                        if (_next() == 'a') {
                            if (_next() == 'l') {
                                if (_next() == 's') {
                                    if (_next() == 'e') {
                                        _next();
                                        return false;
                                    }
                                }
                            }
                        }
                        break;
                    case 'n':
                        if (_next() == 'u') {
                            if (_next() == 'l') {
                                if (_next() == 'l') {
                                    _next();
                                    return null;
                                }
                            }
                        }
                        break;
                }
                _error("Syntax error");
            }

            _value = function():* {
                _white();
                switch (ch) {
                    case '$':
                        return _reference();
                    case '{':
                        return _object();
                    case '[':
                        return _array();
                    case '"':
                        return _string();
                    case '-':
                        return _number();
                    default:
                        return ch >= '0' && ch <= '9' ? _number() : _word();
                }
            }

            return _value();
        }
    }
}
