package com.xvm.io
{
    public class JSONxError extends Error
    {
        public var at:int;
        public var text:String;
        public var filename:String;

        public function JSONxError(message:String, at:int, text:String)
        {
            super(message);
            this.name = "JSONxError";
            this.at = at;
            this.text = text;
            this.filename = null;
        }
    }
}
