package com.adobe.serialization.json 
{
    public class JSONDecoder extends Object
    {
        public function JSONDecoder(arg1:String, arg2:Boolean)
        {
            super();
            this.strict = arg2;
            this.tokenizer = new com.adobe.serialization.json.JSONTokenizer(arg1, arg2);
            this.nextToken();
            this.value = this.parseValue();
            if (arg2 && !(this.nextToken() == null)) 
            {
                this.tokenizer.parseError("Unexpected characters left in input stream");
            }
            return;
        }

        public function getValue():*
        {
            return this.value;
        }

        internal final function nextToken():com.adobe.serialization.json.JSONToken
        {
            var loc1:*;
            this.token = loc1 = this.tokenizer.getNextToken();
            return loc1;
        }

        internal final function nextValidToken():com.adobe.serialization.json.JSONToken
        {
            this.token = this.tokenizer.getNextToken();
            this.checkValidToken();
            return this.token;
        }

        internal final function checkValidToken():void
        {
            if (this.token == null) 
            {
                this.tokenizer.parseError("Unexpected end of input");
            }
            return;
        }

        internal final function parseArray():Array
        {
            var loc1:*=new Array();
            this.nextValidToken();
            if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET) 
            {
                return loc1;
            }
            if (!this.strict && this.token.type == com.adobe.serialization.json.JSONTokenType.COMMA) 
            {
                this.nextValidToken();
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET) 
                {
                    return loc1;
                }
                this.tokenizer.parseError("Leading commas are not supported.  Expecting \']\' but found " + this.token.value);
            }
            for (;;) 
            {
                loc1.push(this.parseValue());
                this.nextValidToken();
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET) 
                {
                    return loc1;
                }
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.COMMA) 
                {
                    this.nextToken();
                    if (!this.strict) 
                    {
                        this.checkValidToken();
                        if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACKET) 
                        {
                            return loc1;
                        }
                    }
                    continue;
                }
                this.tokenizer.parseError("Expecting ] or , but found " + this.token.value);
            }
            return null;
        }

        internal final function parseObject():Object
        {
            var loc2:*=null;
            var loc1:*=new Object();
            this.nextValidToken();
            if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE) 
            {
                return loc1;
            }
            if (!this.strict && this.token.type == com.adobe.serialization.json.JSONTokenType.COMMA) 
            {
                this.nextValidToken();
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE) 
                {
                    return loc1;
                }
                this.tokenizer.parseError("Leading commas are not supported.  Expecting \'}\' but found " + this.token.value);
            }
            for (;;) 
            {
                if (this.token.type == com.adobe.serialization.json.JSONTokenType.STRING) 
                {
                    loc2 = String(this.token.value);
                    this.nextValidToken();
                    if (this.token.type != com.adobe.serialization.json.JSONTokenType.COLON) 
                    {
                        this.tokenizer.parseError("Expecting : but found " + this.token.value);
                    }
                    else 
                    {
                        this.nextToken();
                        loc1[loc2] = this.parseValue();
                        this.nextValidToken();
                        if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE) 
                        {
                            return loc1;
                        }
                        if (this.token.type != com.adobe.serialization.json.JSONTokenType.COMMA) 
                        {
                            this.tokenizer.parseError("Expecting } or , but found " + this.token.value);
                        }
                        else 
                        {
                            this.nextToken();
                            if (!this.strict) 
                            {
                                this.checkValidToken();
                                if (this.token.type == com.adobe.serialization.json.JSONTokenType.RIGHT_BRACE) 
                                {
                                    return loc1;
                                }
                            }
                        }
                    }
                    continue;
                }
                this.tokenizer.parseError("Expecting string but found " + this.token.value);
            }
            return null;
        }

        internal final function parseValue():Object
        {
            this.checkValidToken();
            var loc1:*=this.token.type;
            switch (loc1) 
            {
                case com.adobe.serialization.json.JSONTokenType.LEFT_BRACE:
                {
                    return this.parseObject();
                }
                case com.adobe.serialization.json.JSONTokenType.LEFT_BRACKET:
                {
                    return this.parseArray();
                }
                case com.adobe.serialization.json.JSONTokenType.STRING:
                case com.adobe.serialization.json.JSONTokenType.NUMBER:
                case com.adobe.serialization.json.JSONTokenType.TRUE:
                case com.adobe.serialization.json.JSONTokenType.FALSE:
                case com.adobe.serialization.json.JSONTokenType.NULL:
                {
                    return this.token.value;
                }
                case com.adobe.serialization.json.JSONTokenType.NAN:
                {
                    if (!this.strict) 
                    {
                        return this.token.value;
                    }
                    this.tokenizer.parseError("Unexpected " + this.token.value);
                }
                default:
                {
                    this.tokenizer.parseError("Unexpected " + this.token.value);
                }
            }
            return null;
        }

        internal var strict:Boolean;

        internal var value:*;

        internal var tokenizer:com.adobe.serialization.json.JSONTokenizer;

        internal var token:com.adobe.serialization.json.JSONToken;
    }
}
