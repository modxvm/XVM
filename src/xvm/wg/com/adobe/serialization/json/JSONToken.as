package com.adobe.serialization.json 
{
    public final class JSONToken extends Object
    {
        public function JSONToken(arg1:int=-1, arg2:Object=null)
        {
            super();
            this.type = arg1;
            this.value = arg2;
            return;
        }

        static function create(arg1:int=-1, arg2:Object=null):com.adobe.serialization.json.JSONToken
        {
            token.type = arg1;
            token.value = arg2;
            return token;
        }

        static const token:com.adobe.serialization.json.JSONToken=new JSONToken();

        public var type:int;

        public var value:Object;
    }
}
