package com.adobe.serialization.json
{
    public final class JSONTokenType extends Object
    {
        
        public function JSONTokenType()
        {
            super();
        }
        
        public static var UNKNOWN:int = -1;
        
        public static var COMMA:int = 0;
        
        public static var LEFT_BRACE:int = 1;
        
        public static var RIGHT_BRACE:int = 2;
        
        public static var LEFT_BRACKET:int = 3;
        
        public static var RIGHT_BRACKET:int = 4;
        
        public static var COLON:int = 6;
        
        public static var TRUE:int = 7;
        
        public static var FALSE:int = 8;
        
        public static var NULL:int = 9;
        
        public static var STRING:int = 10;
        
        public static var NUMBER:int = 11;
        
        public static var NAN:int = 12;
    }
}
