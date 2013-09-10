package com.adobe.serialization.json 
{
    import flash.utils.*;
    
    public class JSONEncoder extends Object
    {
        public function JSONEncoder(arg1:*)
        {
            super();
            this.jsonString = this.convertToString(arg1);
            return;
        }

        public function getString():String
        {
            return this.jsonString;
        }

        internal function convertToString(arg1:*):String
        {
            if (arg1 is String) 
                return this.escapeString(arg1 as String);
            if (arg1 is Number) 
                return isFinite(arg1 as Number) ? arg1.toString() : "null";
            if (arg1 is Boolean) 
                return arg1 ? "true" : "false";
            if (arg1 is Array) 
                return this.arrayToString(arg1 as Array);
            if (arg1 is Object && !(arg1 == null)) 
                return this.objectToString(arg1);
            return "null";
        }

        internal function escapeString(arg1:String):String
        {
            var loc2:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc1:*="";
            var loc3:*=arg1.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc2 = arg1.charAt(loc4);
                var loc7:*=loc2;
                switch (loc7) 
                {
                    case "\"":
                        loc1 = loc1 + "\\\"";
                        break;
                    case "\\":
                        loc1 = loc1 + "\\\\";
                        break;
                    case "":
                        loc1 = loc1 + "\\b";
                        break;
                    case "":
                        loc1 = loc1 + "\\f";
                        break;
                    case "\n":
                        loc1 = loc1 + "\\n";
                        break;
                    case "\r":
                        loc1 = loc1 + "\\r";
                        break;
                    case "\t":
                        loc1 = loc1 + "\\t";
                        break;
                    default:
                        if (loc2 < " ") 
                        {
                            loc6 = (loc5 = loc2.charCodeAt(0).toString(16)).length != 2 ? "000" : "00";
                            loc1 = loc1 + ("\\u" + loc6 + loc5);
                        }
                        else 
                            loc1 = loc1 + loc2;
                }
                ++loc4;
            }
            return "\"" + loc1 + "\"";
        }

        internal function arrayToString(arg1:Array):String
        {
            var loc1:*="";
            var loc2:*=arg1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                if (loc1.length > 0) 
                    loc1 = loc1 + ",";
                loc1 = loc1 + this.convertToString(arg1[loc3]);
                ++loc3;
            }
            return "[" + loc1 + "]";
        }

        internal function objectToString(arg1:Object):String
        {
            var o:Object;
            var s:String;
            var classInfo:XML;
            var value:Object;
            var key:String;
            var v:XML;

            var loc1:*;
            value = null;
            key = null;
            v = null;
            o = arg1;
            s = "";
            classInfo = flash.utils.describeType(o);
            if (classInfo.@name.toString() != "Object") 
            {
                loc2 = 0;
                var loc5:*=0;
                var loc6:*=classInfo;
                var loc4:*=new XMLList("");
                for each (var loc7:* in loc6) 
                {
                    var loc8:*;
                    with (loc8 = loc7) 
                        if (name() == "variable" || name() == "accessor" && attribute("access").charAt(0) == "r") 
                            loc4[loc5] = loc7;
                }
                loc3 = loc4;
                for each (v in loc3) 
                {
                    if (v.metadata) 
                    {
                        v.metadata;
                        loc5 = 0;
                        loc6 = v.metadata;
                        loc4 = new XMLList("");
                        for each (loc7 in loc6) 
                            with (loc8 = loc7) 
                                if (@name == "Transient") 
                                    loc4[loc5] = loc7;
                    }
                    if (v.metadata) 
                        continue;
                    if (s.length > 0) 
                        s = s + ",";
                    s = s + (this.escapeString(v.@name.toString()) + ":" + this.convertToString(o[v.@name]));
                }
            }
            else 
            {
                var loc2:*=0;
                var loc3:*=o;
                for (key in loc3) 
                {
                    value = o[key];
                    if (value is Function) 
                        continue;
                    if (s.length > 0) 
                        s = s + ",";
                    s = s + (this.escapeString(key) + ":" + this.convertToString(value));
                }
            }
            return "{" + s + "}";
        }

        internal var jsonString:String;
    }
}
