/*
Copyright (c) 2005 JSON.org
Copyright (c) 2013 m.schedriviy@gmail.com (JSONx extension)

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
 JSONx extensions:
    1. Comments:
        Block: /* *_/
        Line: //
    2. References:
        Internal: "obj": ${"path.to.object"}
        External: "obj": ${"filename":"path.to.object"}
        Root object: "obj": ${"."}
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

*/

package com.xvm
{
	import flashx.textLayout.factory.StringTextLineFactory;
	
	import mx.messaging.channels.StreamingAMFChannel;

public class JSONx {

  private static var maxDepth:int = 0;
  private static var curDepth:int = 0;
  public static function stringifyDepth(arg:*, depth:int):String {
    maxDepth = depth;
    curDepth = 0;
    var s:String = stringify(arg);
    maxDepth = 0;
    curDepth = 0;
    return s;
  }

  public static function stringify(arg:*, indent:String = null, compact:Boolean = false, sort:Function = undefined, nodeName:String = ""):String {

  var c:String, i:*, s:String = '', v:String;

  if (!indent)
    indent = "";

  switch (typeof arg) {
  case 'movieclip':
  case 'object':
      if (maxDepth && maxDepth > 0 && curDepth >= maxDepth)
        return stringify(arg.toString(), "", true);

      curDepth++;
      if (arg) {
          if (arg is Array) {
              var len:int = arg.length;
              for (i = 0; i < len; ++i) {
                  v = stringify(arg[i], compact ? "" : indent + "  ", compact, sort, nodeName);
                  if (s) {
                      s += compact ? ',' : ',\n';
                  }
                  s += compact ? v : indent + "  " + v;
              }
              curDepth--;
              return compact ? '[' + s + ']' : '[\n' + s + '\n' + indent + ']';
          } else if (typeof arg.toString != 'undefined') {
			  var items:Array = [];
			  for (i in arg)
				  items.push(nodeName + i);
			  if (sort != null)
					items.sort(sort);
			  else
			  		items.sort();
			  for (var ii:* in items) {
				  var item:String = items[ii].replace(/^\.*/, "");
                  v = arg[item];
                  if (typeof v != 'undefined' && typeof v != 'function') {
                      v = stringify(v, compact ? "" : indent + "  ", compact, sort, nodeName + ".");
                      if (s) {
                          s += compact ? ',' : ',\n';
                      }
                      s += compact
						  ? stringify(i, "", true) + ':' + v
						  : indent + "  " + stringify(i, indent + "  ") + ': ' + v;
                  }
              }
              curDepth--;
			  var tmpRes:String = '{' +
                (compact ? s + '}' : '\n' + s + '\n' + indent + '}');
			  var compactRes:String = tmpRes.replace(/^\s*/gm, "").replace(/\n/g, " ");
			  return compactRes.length < 110 ? compactRes : tmpRes;
          }
      }
      curDepth--;
      return 'null';
  case 'number':
      return isFinite(arg) ? String(arg) : 'null';
  case 'string':
      var l:int = arg.length;
      s = '"';
      for (i = 0; i < l; i += 1) {
          c = arg.charAt(i);
          if (c >= ' ') {
              if (c == '\\' || c == '"') {
                  s += '\\';
              }
              if (c == '%')
                  s += '\\u0025';
              else
                  s += c;
          } else {
              switch (c) {
                  case '\b':
                      s += '\\b';
                      break;
                  case '\f':
                      s += '\\f';
                      break;
                  case '\n':
                      s += '\\n';
                      break;
                  case '\r':
                      s += '\\r';
                      break;
                  case '\t':
                      s += '\\t';
                      break;
                  default:
                      var cc:int = c.charCodeAt();
                      s += '\\u00' + Math.floor(cc / 16).toString(16) +
                          (cc % 16).toString(16);
              }
          }
      }
      return s + '"';
  case 'boolean':
      return String(arg);
  case 'null':
      return 'null';
  default:
      //if (maxDepth && maxDepth > 0)
      //    Logger.add("JSON> " + (typeof arg));
      return 'null';
  }
}

  public static function parse(text:String):Object {
    if (!text || text == "")
        return null;
    var ta: Array = text.split(''); // charAt is much slower in Flash then array
    var talen:int = ta.length;
    var at:int = 0;
    var ch:String = ' ';
    var _value:Function;

    var _error:Function = function (m:String):void {
        throw {
            name: 'JSONxError',
            message: m,
            at: at - 1,
            text: text
        };
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
        var s:String = '';
        var outer:Boolean = false;

        if (ch == '"') {
            while (_next()) {
                if (ch == '"') {
                    _next();
                    return s;
                } else if (ch == '\\') {
                    switch (_next()) {
                    case 'b':
                        s += '\b';
                        break;
                    case 'f':
                        s += '\f';
                        break;
                    case 'n':
                        s += '\n';
                        break;
                    case 'r':
                        s += '\r';
                        break;
                    case 't':
                        s += '\t';
                        break;
                    case 'u':
                        var u:int = 0;
                        for (var i:int = 0; i < 4; i += 1) {
                            var t:int = parseInt(_next(), 16);
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
                        s += String.fromCharCode(u);
                        break;
                    default:
                        s += ch;
                    }
                } else {
                    s += ch;
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
        _next();
        if (ch == '{') {
            _next();
            _white();
            if (ch == '}') {
                _next();
                return null;
            }
            var f:String, p:String;
            while (ch) {
                p = _string();
                _white();
                if (ch == ':') {
                    _next();
                    f = p;
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
        var n:String = '';

        if (ch == '-') {
            n = '-';
            _next();
        }
        while (ch >= '0' && ch <= '9') {
            n += ch;
            _next();
        }
        if (ch == '.') {
            n += '.';
            while (_next() && ch >= '0' && ch <= '9') {
                n += ch;
            }
        }
        //v = +n;
        var v:Number = 1 * Number(n);
        if (!isFinite(v)) {
            _error("Bad number");
            return NaN;
        }

        return v;
    }

    var _word:Function = function():* {
        switch (ch) {
            case 't':
                if (_next() == 'r' && _next() == 'u' && _next() == 'e') {
                    _next();
                    return true;
                }
                break;
            case 'f':
                if (_next() == 'a' && _next() == 'l' && _next() == 's' &&
                        _next() == 'e') {
                    _next();
                    return false;
                }
                break;
            case 'n':
                if (_next() == 'u' && _next() == 'l' && _next() == 'l') {
                    _next();
                    return null;
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
