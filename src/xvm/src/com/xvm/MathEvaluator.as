/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2009
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.

  Converted to AS2 by Maxim Schedriviy <m.schedriviy@gmail.com> 2013-06-12
*/

/**
 * Evaluates mathematical string expressions.
 * <p><b>The MathEvaluator implementation</b>, support all of the following :</p>
 * <p><b>Decimal, hexadecimal, octal notation :</b></p>
 * <pre class="prettyprint">
 * 1 + 1
 * 0.5 + 0.7
 * 0xff + 0xbb
 * 010 + 5
 * etc.
 * </pre>
 * <p>operators : </p>
 * <pre class="prettyprint">
 * % / &#8727; + - << >> >>> & ^ | ~
 * </pre>
 * <p>functions :</p>
 * <pre class="prettyprint">
 * abs acos asin atan atan2 ceil cos exp
 * floor log max min pow random round
 * sin sqrt tan 
 * </pre>
 * Those functions replicate exactly what you can find in the Math object.
 * <p>operators priority : from higher to lower priority</p>
 * <p><b>Example :</b> multiplication is performed before addition</p>
 * <pre class="prettyprint">
 * (14) fcn(...) (...)
 * </pre>
 * <p>function call and expression grouping</p>
 * <p><b>example :</b> <code class="prettyprint">sin(4) + 25</code></p>
 * <p>sin(4) will be evaluated first</p>
 * <p><b>example :</b> <code class="prettyprint">5 &#8727; (4 + 0.5)</code></p>
 * <p>the expression within the parenthesis will occurs first</p>
 * <pre class="prettyprint">
 * (13) ~ + - 
 * </pre>
 * <p>unary operators</p>
 * <p>ex: <code class="prettyprint">+5 - +5</code> translate to <code class="prettyprint">(+5) - (+5)</code></p>
 * <p>ex: <code class="prettyprint">-5 + -5</code> translate to <code class="prettyprint">(-5) + (-5)</code></p>
 * <p>ex: <code class="prettyprint">~3 - 7</code>  translate to <code class="prettyprint">(~3) - 7</code></p>
 * <p>any unary operators will be evaluated first</p>
 * <pre class="prettyprint">
 * (12) &#8727; / %
 * </pre>
 * <p><b>multiplication, division, modulo division</p></b>
 * <p>ex: 5 &#8727; 3 + 1 translate to (5 &#8727; 3) + 1</p>
 * <p>ex: 2 % 8 - 4 translate to (2 % 8) - 4</p>
 * <pre class="prettyprint">
 * (11) + -
 * </pre>
 * <p><b>addition, subtraction</b></p>
 * <pre class="prettyprint">
 * (10) << >> <<<
 * </pre>
 * <p><b>bit shifting</b></p>
 * <pre class="prettyprint">
 * (7)  &
 * </pre>
 * <p><b>bitwise AND</b></p>
 * <pre class="prettyprint">
 * (6)  ^
 * </pre>
 * <p><b>bitwise XOR</b></p>
 * <pre class="prettyprint">
 * (5)  |
 * </pre>
 * <p><b> bitwise OR</b></p>
 * <p>contexts</p>
 * <p>When instanciating the MathEvaluator you can pass a contexts array containing either variables or functions</p>
 * <p><b>Example :</b></p>
 * <pre class="prettyprint">
 * var me:MathEvaluator = new MathEvaluator( {x:100, test:function(a:Number):Number {return a*a;} );
 * trace( me.eval( "test(100) + 1" ) ); //return 10001
 * </pre>
 * <p>but there are some limitations</p>
 * <li>your variable or function name must me lowercase</li>
 * <li>your variable or function name must contains only letter from a to z and can end with only one digit</li>
 * <p><b>Example :</b></p>
 * <pre class="prettyprint">
 * test()  //OK
 * test2() //OK
 * 2test() //BAD
 * te2st() //BAD
 * etc.
 * </pre>
 * <li>your function can only have one argument<\li>
 * <li>your function name can not override default math functions as cos, sin, etc.<\li>
 * <p>we do not support logical ( || && !) or assignement operators (= == += etc.)</p>
 * <p><b>reasons:</b></p>
 * <p>logical operators deal with boolean, here we want to deal only with numbers and math expression we do not support variables nor variable assignation</p>
 * <p>Parenthesis are used to alter the order of evaluation determined by operator precedence.</p>
 * <p>Operators with the same priority are evaluated left to right.</p>
 * <p><b>How the parser work :</b></p>
 * <p><b>1)</b> we first filter some multiple char operators to single chars</p>
 * <p><b>ex:</b> << translate to « and other filtering</p>
 * <p><b>2)</b> then we parse char by char (top to bottom parsing) to generate tokens in postfix order(reverse polish notation)</p>
 * <p>the expression 5 + 4 become <code class="prettyprint">[5,4,+]</code> but while doing that we also do a lot of other things</p>
 * <li>evaluate function call</li>
 * <li>remove space chars</li>
 * <li>re-order tokens by operators priority</li>
 * <li>evaluate  hexadecimal notation to decimal</li>
 * <li>etc.</li>
 * <p>3) finally we iterate trough our tokens and evaluate them by operators</p>
 * <p><b>ex:</b> [5,4,+]</p>
 * <p>we find the op +, then addition the 2 values, etc.</p>
 * <p>till the end of the tokens list</p>
 * </p>
 */
