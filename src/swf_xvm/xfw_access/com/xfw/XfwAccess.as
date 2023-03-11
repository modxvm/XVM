package com.xfw
{
	import flash.utils.getQualifiedClassName;
    import com.xfw.Logger;

    public class XfwAccess
    {
        public static function getPrivateField(obj:*, field:String):*
        {
            var result:* = null;
            if (obj == null) {
                Logger.add("XfwAccess::getPrivateField -> input object is null, field=" + field);
                return result;
            }

            result = obj[field];

            if (result === undefined){
                Logger.add("XfwAccess::getPrivateField -> " + flash.utils.getQualifiedClassName(obj) + ", " + field + " -- FAILED");
            }

            return result;
        }

        public static function setPrivateField(obj:*, field:String, val:*): Boolean
        {
            var result:* = null;
            if (obj == null) {
                Logger.add("XfwAccess::setPrivateField -> input object is null, field=" + field);
                return false;
            }

            try{
                obj[field] = val;
            }
            catch (ex:Error)
            {
                Logger.add("XfwAccess::setPrivateField -> " + flash.utils.getQualifiedClassName(obj) + ", " + field + " -- FAILED");
                Logger.err(ex);
                return false;
            }

            return true;
        }
    }
}
