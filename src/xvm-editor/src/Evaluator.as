package
{

public class Evaluator
{
/*    private function trace(str:String):Void
    {
        Logger.add("[Evaluator]> " + str);
    }*/

    /**
    * script - script
    * privider - object with functions implementation
    */
    public static function evaluate(script:String, provider)
    {
        var ta:Array = script.split(""); // faster then charAt() in ScaleForm
        var at:Number = 0;
        var ch:String = ' ';

        var _value:Function;

        var _error:Function = function (m:String):void {
            throw {
                name: 'EvaluatorError',
                message: m,
                at: at - 1,
                text: script
            };
        }

        var _next:Function = function() {
            ch = ta[at];
            at += 1;
            trace(ch);
            return ch;
        }

        var _white:Function = function() {
            while (ch) {
                if (ch <= ' ' || ch == ';') {
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

        var _string:Function = function() {
            var i, s = '', t, u;
            var outer:Boolean = false;

            if (ch == '"' || ch == "'")
            {
                var sc = ch; 
                while (_next()) {
                    if (ch == sc) {
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
                        default:
                            s += ch;
                        }
                    } else {
                        s += ch;
                    }
                }
            }
            _error("Bad string");
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

        var _array:Function = function() {
            var a = [];

            if (ch == '[') {
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
            }
            _error("Bad array");
        }

        var _function:Function = function(fn) {
            var a = [];

            if (ch == '(') {
                _next();
                _white();
                if (ch == ')') {
                    _next();
                    if (!provider.hasOwnProperty(fn))
                        _error("provider have no function '" + fn + "'");
                    return provider[fn].apply(provider, a);
                }
                while (ch) {
                    a.push(_value());
                    _white();
                    if (ch == ')') {
                        _next();
                        if (!provider.hasOwnProperty(fn))
                            _error("provider have no function '" + fn + "'");
                        return provider[fn].apply(provider, a);
                    } else if (ch != ',') {
                        break;
                    }
                    _next();
                    _white();
                }
            }
            _error("Bad function");
        }

       var _object:Function = function() {
            var k, o = {};

            if (ch == '{') {
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
            }
            _error("Bad object");
        }

        _value = function() {
            _white();
            switch (ch) {
                case '{':
                    return _object();
                case '[':
                    return _array();
                case "'":
                case '"':
                    return _string();
                case '-':
                    return _number();
                default:
                    if (ch >= '0' && ch <= '9')
                        return _number();
                    if (ch == '_' || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))
                    {
                        var n = '';
                        while (ch == '_' || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z') || ch >= '0' && ch <= '9') {
                            n += ch;
                            _next();
                        }
                        _white();
                        if (ch == '=') {
                            provider[n] = _value(n);
                            return;
                        }
                        if (ch == '(') {
                            return _function(n);
                        }
                        if (n == 'true')
                            return true;
                        if (n == 'false')
                            return false;
                        if (n == 'null')
                            return null;
                        _error("Bad char");
                    }
            }
            _error("Bad char");
        }

        var result = null;
        var len = ta.length;
        while (at < len)
            result = _value();
        return result;
    }


    public function insert(tl, time) {trace('insert:'+arguments.join(', '))}
    public function set(tl) {trace('set:'+arguments.join(', '))}
    public function append(tl, time) {trace('append:'+arguments.join(', '))}

    public function alpha(value) {trace('alpha:'+arguments.join(', '))}
    public function color(value) {trace('color:'+arguments.join(', '))}
    public function shadow(value) {trace('shadow:'+arguments.join(', '))}
    public function tint(value, color) {trace('tint:'+arguments.join(', '))}
    public function fadeIn(value) {trace('fadeIn:'+arguments.join(', '))}
    public function fadeOut(value) {trace('fadeOut:'+arguments.join(', '))}
    public function move(value) {trace('move:'+arguments.join(', '))}
}

}