import com.xvm.Strings;
import com.xvm.Logger;
 
class com.xvm.MathEvaluator
{
    /**
     * Creates a new MathsEvaluator instance.
     * @param contexts When instanciating the MathEvaluator you can pass a contexts array containing either variables or functions.
     */
    public function MathEvaluator(contexts:Array)
    {
        if (contexts != null)
            _contexts = contexts;
    }

    /**
     * Evaluates the specified object.
     */
    public function eval(o:String)
    {
        return parse(o);
    }

    /**
     * @private
     */
    private var _contexts:Array = [];

    /**
     * The max hexadecimal value.
     */
    private static var maxHexValue:Number = 0xFFFFFF;

    /**
     * The expression value.
     */
    private var expression:String;

    /**
     * The current position.
     */
    private var currentPos:Number;

    /**
     * The Array representation of the tokens of this evaluator.
     */
    private var tokens:Array;

    /**
     * Adds the specified value to the last token.
     */
    private function addToLastToken(value:String)
    {
        tokens[tokens.length - 1] += value;
    }          

    /**
     * Adds the specified value to the next token.
     */
    private function addToNextToken(value:String)
    {
        tokens.push(value);
    }

    /**
     * Indicates if the passed-in value is a alpha character. (A-Z, a-z, '_', '$', '.')
     */
    private function isAlpha(c:String):Boolean
    {
        return ((c >= "A") && (c <= "Z")) || ((c >= "a") && (c <= "z")) || c == "_" || c == "$" || c == ".";
    }

    /**
     * Indicates if the passed-in string value is a digit.
     */
    private function isDigit(c:String):Boolean
    {
        return (c >= "0") && (c <= "9");
    }

    /**
     * Indicates if the passed-in string value is a hexadecimal digit.
     */
    private function isHexDigit(c:String):Boolean
    {
        return isDigit(c) || ((c >= "A") && (c <= "F")) || ((c >= "a") && (c <= "f"));
    }

    /**
     * Indicates if the passed-in string value is a octal digit.
     */
    private function isOctalDigit(c:String):Boolean
    {
        return (c >= "0") && (c <= "7");
    }

    /**
     * Indicates if the passed-in string value is a operator digit.
     */
    private function isOperator(c:String):Boolean
    {
        switch(c)
        {
            case "*": 
            case "/": 
            case "%":
            case "+": 
            case "-":
            case "«": // << 
            case "»": // >>
            case "›": // >>>
            case "&": 
            case "^": 
            case "|":
                return true;
            
            default:
                return false;
        }
    }

