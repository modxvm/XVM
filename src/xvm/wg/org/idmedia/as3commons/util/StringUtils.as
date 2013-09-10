package org.idmedia.as3commons.util
{
    import org.idmedia.as3commons.lang.*;

    public class StringUtils extends Object
    {
        public function StringUtils()
        {
            super();
            return;
        }

        public static function startsWith(arg1:String, arg2:String):Boolean
        {
            return testString(arg1, new RegExp("^" + arg2, EMPTY));
        }

        public static function compareToIgnoreCase(arg1:String, arg2:String):int
        {
            if (arg1 == null || arg2 == null)
                throw new org.idmedia.as3commons.lang.NullPointerException();
            return compareTo(arg1.toLowerCase(), arg2.toLowerCase());
        }

        public static function compareTo(arg1:String, arg2:String):int
        {
            if (arg1 == null || arg2 == null)
                throw new org.idmedia.as3commons.lang.NullPointerException();
            return arg1.localeCompare(arg2);
        }

        public static function toInitials(arg1:String):String
        {
            if (isEmpty(arg1))
                return arg1;
            return arg1.match(new RegExp("[A-Z]", "g")).join(EMPTY).toLowerCase();
        }

        public static function chomp(arg1:String):String
        {
            return chompString(arg1, "(\r\n|\r|\n)");
        }

        public static function chompString(arg1:String, arg2:String):String
        {
            if (isEmpty(arg1) || arg2 == null)
                return arg1;
            return arg1.replace(new RegExp(arg2 + "$", EMPTY), EMPTY);
        }

        public static function trim(arg1:String):String
        {
            if (arg1 == null)
                return null;
            return arg1.replace(new RegExp("^\\s*"), EMPTY).replace(new RegExp("\\s*$"), EMPTY);
        }

        public static function deleteSpaces(arg1:String):String
        {
            return deleteFromString(arg1, new RegExp("\\t|\\r|\\n|\\b", "g"));
        }

        public static function deleteWhitespace(arg1:String):String
        {
            return deleteFromString(arg1, new RegExp("\\s", "g"));
        }

        internal static function deleteFromString(arg1:String, arg2:RegExp):String
        {
            if (isEmpty(arg1))
                return arg1;
            return arg1.replace(arg2, EMPTY);
        }

        public static function left(str:String, len:int):String
        {
            if (str == null)
                return null;
            if (len < 0)
                return EMPTY;
            if (str.length <= len)
                return str;
            return str.substring(0, len);
        }

        public static function center(arg1:String, arg2:int, arg3:String):String
        {
            if (arg1 == null || arg2 <= 0)
                return arg1;
            if (isEmpty(arg3))
                arg3 = " ";
            var loc1:*=arg1.length;
            var loc2:*;
            if ((loc2 = arg2 - loc1) <= 0)
                return arg1;
            arg1 = leftPad(arg1, loc1 + loc2 / 2, arg3);
            arg1 = rightPad(arg1, arg2, arg3);
            return arg1;
        }

        public static function leftPad(arg1:String, arg2:int, arg3:String):String
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=0;
            if (arg1 == null)
                return null;
            if (isEmpty(arg3))
                arg3 = " ";
            var loc1:*=arg3.length;
            var loc2:*=arg1.length;
            var loc3:*;
            if ((loc3 = arg2 - loc2) <= 0)
                return arg1;
            if (loc1 == 1 && loc3 <= PAD_LIMIT)
                return leftPadChar(arg1, arg2, arg3.charAt(0));
            if (loc3 == loc1)
                return arg3.concat(arg1);
            if (loc3 < loc1)
                return arg3.substring(0, loc3).concat(arg1);
            loc4 = new Array();
            loc5 = arg3.split("");
            loc6 = 0;
            while (loc6 < loc3)
            {
                loc4[loc6] = loc5[loc6 % loc1];
                ++loc6;
            }
            return loc4.join("").concat(arg1);
        }

        public static function leftPadChar(arg1:String, arg2:int, arg3:String):String
        {
            if (arg1 == null)
                return null;
            var loc1:*;
            if ((loc1 = arg2 - arg1.length) <= 0)
                return arg1;
            if (loc1 > PAD_LIMIT)
                return leftPad(arg1, arg2, arg3);
            return padding(loc1, arg3).concat(arg1);
        }

        public static function rightPad(arg1:String, arg2:int, arg3:String):String
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=0;
            if (arg1 == null)
                return null;
            if (isEmpty(arg3))
                arg3 = " ";
            var loc1:*=arg3.length;
            var loc2:*=arg1.length;
            var loc3:*;
            if ((loc3 = arg2 - loc2) <= 0)
                return arg1;
            if (loc1 == 1 && loc3 <= PAD_LIMIT)
                return rightPadChar(arg1, arg2, arg3.charAt(0));
            if (loc3 == loc1)
                return arg1.concat(arg3);
            if (loc3 < loc1)
                return arg1.concat(arg3.substring(0, loc3));
            loc4 = new Array();
            loc5 = arg3.split("");
            loc6 = 0;
            while (loc6 < loc3)
            {
                loc4[loc6] = loc5[loc6 % loc1];
                ++loc6;
            }
            return arg1.concat(loc4.join(""));
        }

        public static function rightPadChar(arg1:String, arg2:int, arg3:String):String
        {
            if (arg1 == null)
                return null;
            var loc1:*;
            if ((loc1 = arg2 - arg1.length) <= 0)
                return arg1;
            if (loc1 > PAD_LIMIT)
                return rightPad(arg1, arg2, arg3);
            return arg1.concat(padding(loc1, arg3));
        }

        internal static function padding(arg1:int, arg2:String):String
        {
            var loc1:*=EMPTY;
            var loc2:*=0;
            while (loc2 < arg1)
            {
                loc1 = loc1 + arg2;
                ++loc2;
            }
            return loc1;
        }

        public static function replace(arg1:String, arg2:String, arg3:String):String
        {
            if (arg1 == null || isEmpty(arg2) || arg3 == null)
                return arg1;
            return arg1.replace(new RegExp(arg2, "g"), arg3);
        }

        public static function replaceTo(arg1:String, arg2:String, arg3:String, arg4:int):String
        {
            if (arg1 == null || isEmpty(arg2) || arg3 == null || arg4 == 0)
                return arg1;
            var loc1:*="";
            var loc2:*=0;
            var loc3:*=0;
            for (;;)
            {
                var loc4:*;
                loc3 = loc4 = arg1.indexOf(arg2, loc2);
                if (loc4 == -1)
                    break;
                loc1 = loc1 + (arg1.substring(loc2, loc3) + arg3);
                loc2 = loc3 + arg2.length;
                if (--arg4 != 0)
                    continue;
                break;
            }
            loc1 = loc4 = loc1 + arg1.substring(loc2);
            return loc4;
        }

        public static function replaceOnce(arg1:String, arg2:String, arg3:String):String
        {
            if (arg1 == null || isEmpty(arg2) || arg3 == null)
                return arg1;
            return arg1.replace(new RegExp(arg2, EMPTY), arg3);
        }

        public static function defaultIfEmpty(arg1:String, arg2:String):String
        {
            return isEmpty(arg1) ? arg2 : arg1;
        }

        public static function isEmpty(arg1:String):Boolean
        {
            if (arg1 == null)
                return true;
            return arg1.length == 0;
        }

        public static function isNotEmpty(arg1:String):Boolean
        {
            return !isEmpty(arg1);
        }

        public static function isBlank(arg1:String):Boolean
        {
            return isEmpty(trimToEmpty(arg1));
        }

        public static function isNotBlank(arg1:String):Boolean
        {
            return !isBlank(arg1);
        }

        public static function trimToNull(arg1:String):String
        {
            var loc1:*=trim(arg1);
            return isEmpty(loc1) ? null : loc1;
        }

        public static function trimToEmpty(arg1:String):String
        {
            return arg1 != null ? trim(arg1) : EMPTY;
        }

        public static function capitalize(arg1:String):String
        {
            if (isEmpty(arg1))
                return arg1;
            return arg1.charAt(0).toUpperCase() + arg1.substring(1);
        }

        public static function uncapitalize(arg1:String):String
        {
            if (isEmpty(arg1))
                return arg1;
            return arg1.charAt(0).toLowerCase() + arg1.substring(1);
        }

        public static function titleize(arg1:String):String
        {
            if (isEmpty(arg1))
                return arg1;
            var loc1:*=arg1.toLowerCase().split(" ");
            var loc2:*=0;
            while (loc2 < loc1.length)
            {
                loc1[loc2] = capitalize(loc1[loc2]);
                ++loc2;
            }
            return loc1.join(" ");
        }

        public static function substringAfter(arg1:String, arg2:String):String
        {
            if (isEmpty(arg1))
                return arg1;
            if (arg2 == null)
                return EMPTY;
            var loc1:*=arg1.indexOf(arg2);
            if (loc1 == INDEX_NOT_FOUND)
                return EMPTY;
            return arg1.substring(loc1 + arg2.length);
        }

        public static function substringAfterLast(arg1:String, arg2:String):String
        {
            if (isEmpty(arg1))
                return arg1;
            if (isEmpty(arg2))
                return EMPTY;
            var loc1:*=arg1.lastIndexOf(arg2);
            if (loc1 == INDEX_NOT_FOUND || loc1 == arg1.length - arg2.length)
                return EMPTY;
            return arg1.substring(loc1 + arg2.length);
        }

        public static function substringBefore(arg1:String, arg2:String):String
        {
            if (isEmpty(arg1) || arg2 == null)
                return arg1;
            if (arg2.length == 0)
                return EMPTY;
            var loc1:*=arg1.indexOf(arg2);
            if (loc1 == INDEX_NOT_FOUND)
                return arg1;
            return arg1.substring(0, loc1);
        }

        public static function substringBeforeLast(arg1:String, arg2:String):String
        {
            if (isEmpty(arg1) || isEmpty(arg2))
                return arg1;
            var loc1:*=arg1.lastIndexOf(arg2);
            if (loc1 == INDEX_NOT_FOUND)
                return arg1;
            return arg1.substring(0, loc1);
        }

        public static function substringBetween(arg1:String, arg2:String, arg3:String):String
        {
            var loc2:*=0;
            if (arg1 == null || arg2 == null || arg3 == null)
                return null;
            var loc1:*;
            if ((loc1 = arg1.indexOf(arg2)) != INDEX_NOT_FOUND)
                if ((loc2 = arg1.indexOf(arg3, loc1 + arg2.length)) != INDEX_NOT_FOUND)
                    return arg1.substring(loc1 + arg2.length, loc2);
            return null;
        }

        public static function strip(arg1:String, arg2:String):String
        {
            if (isEmpty(arg1))
                return arg1;
            return stripEnd(stripStart(arg1, arg2), arg2);
        }

        public static function stripStart(arg1:String, arg2:String):String
        {
            if (isEmpty(arg1))
                return arg1;
            var loc1:*=new RegExp("^[" + (arg2 || " ") + "]*", EMPTY);
            return arg1.replace(loc1, EMPTY);
        }

        public static function stripEnd(arg1:String, arg2:String):String
        {
            if (isEmpty(arg1))
                return arg1;
            var loc1:*=new RegExp("[" + (arg2 || " ") + "]*$", EMPTY);
            return arg1.replace(loc1, EMPTY);
        }

        public static function abbreviate(arg1:String, arg2:int, arg3:int):String
        {
            if (arg1 == null)
                return arg1;
            if (arg3 < 4)
                throw new org.idmedia.as3commons.lang.IllegalArgumentException("Minimum abbreviation width is 4");
            if (arg1.length <= arg3)
                return arg1;
            if (arg2 > arg1.length)
                arg2 = arg1.length;
            if (arg1.length - arg2 < arg3 - 3)
                arg2 = arg1.length - (arg3 - 3);
            if (arg2 <= 4)
                return arg1.substring(0, arg3 - 3) + "...";
            if (arg3 < 7)
                throw new org.idmedia.as3commons.lang.IllegalArgumentException("Minimum abbreviation width with offset is 7");
            if (arg2 + (arg3 - 3) < arg1.length)
                return "..." + abbreviate(arg1.substring(arg2), 0, arg3 - 3);
            return "..." + arg1.substring(arg1.length - (arg3 - 3));
        }

        public static function ordinalIndexOf(arg1:String, arg2:String, arg3:int):int
        {
            if (arg1 == null || arg2 == null || arg3 <= 0)
                return INDEX_NOT_FOUND;
            if (arg2.length == 0)
                return 0;
            var loc1:*=0;
            var loc2:*=INDEX_NOT_FOUND;
            do
            {
                if ((loc2 = arg1.indexOf(arg2, loc2 + 1)) < 0)
                    return loc2;
                ++loc1;
            }
            while (loc1 < arg3);
            return loc2;
        }

        public static function countMatches(arg1:String, arg2:String):int
        {
            if (isEmpty(arg1) || isEmpty(arg2))
                return 0;
            return arg1.match(new RegExp("(" + arg2 + ")", "g")).length;
        }

        public static function contains(arg1:String, arg2:String):Boolean
        {
            if (arg1 == null || arg2 == null)
                return false;
            return new RegExp("(" + arg2 + ")", "g").test(arg1);
        }

        public static function containsNone(arg1:String, arg2:String):Boolean
        {
            if (isEmpty(arg1) || arg2 == null)
                return true;
            return new RegExp("^[^" + arg2 + "]*$", EMPTY).test(arg1);
        }

        public static function containsOnly(arg1:String, arg2:String):Boolean
        {
            if (arg1 == null || isEmpty(arg2))
                return false;
            if (arg1.length == 0)
                return true;
            return new RegExp("^[" + arg2 + "]*$", "g").test(arg1);
        }

        public static function indexOfAny(arg1:String, arg2:String):int
        {
            if (isEmpty(arg1) || isEmpty(arg2))
                return INDEX_NOT_FOUND;
            return arg1.search(new RegExp("[" + arg2 + "]", EMPTY));
        }

        public static function indexOfAnyBut(arg1:String, arg2:String):int
        {
            if (isEmpty(arg1) || isEmpty(arg2))
                return INDEX_NOT_FOUND;
            return arg1.search(new RegExp("[^" + arg2 + "]", EMPTY));
        }

        public static function difference(arg1:String, arg2:String):String
        {
            if (arg1 == null)
                return arg2;
            if (arg2 == null)
                return arg1;
            var loc1:*=indexOfDifference(arg1, arg2);
            if (loc1 == -1)
                return EMPTY;
            return arg2.substring(loc1);
        }

        public static function indexOfDifference(arg1:String, arg2:String):int
        {
            var loc1:*=0;
            if (arg1 == arg2)
                return INDEX_NOT_FOUND;
            if (isEmpty(arg1) || isEmpty(arg2))
                return 0;
            loc1 = 0;
            while (loc1 < arg1.length && loc1 < arg2.length)
            {
                if (arg1.charAt(loc1) != arg2.charAt(loc1))
                    break;
                ++loc1;
            }
            if (loc1 < arg2.length || loc1 < arg1.length)
                return loc1;
            return INDEX_NOT_FOUND;
        }

        public static function equals(arg1:String, arg2:String):Boolean
        {
            return new RegExp(arg1, EMPTY).test(arg2);
        }

        public static function equalsIgnoreCase(arg1:String, arg2:String):Boolean
        {
            return new RegExp(arg1, "i").test(arg2);
        }

        public static function isAlpha(arg1:String):Boolean
        {
            return testString(arg1, new RegExp("^[a-zA-Z]*$"));
        }

        public static function isAlphaSpace(arg1:String):Boolean
        {
            return testString(arg1, new RegExp("^[a-zA-Z\\s]*$"));
        }

        public static function isAlphanumeric(arg1:String):Boolean
        {
            return testString(arg1, new RegExp("^[a-zA-Z0-9]*$"));
        }

        public static function isAlphanumericSpace(arg1:String):Boolean
        {
            return testString(arg1, new RegExp("^[a-zA-Z0-9\\s]*$"));
        }

        public static function isNumeric(arg1:String):Boolean
        {
            return testString(arg1, new RegExp("^[0-9]*$"));
        }

        public static function isDigit(arg1:String):Boolean
        {
            return testString(arg1, new RegExp("\\d+"));
        }

        public static function isNumericSpace(arg1:String):Boolean
        {
            return testString(arg1, new RegExp("^[0-9\\s]*$"));
        }

        public static function isWhitespace(arg1:String):Boolean
        {
            return testString(arg1, new RegExp("^[\\s]*$"));
        }

        internal static function testString(arg1:String, arg2:RegExp):Boolean
        {
            return !(arg1 == null) && arg2.test(arg1);
        }

        public static function overlay(arg1:String, arg2:String, arg3:int, arg4:int):String
        {
            var loc2:*=0;
            if (arg1 == null)
                return null;
            if (arg2 == null)
                arg2 = EMPTY;
            var loc1:*=arg1.length;
            if (arg3 < 0)
                arg3 = 0;
            if (arg3 > loc1)
                arg3 = loc1;
            if (arg4 < 0)
                arg4 = 0;
            if (arg4 > loc1)
                arg4 = loc1;
            if (arg3 > arg4)
            {
                loc2 = arg3;
                arg3 = arg4;
                arg4 = loc2;
            }
            return arg1.substring(0, arg3).concat(arg2).concat(arg1.substring(arg4));
        }

        public static function remove(arg1:String, arg2:String):String
        {
            return safeRemove(arg1, new RegExp(arg2, "g"));
        }

        public static function removeEnd(arg1:String, arg2:String):String
        {
            return safeRemove(arg1, new RegExp(arg2 + "$", EMPTY));
        }

        public static function removeStart(arg1:String, arg2:String):String
        {
            return safeRemove(arg1, new RegExp("^" + arg2, EMPTY));
        }

        internal static function safeRemove(arg1:String, arg2:RegExp):String
        {
            if (isEmpty(arg1))
                return arg1;
            return arg1.replace(arg2, EMPTY);
        }

        public static function endsWith(str:String, substr:String):Boolean
        {
            return testString(str, new RegExp(substr + "$", EMPTY));
        }

        internal static const EMPTY:String="";

        internal static const INDEX_NOT_FOUND:int=-1;

        internal static const PAD_LIMIT:uint=8192;
    }
}
