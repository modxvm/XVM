package com.adobe.serialization.json 
{
    public class JSONTokenizer extends Object
    {
        public function JSONTokenizer(arg1:String, arg2:Boolean)
        {
            super();
            this.jsonString = arg1;
            this.strict = arg2;
            this.loc = 0;
            this.nextChar();
            return;
        }

        public function getNextToken():com.adobe.serialization.json.JSONToken
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=null;
            this.skipIgnored();
            var loc6:*=this.ch;
            switch (loc6) 
            {
                case "{":
                {
                    loc1 = com.adobe.serialization.json.JSONToken.create(com.adobe.serialization.json.JSONTokenType.LEFT_BRACE, this.ch);
                    this.nextChar();
                    break;
                }
                case "}":
                {
                    loc1 = com.adobe.serialization.json.JSONToken.create(com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE, this.ch);
                    this.nextChar();
                    break;
                }
                case "[":
                {
                    loc1 = com.adobe.serialization.json.JSONToken.create(com.adobe.serialization.json.JSONTokenType.LEFT_BRACKET, this.ch);
                    this.nextChar();
                    break;
                }
                case "]":
                {
                    loc1 = com.adobe.serialization.json.JSONToken.create(com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET, this.ch);
                    this.nextChar();
                    break;
                }
                case ",":
                {
                    loc1 = com.adobe.serialization.json.JSONToken.create(com.adobe.serialization.json.JSONTokenType.COMMA, this.ch);
                    this.nextChar();
                    break;
                }
                case ":":
                {
                    loc1 = com.adobe.serialization.json.JSONToken.create(com.adobe.serialization.json.JSONTokenType.COLON, this.ch);
                    this.nextChar();
                    break;
                }
                case "t":
                {
                    loc2 = "t" + this.nextChar() + this.nextChar() + this.nextChar();
                    if (loc2 != "true") 
                    {
                        this.parseError("Expecting \'true\' but found " + loc2);
                    }
                    else 
                    {
                        loc1 = com.adobe.serialization.json.JSONToken.create(com.adobe.serialization.json.JSONTokenType.TRUE, true);
                        this.nextChar();
                    }
                    break;
                }
                case "f":
                {
                    loc3 = "f" + this.nextChar() + this.nextChar() + this.nextChar() + this.nextChar();
                    if (loc3 != "false") 
                    {
                        this.parseError("Expecting \'false\' but found " + loc3);
                    }
                    else 
                    {
                        loc1 = com.adobe.serialization.json.JSONToken.create(com.adobe.serialization.json.JSONTokenType.FALSE, false);
                        this.nextChar();
                    }
                    break;
                }
                case "n":
                {
                    if ((loc4 = "n" + this.nextChar() + this.nextChar() + this.nextChar()) != "null") 
                    {
                        this.parseError("Expecting \'null\' but found " + loc4);
                    }
                    else 
                    {
                        loc1 = com.adobe.serialization.json.JSONToken.create(com.adobe.serialization.json.JSONTokenType.NULL, null);
                        this.nextChar();
                    }
                    break;
                }
                case "N":
                {
                    if ((loc5 = "N" + this.nextChar() + this.nextChar()) != "NaN") 
                    {
                        this.parseError("Expecting \'NaN\' but found " + loc5);
                    }
                    else 
                    {
                        loc1 = com.adobe.serialization.json.JSONToken.create(com.adobe.serialization.json.JSONTokenType.NAN, NaN);
                        this.nextChar();
                    }
                    break;
                }
                case "\"":
                {
                    loc1 = this.readString();
                    break;
                }
                default:
                {
                    if (this.isDigit(this.ch) || this.ch == "-") 
                    {
                        loc1 = this.readNumber();
                    }
                    else if (this.ch != "") 
                    {
                        this.parseError("Unexpected " + this.ch + " encountered");
                    }
                    else 
                    {
                        loc1 = null;
                    }
                }
            }
            return loc1;
        }

        internal final function readString():com.adobe.serialization.json.JSONToken
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc1:*=this.loc;
            do 
            {
                loc1 = this.jsonString.indexOf("\"", loc1);
                if (loc1 >= 0) 
                {
                    loc3 = 0;
                    --loc4;
                    while (this.jsonString.charAt(loc4) == "\\") 
                    {
                        ++loc3;
                        --loc4;
                    }
                    if ((loc3 & 1) == 0) 
                    {
                        break;
                    }
                    ++loc1;
                }
                else 
                {
                    this.parseError("Unterminated string literal");
                }
            }
            while (true);
            var loc2:*=com.adobe.serialization.json.JSONToken.create(com.adobe.serialization.json.JSONTokenType.STRING, this.unescapeString(this.jsonString.substr(this.loc, loc1 - this.loc)));
            this.loc = loc1 + 1;
            this.nextChar();
            return loc2;
        }

        public function unescapeString(arg1:String):String
        {
            var loc3:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=null;
            if (this.strict && this.controlCharsRegExp.test(arg1)) 
            {
                this.parseError("String contains unescaped control character (0x00-0x1F)");
            }
            var loc1:*="";
            var loc2:*=0;
            loc3 = 0;
            var loc4:*=arg1.length;
            do 
            {
                loc2 = arg1.indexOf("\\", loc3);
                if (loc2 >= 0) 
                {
                    loc1 = loc1 + arg1.substr(loc3, loc2 - loc3);
                    loc3 = loc2 + 2;
                    loc5 = arg1.charAt(loc2 + 1);
                    var loc10:*=loc5;
                    switch (loc10) 
                    {
                        case "\"":
                        {
                            loc1 = loc1 + loc5;
                            break;
                        }
                        case "\\":
                        {
                            loc1 = loc1 + loc5;
                            break;
                        }
                        case "n":
                        {
                            loc1 = loc1 + "\n";
                            break;
                        }
                        case "r":
                        {
                            loc1 = loc1 + "\r";
                            break;
                        }
                        case "t":
                        {
                            loc1 = loc1 + "\t";
                            break;
                        }
                        case "u":
                        {
                            loc6 = "";
                            if ((loc7 = loc3 + 4) > loc4) 
                            {
                                this.parseError("Unexpected end of input.  Expecting 4 hex digits after \\u.");
                            }
                            loc8 = loc3;
                            while (loc8 < loc7) 
                            {
                                loc9 = arg1.charAt(loc8);
                                if (!this.isHexDigit(loc9)) 
                                {
                                    this.parseError("Excepted a hex digit, but found: " + loc9);
                                }
                                loc6 = loc6 + loc9;
                                ++loc8;
                            }
                            loc1 = loc1 + String.fromCharCode(parseInt(loc6, 16));
                            loc3 = loc7;
                            break;
                        }
                        case "f":
                        {
                            loc1 = loc1 + "";
                            break;
                        }
                        case "/":
                        {
                            loc1 = loc1 + "/";
                            break;
                        }
                        case "b":
                        {
                            loc1 = loc1 + "";
                            break;
                        }
                        default:
                        {
                            loc1 = loc1 + ("\\" + loc5);
                        }
                    }
                }
                else 
                {
                    loc1 = loc1 + arg1.substr(loc3);
                    break;
                }
            }
            while (loc3 < loc4);
            return loc1;
        }

        internal final function readNumber():com.adobe.serialization.json.JSONToken
        {
            var loc1:*="";
            if (this.ch == "-") 
            {
                loc1 = loc1 + "-";
                this.nextChar();
            }
            if (!this.isDigit(this.ch)) 
            {
                this.parseError("Expecting a digit");
            }
            if (this.ch != "0") 
            {
                while (this.isDigit(this.ch)) 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                }
            }
            else 
            {
                loc1 = loc1 + this.ch;
                this.nextChar();
                if (this.isDigit(this.ch)) 
                {
                    this.parseError("A digit cannot immediately follow 0");
                }
                else if (!this.strict && this.ch == "x") 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                    if (this.isHexDigit(this.ch)) 
                    {
                        loc1 = loc1 + this.ch;
                        this.nextChar();
                    }
                    else 
                    {
                        this.parseError("Number in hex format require at least one hex digit after \"0x\"");
                    }
                    while (this.isHexDigit(this.ch)) 
                    {
                        loc1 = loc1 + this.ch;
                        this.nextChar();
                    }
                }
            }
            if (this.ch == ".") 
            {
                loc1 = loc1 + ".";
                this.nextChar();
                if (!this.isDigit(this.ch)) 
                {
                    this.parseError("Expecting a digit");
                }
                while (this.isDigit(this.ch)) 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                }
            }
            if (this.ch == "e" || this.ch == "E") 
            {
                loc1 = loc1 + "e";
                this.nextChar();
                if (this.ch == "+" || this.ch == "-") 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                }
                if (!this.isDigit(this.ch)) 
                {
                    this.parseError("Scientific notation number needs exponent value");
                }
                while (this.isDigit(this.ch)) 
                {
                    loc1 = loc1 + this.ch;
                    this.nextChar();
                }
            }
            var loc2:*=Number(loc1);
            if (isFinite(loc2) && !isNaN(loc2)) 
            {
                return com.adobe.serialization.json.JSONToken.create(com.adobe.serialization.json.JSONTokenType.NUMBER, loc2);
            }
            this.parseError("Number " + loc2 + " is not valid!");
            return null;
        }

        internal final function nextChar():String
        {
            var loc1:*;
            var loc2:*=((loc1 = this).loc + 1);
            loc1.loc = loc2;
            this.ch = loc1 = this.jsonString.charAt((loc1 = this).loc);
            return loc1;
        }

        internal final function skipIgnored():void
        {
            var loc1:*=0;
            do 
            {
                loc1 = this.loc;
                this.skipWhite();
                this.skipComments();
            }
            while (loc1 != this.loc);
            return;
        }

        internal function skipComments():void
        {
            if (this.ch == "/") 
            {
                this.nextChar();
                var loc1:*=this.ch;
                switch (loc1) 
                {
                    case "/":
                    {
                        do 
                        {
                            this.nextChar();
                        }
                        while (!(this.ch == "\n") && !(this.ch == ""));
                        this.nextChar();
                        break;
                    }
                    case "*":
                    {
                        this.nextChar();
                        for (;;) 
                        {
                            if (this.ch != "*") 
                            {
                                this.nextChar();
                            }
                            else 
                            {
                                this.nextChar();
                                if (this.ch == "/") 
                                {
                                    this.nextChar();
                                    break;
                                }
                            }
                            if (this.ch != "") 
                            {
                                continue;
                            }
                            this.parseError("Multi-line comment not closed");
                        }
                        break;
                    }
                    default:
                    {
                        this.parseError("Unexpected " + this.ch + " encountered (expecting \'/\' or \'*\' )");
                    }
                }
            }
            return;
        }

        internal final function skipWhite():void
        {
            while (this.isWhiteSpace(this.ch)) 
            {
                this.nextChar();
            }
            return;
        }

        internal final function isWhiteSpace(arg1:String):Boolean
        {
            if (arg1 == " " || arg1 == "\t" || arg1 == "\n" || arg1 == "\r") 
            {
                return true;
            }
            if (!this.strict && arg1.charCodeAt(0) == 160) 
            {
                return true;
            }
            return false;
        }

        internal final function isDigit(arg1:String):Boolean
        {
            return arg1 >= "0" && arg1 <= "9";
        }

        internal final function isHexDigit(arg1:String):Boolean
        {
            return this.isDigit(arg1) || arg1 >= "A" && arg1 <= "F" || arg1 >= "a" && arg1 <= "f";
        }

        public final function parseError(arg1:String):void
        {
            throw new com.adobe.serialization.json.JSONParseError(arg1, this.loc, this.jsonString);
        }

        internal const controlCharsRegExp:RegExp=new RegExp("[\\x00-\\x1F]");

        internal var strict:Boolean;

        internal var obj:Object;

        internal var jsonString:String;

        internal var loc:int;

        internal var ch:String;
    }
}