    /**
     * Indicates if has more char.
     */
    private function hasMoreChar():Boolean
    {
        return currentPos < expression.length;
    }

    /**
     * Returns the char with the specified position.
     * @return the char with the specified position.
     */
    private function getChar(pos:Number):String
    {
        if (pos == null || pos < 0)
            pos = currentPos;
        return expression.charAt(pos);
    }

    /**
     * Returns the next char.
     * @return the next char.
     */
    function getNextChar():String
    {
        currentPos++;
        return getChar();
    }

    /**
     * Returns the last token string.
     * @return the last token string.
     */
    private function getLastToken():String
    {
        return tokens[tokens.length - 1];
    }

    /**
     * Returns the value of the specified numeric expression.
     * @return the value of the specified numeric expression.
     */
    private function getValue(num:String):Number
    {
        var ch0:String;
        var ch1:String;
        var isBitNot:Boolean = false;
        var isNeg:String = "";
        
        if (num.charAt(0) == "~")
        {
            num = num.substr(1);
            isBitNot = true;
        }
        
        if (num.charAt(0) == "-")
        {
            num = num.substr(1);
            isNeg = "-";
        }
        
        ch0 = num.charAt(0);
        ch1 = num.charAt(1);
        
        if ((ch0 == "0") && (num.length > 1))
        {
            if (isOctalDigit(ch1) && (num.indexOf(".") == - 1) && (num.indexOf("e") == - 1))
            {
                var value = parseInt(isNeg + num);
                return isBitNot ? ~value : value;
            }
        }
        
        var value = Number(isNeg + num);
        return isBitNot ? ~value : value;
    }

    /**
     * Returns The string function value representation.
     * @param name The name of the function.
     * @param expressions The arguments as math expression.
     * @return The result string of the evaluated function.
     */
    private function getFunctionValue(name:String, expressions:Array):String
    {
        var args:Array = [];
        var me:MathEvaluator = new MathEvaluator(_contexts);
        
        var len = expressions.length;
        for (var i:Number = 0; i < len; ++i)
        {
            if (expressions[i] != "")
                args.push(me.eval(expressions[i]));
        }
        
        switch (name)
        {
            case "abs":
                return String(Math.abs(args[0]));
                break;
            
            case "acos":
                return String(Math.acos(args[0]));
                break;
            
            case "asin":
                return String(Math.asin(args[0]));
                break;
            
            case "atan":
                return String(Math.atan(args[0]));
                break;
            
            case "atan2": 
                //2
                return String(Math.atan2(args[0], args[1]));
                break;
            
            case "ceil":
                return String(Math.ceil(args[0]));
                break;
            
            case "cos":
                return String(Math.cos(args[0]));
                break;
            
            case "exp":
                return String(Math.exp(args[0]));
                break;
            
            case "floor":
                return String(Math.floor(args[0]));
                break;
            
            case "log":
                return String(Math.log(args[0]));
                break;
            
            case "max": 
                //2
                return String(Math.max(args[0], args[1]));
                break;
            
            case "min": 
                //2
                return String(Math.min(args[0], args[1]));
                break;
            
            case "pow": 
                //2
                return String(Math.pow(args[0], args[1]));
                break;
            
            case "random": 
                //0
                return String(Math.random());
                break;
            
            case "round":
                return String(Math.round(args[0]));
                break;
            
            case "sin":
                return String(Math.sin(args[0]));
                break;
            
            case "sqrt":
                return String(Math.sqrt(args[0]));
                break;
            
            case "tan":
                return String(Math.tan(args[0]));
                break;
            
            default:
                //Logger.add("getFunctionValue: " + name + "(" + args.join(",") + ")");
                var cnt:Number = _contexts.length;
                for (var i:Number = 0; i < cnt; ++i)
                {
                    var ctx:Object = getValueObject(_contexts[i], name);
                    if (ctx == null)
                        continue;
                    var value = ctx[getValueName(name)];
                    if (value !== undefined && typeof value == "function")
                        return value.apply(ctx, args);
                }
                return undefined;
        }
    }

