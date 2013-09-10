package net.wg.infrastructure.managers.utils.impl 
{
    import net.wg.data.constants.*;
    import net.wg.data.utilData.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    
    public class Locale extends Object implements net.wg.utils.ILocale
    {
        public function Locale()
        {
            super();
            return;
        }

        public function gold(arg1:Object):String
        {
            return this.envokeC(net.wg.data.constants.EngineMethods.GET_GOLD_FMT, Number(arg1));
        }

        public function integer(arg1:Object):String
        {
            return this.envokeC(net.wg.data.constants.EngineMethods.GET_INT_FMT, Number(arg1));
        }

        public function float(arg1:Object):String
        {
            return this.envokeC(net.wg.data.constants.EngineMethods.GET_FRAC_FMT, Number(arg1));
        }

        public function niceNumber(arg1:Object):String
        {
            var loc1:*="Call to deprecated method niceNumber in Locale." + "- it`s a bad name";
            DebugUtils.LOG_DEBUG(loc1);
            return this.numberWithoutZeros(arg1);
        }

        public function numberWithoutZeros(arg1:Object):String
        {
            return this.envokeC(net.wg.data.constants.EngineMethods.GET_NONZERO_FMT, Number(arg1));
        }

        public function parseFormattedInteger(arg1:String):net.wg.infrastructure.interfaces.IFormattedInt
        {
            var loc5:*=null;
            var loc1:*=arg1.length;
            var loc2:*="";
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                loc5 = arg1.charAt(loc3);
                if (net.wg.data.constants.Values.DIGIT.indexOf(loc5) != -1) 
                    if (loc2 != "") 
                        break;
                else 
                    loc2 = loc2 + loc5;
                ++loc3;
            }
            var loc4:*=arg1;
            if (loc2 == arg1) 
                loc2 = "";
            else 
                loc4 = arg1.split(loc2).join(net.wg.data.constants.Values.EMPTY_STR);
            return new net.wg.data.utilData.FormattedInteger(Number(loc4), loc2);
        }

        public function shortTime(arg1:Object):String
        {
            return this.envokeC(net.wg.data.constants.EngineMethods.GET_SHORT_TIME_FMT, Number(arg1));
        }

        public function longTime(arg1:Object):String
        {
            return this.envokeC(net.wg.data.constants.EngineMethods.GET_LONG_TIME_FMT, Number(arg1));
        }

        public function shortDate(arg1:Object):String
        {
            return this.envokeC(net.wg.data.constants.EngineMethods.GET_SHORT_DATE_FMT, Number(arg1));
        }

        public function longDate(arg1:Object):String
        {
            return this.envokeC(net.wg.data.constants.EngineMethods.GET_LONG_DATE_FMT, Number(arg1));
        }

        public function makeString(arg1:String, arg2:Object=null):String
        {
            if (arg2 == null) 
                arg2 = {};
            return this.envokeCFormatted(net.wg.data.constants.EngineMethods.GET_FMTED_LCLZED_STR, arg1, App.utils.JSON.encode(arg2));
        }

        internal function envokeC(arg1:String, arg2:Object):String
        {
            return String(App.environment.call(arg1, arg2));
        }

        internal function envokeCFormatted(arg1:String, arg2:Object, arg3:Object):*
        {
            return App.environment.call(arg1, arg2, arg3);
        }

        public function htmlTextWithIcon(arg1:String, arg2:String):String
        {
            var loc1:*=0;
            if (arg2 != net.wg.data.constants.Currencies.CREDITS) 
                if (arg2 == net.wg.data.constants.Currencies.GOLD) 
                {
                    loc1 = App.colorSchemeMgr.getRGB(net.wg.data.constants.ColorSchemeNames.TEXT_COLOR_GOLD);
                    arg2 = "Gold";
                }
            else 
            {
                loc1 = App.colorSchemeMgr.getRGB(net.wg.data.constants.ColorSchemeNames.TEXT_COLOR_CREDITS);
                arg2 = "Credits";
            }
            return "<font color=\"#" + loc1.toString(16) + "\" >" + arg1 + "</font>  <img src=\"" + ICON_DEF_PATH + arg2 + "Icon-2.png\" width=\"16\" height=\"16\" vspace=\"-4\" hspace=\"0\"/>";
        }

        internal static const ICON_DEF_PATH:String="img://gui/maps/icons/library/";
    }
}
