package com.adobe.serialization.json 
{
    public class JSONParseError extends Error
    {
        public function JSONParseError(arg1:String="", arg2:int=0, arg3:String="")
        {
            super(arg1);
            name = "JSONParseError";
            this._location = arg2;
            this._text = arg3;
            return;
        }

        public function get location():int
        {
            return this._location;
        }

        public function get text():String
        {
            return this._text;
        }

        internal var _location:int;

        internal var _text:String;
    }
}