    /**
     * Returns the variable value with the internal context of the evaluator.
     * @return the variable value with the internal context of the evaluator.
     */
    private function getVariableValue(name:String):String
    {
        //Logger.add("getVariableValue: " + name);
        var cnt:Number = _contexts.length;
        for (var i:Number = 0; i < cnt; ++i)
        {
            var ctx:Object = getValueObject(_contexts[i], name);
            if (ctx == null)
                continue;
            var value = ctx[getValueName(name)];
            if (value !== undefined)
                return value.toString();
        }
        return undefined;
    }

    private function getValueObject(ctx:Object, name:String):Object
    {
        var parts:Array = name.split(".");
        var cnt:Number = parts.length;
        for (var i:Number = 0; i < cnt - 1, ctx != null; ++i)
            ctx = ctx[parts[i]];
        return ctx;
    }
    
    private function getValueName(name:String):String
    {
        var parts:Array = name.split(".");
        return parts[parts.length - 1];
    }
    
    /**
     * Filters and returns special char passed-in argument.
     * @return special char passed-in argument.
     */
    private function filterSpecialChars(expression:String):String
    {
        /* note:
        clear spaces, tabs, cr, lf.
         */
        expression = expression.split(" ").join("");
        expression = expression.split("\t").join("");
        expression = expression.split("\r").join("");
        expression = expression.split("\n").join("");

        /* note:
        for case 1E5, SIN(4), 0Xff, etc.
         */
        //expression = expression.toLowerCase();
        
        /* note:
        optimize multi char to single char
         */
        expression = expression.split("<<").join("«");
        expression = expression.split(">>>").join("›");
        expression = expression.split(">>").join("»");
        
        /* note:
        for case +5 - +5 -> +5 - 5
        for case +-5 * -+10 -> -5 * -10 
         */
        expression = expression.split("+-").join( "-");
        expression = expression.split("-+").join( "-");
        
        return expression;
    }

    /**
     * Returns the array representation of all elements in a parenthesis block.
     * @return the array representation of all elements in a parenthesis block.
     */
    private function getParenthesisBlock():Array
    {
        var startNode:Number = 0;
        var endNode:Number = 0;
        
        var expressions:Array = [ "", "" ];
        var num:Number = 0;
        var ch:String = "";
        
        for ( ; ; )
        {
            ch = getNextChar();
            switch(ch)
            {
                case "(":
                    startNode++;
                    expressions[num] += ch;
                    break;
                
                case ")":
                    endNode++;
                    expressions[num] += ch;
                    break;
                
                case ",":
                    num++;
                    break;
                
                default:
                    expressions[num] += ch;
            }
            
            if (startNode == endNode)
                break;
        }
        
        currentPos++;
        expressions[0] = expressions[0].substr(1); 
        //remove the first (
        expressions[num] = expressions[num].substr(0, expressions[num].length - 1); 
        //remove the last )
        return expressions;
    }

    /**
     * Returns the operator priority value.
     * @return the operator priority value.
     */
    private function getOperatorPriority(op:String):Number
    {
        /* note:
        function call and expression grouping priorities
        and unary priorities
        are dealt inside toPostfixNotation().
         */
        switch (op)
        {
            case "*":
            case "/":
            case "%":
                return 12;
            
            case "+":
            case "-":
                return 11;
            
            case "«": // <<
            case "»": // >>
            case "›": // >>>
                return 10;
            
            case "&": 
                //bitwise AND
                return 7;
            
            case "^": 
                //bitwise XOR
                return 6;
            
            case "|": 
                //bitwise OR
                return 5;
            
            default:
                return 0;
        }
    }

