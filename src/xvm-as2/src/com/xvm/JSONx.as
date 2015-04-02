/*
Copyright (c) 2005 JSON.org
Copyright (c) 2013 max@modxvm.com (JSONx extension)

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
        
    3. Identifiers:
        "identifier1": {} is valid
        identifier2: {} is valid
        identifier_3: {} same...
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

class com.xvm.JSONx {

  static var maxDepth: Number = undefined;
  static var curDepth: Number = undefined;
  static function stringifyDepth(arg, depth):String {
    maxDepth = depth;
    curDepth = 0;
    var s = stringify(arg);
    maxDepth = undefined;
    curDepth = undefined;
    return s;
  }

  public static function stringify(arg, indent:String, compact:Boolean):String {

  if (compact == undefined) compact = false;

  var c, i, l, s = '', v;

  if (!indent)
    indent = "";

  switch (typeof arg) {
  case 'movieclip':
  case 'object':
      if (maxDepth != null && maxDepth > 0 && curDepth >= maxDepth)
        return stringify(arg.toString(), "", compact);

      curDepth++;
      if (arg) {
          if (arg instanceof Array) {
              var len = arg.length;
              for (i = 0; i < len; ++i) {
                  v = stringify(arg[i], compact ? "" : indent + "  ", compact);
                  if (s) {
                      s += compact ? ',' : ',\n';
                  }
                  s += compact ? v : indent + "  " + v;
              }
              curDepth--;
              return compact ? '[' + s + ']' : '[\n' + s + '\n' + indent + ']';
          } else if (typeof arg.toString != 'undefined') {
              for (i in arg) {
                  v = arg[i];
                  if (typeof v != 'undefined' && typeof v != 'function') {
                      v = stringify(v, compact ? "" : indent + "  ", compact);
                      if (s) {
                          s += compact ? ',' : ',\n';
                      }
                      s += compact ?
                        stringify(i, "", true) + ':' + v :
                        indent + "  " + stringify(i, indent + "  ") + ': ' + v;
                  }
              }
              curDepth--;
              return '{' +
                (arg instanceof MovieClip || arg instanceof TextField ? "// " + arg.toString() : "") +
                    (compact ? s + '}' : '\n' + s + '\n' + indent + '}');
          }
      }
      curDepth--;
      return 'null';
  case 'number':
      return isFinite(arg) ? String(arg) : 'null';
  case 'string':
      l = arg.length;
      s = '"';
      for (i = 0; i < l; i += 1) {
          c = arg.charAt(i);
          if (c >= ' ') {
              if (c == '\\' || c == '"') {
                  s += '\\';
              }
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
                      c = c.charCodeAt();
                      s += '\\u00' + Math.floor(c / 16).toString(16) +
                          (c % 16).toString(16);
              }
          }
      }
      return s + '"';
  case 'boolean':
      return String(arg);
  case 'null':
      return 'null';
  default:
      //if (maxDepth != null && maxDepth > 0)
      //    com.xvm.Logger.add("JSON> " + (typeof arg));
      return 'null';
  }
}

  static function parse(text:String):Object {
    if (!text || text == "") {
        return null;
    }
    var ta: Array = text.split(''); // charAt is much slower in Flash then array
    var talen = ta.length;
    var at = 0;
    var ch = ' ';
    var _value:Function;

    var _error:Function = function (m) {
        throw {
            name: 'JSONxError',
            message: m,
            at: at - 1,
            text: text
        };
    }

    var _next:Function = function() {
        ch = (at >= talen) ? '' : ta[at];
        at++;
        return ch;
    }

    var _white:Function = function() {
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
    
    var _isCharOrDigit:Function = function(s): Boolean {
        return (s >= "A" && s <= "Z") || (s >= "a" && s <= "z") || (s >= "0" && s <= "9") 
    }
    
    var _quotedString:Function = function() {
        var i, s = '', t, u;
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
        return null;
    }

    var _string:Function = function() {
        var result = _quotedString();
		if (result != null) {
			return result;
        }
		_error("Bad string");
    }
    
    var _unquotedIdentifier:Function = function() {
        var result = '';
            
        do {
            if (_isCharOrDigit(ch) || ch == '_' || ch == '-' || ch == '.') {
                result += ch;
            } else {
                return result == '' ? null : result;
            }
        } while(_next())
    }
    
    var _quotedIdentifier:Function = function() {
        return _quotedString();
    }
    
    var _identifier:Function = function() {
        return _quotedIdentifier() || _unquotedIdentifier();
    }

    var _array:Function = function() {
        var a = [];

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
    }

    // {...}
    var _object:Function = function() {
        var k, o = {};

        _next();
        _white();
        if (ch == '}') {
            _next();
            return o;
        }
        while (ch) {
            k = _identifier();
            if (k == null) {
                _error("Bad identifier");
                return;
            }
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
    }

    // ${...}
    var _reference:Function = function() {
        var f, p;

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
    }

    var _number:Function = function() {
        var n = '', v;

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
        v = 1 * Number(n);
        if (!isFinite(v)) {
            _error("Bad number");
        } else {
            return v;
        }
    }

    var _word:Function = function() {
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

    _value = function() {
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