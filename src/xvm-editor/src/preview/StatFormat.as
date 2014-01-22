package preview
{

import com.xvm.*;
import com.xvm.utils.*;
import preview.*;
import utils.*;

public class StatFormat
{
    public static function FormatText(format: String, isDead: Boolean):String
    {
        format = format.split("{{kb}}").join("10");
        format = format.split("{{battles}}").join("10123");
        format = format.split("{{wins}}").join("5678");
        format = format.split("{{avglvl}}").join("5%");
        format = format.split("{{xeff}}").join("32");
        format = format.split("{{xwn}}").join("23");
        format = format.split("{{eff}}").join("1230");
        format = format.split("{{wn6}}").join("1001");
        format = format.split("{{wn8}}").join("1001");
        format = format.split("{{wn}}").join("1001");
        format = format.split("{{e}}").join("5");
        format = format.split("{{rating}}").join("48%");
        format = format.split("{{teff}}").join("1024");

        format = format.split("{{tdb}}").join("1010");
        format = format.split("{{tdb:4}}").join("1010");
        format = format.split("{{tdv}}").join("0.9");
        format = format.split("{{tfb}}").join("1.0");
        format = format.split("{{tsb}}").join("1.1");

        format = format.split("{{t-kb}}").join("2.3");
        format = format.split("{{t-kb-0}}").join("02.3");
        format = format.split("{{t-hb}}").join("23");
        format = format.split("{{t-battles}}").join("2345");
        format = format.split("{{t-wins}}").join("1212");
        format = format.split("{{t-rating}}").join("55%");

        // This code is stupid, and needs to be rewritten
        format = format.split("{{kb:3}}").join(" 10");
        format = format.split("{{rating:3}}").join("48%");
        format = format.split("{{eff:4}}").join("1230");

        format = format.split("{{t-kb:4}}").join(" 2.3");
        format = format.split("{{t_kb:4}}").join(" 2.3");
        format = format.split("{{t-hb:3}}").join(" 23");
        format = format.split("{{t_hb:3}}").join(" 23");
        format = format.split("{{t-battles:4}}").join("2345");
        format = format.split("{{t_battles:4}}").join("2345");
        format = format.split("{{t-rating:3}}").join("55%");
        format = format.split("{{t_rating:3}}").join("55%");

        // Dynamic colors
        format = format.split("{{c:xeff}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, 32, "#", isDead));
        format = format.split("{{c:xwn}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, 23, "#", isDead));
        format = format.split("{{c:eff}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, 1234, "#", isDead));
        format = format.split("{{c:wn6}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN6, 1001, "#", isDead));
        format = format.split("{{c:wn8}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, 1001, "#", isDead));
        format = format.split("{{c:wn}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, 1001, "#", isDead));
        format = format.split("{{c:rating}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, 48, "#", isDead));
        format = format.split("{{c:kb}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, 10, "#", isDead));

        format = format.split("{{c:e}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, 5, "#", isDead));
        format = format.split("{{c:tdb}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, 1010, "#", isDead));
        format = format.split("{{c:tdv}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, 0.9, "#", isDead));
        format = format.split("{{c:tfb}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, 1.0, "#", isDead));
        format = format.split("{{c:tsb}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, 1.1, "#", isDead));

        format = format.split("{{c:t-rating}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, 55, "#", isDead));
        format = format.split("{{c:t_rating}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, 55, "#", isDead));
        format = format.split("{{c:t-battles}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, 2345, "#", isDead));
        format = format.split("{{c:t_battles}}").join(MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, 2345, "#", isDead));

        //format = Utils.trim(format);

        return format;
    }
}

}