    /**
     * The toPostfixNotation method.
     */
    private function toPostfixNotation()
    {
        var ch:String;
        var ch2:String;
        var bitNot:String;
        var neg:String;
        var opr:String;
        var hex:String;
        var dot:Boolean;
        var exp:Boolean;
        var digit:String;
        
        var stack:Array = [];
        
        while (hasMoreChar())
        {
            ch = getChar();
            bitNot = "";
            neg = "";
            
            switch (ch.toLowerCase())
            {
                case "(":
                    stack.push(ch);
                    currentPos++;
                    break;
                    
                case ")":
                    opr = stack.pop().toString();
                    
                    while (opr != "(")
                    {
                        addToNextToken(opr);
                        opr = stack.pop().toString();
                    }
                    
                    currentPos++;
                    break;
                    
                case "*": 
                case "/": 
                case "%":
                case "+": 
                case "-":
                case "«": // << 
                case "»": // >>
                case "›": // >>>
                case "&": 
                case "^": 
                case "|":
                    if (stack.length != 0)
                    {
                        opr = stack.pop().toString();
                        
                        while (getOperatorPriority(opr) >= getOperatorPriority(ch))
                        {
                            addToNextToken(opr);
                            opr = stack.pop().toString();
                        }
                        
                        stack.push(opr);
                        stack.push(ch);
                        addToNextToken("");
                    }
                    else
                    {
                        stack.push(ch);
                        addToNextToken("");
                    }
                    
                    currentPos++;
                    break;
                
                case "0": 
                case "1": 
                case "2": 
                case "3": 
                case "4":
                case "5": 
                case "6": 
                case "7": 
                case "8": 
                case "9":
                case "~":
                    if (tokens.length == 0)
                    {
                        addToNextToken("");
                    }          
                    
                    /* note:
                    unary priorities
                     */
                    if (ch == "~")
                    {
                        bitNot = "~";
                        ch = getNextChar();
                    }
                    
                    if (ch == "+")
                    {
                        ch = getNextChar();
                    }
                    
                    if (ch == "-")
                    {
                        neg = "-";
                        ch = getNextChar();
                    }
                    
                    if (ch == "0")
                    {
                        while (ch == "0")
                        {
                            ch = getNextChar();
                        }
                    
                        currentPos--;
                        ch = getChar();
                    }
                    
                    ch2 = getChar(currentPos + 1);
                    
                    if ((ch == "0") && (ch2 == "x" || ch2 == "X"))
                    {
                        hex = "";
                        currentPos += 2;
                        ch = getChar();
                        
                        while (isHexDigit(ch))
                        {
                            hex += ch;
                            ch = getNextChar();
                        }
                        
                        if (hex.length > maxHexValue)
                        {
                            hex = hex.substr(0, maxHexValue);
                        }
                        
                        if (hex == "")
                        {
                            hex = "0";
                        }
                    
                        addToLastToken(bitNot + neg + "0x" + hex);
                    }
                    else
                    {
                        dot = false;
                        exp = false;
                        digit = "";
                        
                        while (isDigit(ch) || (ch == ".") || (ch == "e" || ch == "E"))
                        {
                            if (ch == "e" || ch == "E")
                            {
                                if (exp)
                                {
                                    ch = getNextChar();
                                    continue;
                                }
                                
                                exp = true;
                                digit += ch;
                                ch = getNextChar();
                                
                                if ((ch == "+") || (ch == "-"))
                                {
                                    digit += ch;
                                    ch = getNextChar();
                                }
                                
                                continue;
                            }
                            
                            if (ch == ".")
                            {
                                if (dot)
                                {
                                    ch = getNextChar();
                                    continue;
                                }
                                
                                dot = true;
                            }
                            
                            digit += ch;
                            ch = getNextChar();
                        }
                        
                        addToLastToken(bitNot + neg + digit);
                    }
                    
                    break;
                    
                case "a": //abs, acos, asin, atan, atan2
                case "b":
                case "c": //ceil, cos
                case "d":
                case "e": //exp
                case "f": //floor
                case "g":
                case "h":
                case "i":
                case "j":
                case "k":
                case "l": //log
                case "m": //max, min
                case "n":
                case "o":
                case "p": //pow
                case "q":
                case "r": //random, round
                case "s": //sin, sqrt
                case "t": //tan
                case "u":
                case "v":
                case "w":
                case "x":
                case "y":
                case "z":
                case "_":
                case "$":
                    var name:String = ch;
                    
                    while (isAlpha(ch))
                    {
                        ch = getNextChar();
                        if (isAlpha(ch) || isDigit(ch))
                        {
                            name += ch;
                        }
                        else
                        {
                            currentPos--;
                        }
                    }
                    
                    if (tokens.length == 0)
                    {
                        addToNextToken("");
                    }
                    
                    var peek:String = getChar(currentPos + 1);
                    if (peek == "(")
                    {
                        addToLastToken(getFunctionValue(name, getParenthesisBlock()));
                    }
                    else
                    {
                        addToLastToken(getVariableValue(name));
                        currentPos++;
                    }
                    
                    break;
                
                default:
                    /* note: by default we ignore anyother chars */
                    currentPos++;
            }
        }
        
        while (stack.length != 0)
        {
            opr = stack.pop().toString();
            
            if (opr != "")
            {
                addToNextToken(opr);
            }
        }
        
        if ((getLastToken() == "") || (getLastToken() == null))
        {
            tokens.pop();
        }
        
        if (tokens.length % 2 == 0)
        {
            tokens.unshift("0");
        }
        
        //Logger.add("tokens: " + com.xvm.JSONx.stringify(tokens, "", true));
    }

