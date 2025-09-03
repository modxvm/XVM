/**
 * JSONxError
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw
{
    public class JSONxError extends Error
    {
        public var type:String;
        public var at:int;
        public var text:String;
        public var filename:String;

        public function JSONxError(type:String, message:String, at:int=-1, text:String=null)
        {
            this.type = type;
            super(message);
            this.name = "JSONxError";
            this.at = at;
            this.text = text;
            this.filename = null;
        }
    }
}