    /**
     * Launchs the evaluation process.
     */
    private function evaluate():Number
    {
        var op:String;
        var value;
        var valueA;
        var valueB;
        for (var i:Number = 0; i < tokens.length ; i++)
        {
            op = tokens[i];
            value = null;
            
            if (isOperator(op))
            {
                valueA = getValue(tokens[i - 2]);
                valueB = getValue(tokens[i - 1]);
                
                switch (op)
                {
                    case "+":
                        value = valueA + valueB;
                        break;
                    
                    case "-":
                        value = valueA - valueB;
                        break;
                    
                    case "*":
                        value = valueA * valueB;
                        break;
                    
                    case "/":
                        value = valueA / valueB;
                        break;
                    
                    case "%":
                        value = valueA % valueB;
                        break;
                    
                    case "^":
                        value = valueA ^ valueB;
                        break;
                    
                    case "&":
                        value = valueA & valueB;
                        break;
                    
                    case "|":
                        value = valueA | valueB;
                        break;
                    
                    case "«": // <<
                        value = valueA << valueB;
                        break;
                    
                    case "»": // >>
                        value = valueA >> valueB;
                        break;
                    
                    case "›": // >>>
                        value = valueA >>> valueB;
                        break;
                    
                    default:
                        /* NOTE: this CANNOT happen */
                        Logger.add("## ERROR : unsupported operator \"" + op + "\" ##");
                }
            }
            
            if (value != null)
            {
                tokens.splice(i - 2, 3, value);
                return evaluate();
            }
        }
        
        if (tokens.length > 1)
        {
            return evaluate();
        }
        else
        {
            return getValue(tokens[0]);
        }
    }

    /**
     * Parses the specified expression.
     */
    private function parse(expression:String):Number
    {
        reset();
        this.expression = filterSpecialChars(expression);
        toPostfixNotation();
        return evaluate();
    }

    /**
     * Resets the evaluator.
     */
    private function reset()
    {
        expression = "";
        currentPos = 0;
        tokens = [];
    }
}    
