/**
 * XVM Macro substitutions
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.utils
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import com.xvm.types.stat.*;
    import com.xvm.types.veh.*;
    import flash.utils.*;
    import org.idmedia.as3commons.util.StringUtils;

    public class Macros
    {
        // { PlayerName: { macro1: func || value, macro2:... }, PlayerName: {...} }
        private static var dict:Object = new Object();
        public static var globals:Object = new Object();

        public static function Format(playerName:String, format:String, options:MacrosFormatOptions = null):String
        {
            //Logger.add("format:" + format + " player:" + playerName);

            var res:String = "";
            try
            {
                if (options == null)
                    options = new MacrosFormatOptions();

                var formatArr:Array = format.split("{{");

                res = formatArr[0];
                var len:int = formatArr.length;
                if (len > 1)
                {
                    var name:String = WGUtils.GetPlayerName(playerName);
                    for (var i:int = 1; i < len; ++i)
                    {
                        var part:String = formatArr[i];
                        var arr2:Array = part.split("}}", 2);
                        var macro:String = arr2[0];
                        if (arr2.length == 1 || (options && options.skip && options.skip.hasOwnProperty[macro]))
                        {
                            res += "{{" + part;
                        }
                        else
                        {
                            if (dict.hasOwnProperty(name))
                                res += FormatMacro(macro, dict[name], options);
                            res += arr2[1];
                        }
                    }
                }

                //Logger.add(playerName + "> " + format);
                //Logger.add(playerName + "> " + res);
                return Utils.fixImgTag(res);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
            return res;
        }

        private static function FormatMacro(macro:String, pdata:Object, options:Object):String
        {
            //Logger.addObject(pdata);
            var parts:Array = [null,null,null,null];

            // split parts: name[%fmt][~suf][|def]
            var macroArr:Array = macro.split("");
            var len:int = macroArr.length;
            var part:String = "";
            var section:int = 0;
            for (var i:int = 0; i < len; ++i)
            {
                var ch:String = macroArr[i];
                switch (ch)
                {
                    case "%":
                        if (section < 1)
                        {
                            parts[section] = part;
                            section = 1;
                            part = "";
                            continue;
                        }
                        break;
                    case "~":
                        if (section < 2)
                        {
                            parts[section] = part;
                            section = 2;
                            part = "";
                            continue;
                        }
                        break;
                    case "|":
                        if (section < 3)
                        {
                            parts[section] = part;
                            section = 3;
                            part = "";
                            continue;
                        }
                        break;
                }
                part += ch;
            }
            parts[section] = part;

            var name:String = parts[0];
            var fmt:String = parts[1];
            var suf:String = parts[2];
            var def:String = parts[3] || "";

            // substitute
            //Logger.add("name:" + name + " fmt:" + fmt + " suf:" + suf + " def:" + def);

            if (!pdata.hasOwnProperty(name) && !globals.hasOwnProperty(name))
                return def;

            var value:* = pdata.hasOwnProperty(name) ? pdata[name] : globals[name];
            var type:String = typeof value;
            //Logger.add("type:" + type + " value:" + value);

            if (value == null)
                return def;

            //Logger.add("name:" + name + " fmt:" + fmt + " suf:" + suf + " def:" + def + " macro:" + macro);

            if (type == "number" && isNaN(value))
                return def;

            var res:String = value;
            if (typeof value == "function")
            {
                value = options ? value(options) : "{{" + macro + "}}";
                if (value == null)
                    return def;
                type = typeof value;
                if (type == "number" && isNaN(value))
                    return def;
                res = value;
            }

            if (fmt != null)
            {
                res = Sprintf.format("%" + fmt, res);
                //Logger.add(value + "|" + res + "|");
            }

            if (suf != null)
            {
                if (type == "string")
                {
                    if (res.length - suf.length > 0)
                    {
                        // search precision
                        parts = fmt.split(".", 2);
                        if (parts.length == 2)
                        {
                            parts = parts[1].split('');
                            len = parts.length;
                            var precision:int = 0;
                            for (i = 0; i < len; ++i)
                            {
                                ch = parts[i];
                                if (ch < '0' || ch > '9')
                                    break;
                                precision = (precision * 10) + Number(ch);
                            }
                            if (value.length > precision)
                                res = res.substr(0, res.length - suf.length) + suf;
                        }
                    }
                }
                else
                {
                    res += suf;
                }
            }

            //Logger.add(res);
            return res;
        }

        // Macros registration

        public static function RegisterMinimalMacrosData(fullPlayerName:String, vid:int):void
        {
            if (fullPlayerName == null)
                throw new Error("empty name");

            var name:String = WGUtils.GetPlayerName(fullPlayerName);

            // check if already registered
            if (dict.hasOwnProperty(name))
            {
                if (dict[name]["vid"] == vid)
                    return;
            }
            else
            {
                dict[name] = new Object();
            }

            var pdata:Object = dict[name];

            var nick:String = modXvmDevLabel(name);
            var clanWithoutBrackets:String = WGUtils.GetClanNameWithoutBrackets(fullPlayerName);
            var clanWithBrackets:String = WGUtils.GetClanNameWithBrackets(fullPlayerName);

            // {{nick}}
            pdata["nick"] = nick + clanWithBrackets;
            // {{name}}
            pdata["name"] = nick;
            // {{clan}}
            pdata["clan"] = clanWithBrackets;
            // {{clannb}}
            pdata["clannb"] = clanWithoutBrackets;

            // Next macro unique for vehicle
            var vdata:VehicleData = VehicleInfo.get(vid);
            // Internal use
            pdata["vid"] = vid;
            // {{vehicle}} - T-34-85
            pdata["vehicle"] = vdata.localizedName;
            // {{vehiclename}} - ussr-T-34-85
            pdata["vehiclename"] = VehicleInfo.getVIconName(vdata.key);
            // {{level}}
            pdata["level"] = vdata.level;
            // {{rlevel}}
            pdata["rlevel"] = Defines.ROMAN_LEVEL[vdata.level - 1];
            // {{vtype}} - MT
            pdata["vtype"] = VehicleInfo.getVTypeText(vdata.vtype);
            // {{vtype-l}} - Medium Tank
            pdata["vtype-l"] = Locale.get(vdata.vtype);
            // {{c:vtype}}
            pdata["c:vtype"] = MacrosUtil.GetVClassColorValue(vdata);
            // {{battletier-min}}
            pdata["battletier-min"] = vdata.tierLo;
            // {{battletier-max}}
            pdata["battletier-max"] = vdata.tierHi;
        }

        public static function RegisterMacrosData(fullPlayerName:String):void
        {
            var pname:String = WGUtils.GetPlayerName(fullPlayerName);
            var stat:StatData = Stat.getData(pname);
            if (stat == null)
                return;

            RegisterMinimalMacrosData(stat.name + (stat.clan == null || stat.clan == "" ? "" : "[" + stat.clan + "]"), stat.v.id);

            var pdata:Object = dict[pname];

            var vdata:VehicleData = stat.v.data || new VehicleData({});

            // VMM only - static
            // {{squad}}
            //TODO pdata["squad"] = data.squad || "";
            // {{squad-num}}
            //TODO pdata["squad-num"] = data.squadnum || "";

            // {{hp-max}}
            pdata["hp-max"] = stat.maxHealth;
            // {{turret}}
            //TODO pdata["turret"] = vdata ? String(vdata.turret) : "";

            // dynamic
            // {{hp}}
            pdata["hp"] = function(o:MacrosFormatOptions):Number { return isNaN(o.curHealth) ? NaN : o.curHealth; }
            // {{hp-ratio}}
            pdata["hp-ratio"] = function(o:MacrosFormatOptions):Number { return isNaN(o.curHealth) ? NaN : o.curHealth / stat.maxHealth * 100; }
            // {{dmg}}
            pdata["dmg"] = function(o:MacrosFormatOptions):Number { return isNaN(o.delta) ? NaN : o.delta; }
            // {{dmg-ratio}}
            pdata["dmg-ratio"] = function(o:MacrosFormatOptions):Number { return isNaN(o.delta) ? NaN : Math.round(o.delta / stat.maxHealth * 100); }
            // {{dmg-kind}}
            pdata["dmg-kind"] = function(o:MacrosFormatOptions):String { return o.damageType == null ? null : Locale.get(o.damageType); }

            // Colors
            // {{c:hp}}
            pdata["c:hp"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, o.curHealth); }
            // {{c:hp-ratio}}, {{c:hp_ratio}}
            pdata["c:hp-ratio"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, o.curHealth / stat.maxHealth * 100); }
            // {{c:dmg}}
            //TODOpdata["c:dmg"] = function(o:MacrosFormatOptions):String {
            //TODO    return o.delta ? MacrosUtil.GetDmgSrcColorValue(
            //TODO        Macros.damageFlagToDamageSource(o.damageFlag),
            //TODO        o.entityName == 'teamKiller' ? (data.team + "tk") : o.entityName,
            //TODO        o.dead, o.blowedUp) : "";
            //TODO}
            // {{c:dmg-kind}}, {{c:dmg_kind}}
            pdata["c:dmg-kind"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDmgKindValue(o.damageType); }
            // {{c:system}}
            pdata["c:system"] = function(o:MacrosFormatOptions):String {
                return "#" + StringUtils.leftPad(MacrosUtil.GetSystemColor(o.entityName, o.dead, o.blowedUp).toString(16), 6, "0");
            }

            // Alpha
            // {{a:hp}}
            pdata["a:hp"] = function(o:MacrosFormatOptions):Number { return MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, o.curHealth) / 100.0; }
            // {{a:hp-ratio}}, {{a:hp_ratio}}
            pdata["a:hp-ratio"] = function(o:MacrosFormatOptions):Number {
                return MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO, Math.round(o.curHealth / stat.maxHealth * 100)) / 100.0;
            }

            // STAT

            if (Config.config.rating.showPlayersStatistics == false)
                return;

            // {{avglvl}}
            pdata["avglvl"] = stat.lvl;
            // {{xeff}}
            pdata["xeff"] = isNaN(stat.xeff) ? null : stat.xeff == 100 ? "XX" : (stat.xeff < 10 ? "0" : "") + stat.xeff;
            // {{xwn6}}
            pdata["xwn6"] = isNaN(stat.xwn6) ? null : stat.xwn6 == 100 ? "XX" : (stat.xwn6 < 10 ? "0" : "") + stat.xwn6;
            // {{xwn8}}
            pdata["xwn8"] = isNaN(stat.xwn8) ? null : stat.xwn8 == 100 ? "XX" : (stat.xwn8 < 10 ? "0" : "") + stat.xwn8;
            // {{xwn}}
            pdata["xwn"] = pdata["xwn8"];
            // {{eff}}
            pdata["eff"] = stat.e;
            // {{wn6}}
            pdata["wn6"] = stat.wn6;
            // {{wn8}}
            pdata["wn8"] = stat.wn8;
            // {{wn}}
            pdata["wn"] = pdata["wn8"];
            // {{e}}
            pdata["e"] = isNaN(stat.v.teff) ? null : stat.v.te >= 10 ? "E" : String(stat.v.te);
            // {{teff}}
            pdata["teff"] = stat.v.teff;

            // {{rating}}
            pdata["rating"] = stat.r;
            // {{battles}}
            pdata["battles"] = stat.b;
            // {{wins}}
            pdata["wins"] = stat.b;
            // {{kb}}
            pdata["kb"] = stat.b / 1000;

            // {{t-rating}}
            pdata["t-rating"] = stat.v.r;
            // {{t-battles}}
            pdata["t-battles"] = stat.v.b;
            // {{t-wins}}
            pdata["t-wins"] = stat.v.w;
            // {{t-kb}}
            pdata["t-kb"] = stat.v.b / 1000;
            // {{t-hb}}
            pdata["t-hb"] = stat.v.b / 100.0;
            // {{tdb}}
            pdata["tdb"] = stat.v.db;
            // {{tdv}}
            pdata["tdv"] = stat.v.dv;
            // {{tfb}}
            pdata["tfb"] = stat.v.fb;
            // {{tsb}}
            pdata["tsb"] = stat.v.sb;

            // Dynamic colors
            // {{c:xeff}}
            pdata["c:xeff"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xeff, "#", o.darken); }
            // {{c:xwn6}}
            pdata["c:xwn6"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn6, "#", o.darken); }
            // {{c:xwn8}}
            pdata["c:xwn8"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn8, "#", o.darken); }
            // {{c:xwn}}
            pdata["c:xwn"] = pdata["c:xwn8"]
            // {{c:eff}}
            pdata["c:eff"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, stat.e, "#", o.darken); }
            // {{c:wn6}}
            pdata["c:wn6"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN6, stat.wn6, "#", o.darken); }
            // {{c:wn8}}
            pdata["c:wn8"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, stat.wn8, "#", o.darken); }
            // {{c:wn}}
            pdata["c:wn"] = pdata["c:wn8"];
            // {{c:e}}
            pdata["c:e"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, stat.v.te, "#", o.darken); }
            // {{c:rating}}
            pdata["c:rating"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, stat.r, "#", o.darken); }
            // {{c:kb}}
            pdata["c:kb"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, stat.b / 1000.0, "#", o.darken); }
            // {{c:avglvl}}
            pdata["c:avglvl"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_AVGLVL, stat.lvl, "#", o.darken); }
            // {{c:t-rating}}
            pdata["c:t-rating"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, stat.v.r, "#", o.darken); }
            // {{c:t-battles}}
            pdata["c:t-battles"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, stat.v.b, "#", o.darken); }
            // {{c:tdb}}
            pdata["c:tdb"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, stat.v.db, "#", o.darken); }
            // {{c:tdv}}
            pdata["c:tdv"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, stat.v.dv, "#", o.darken); }
            // {{c:tfb}}
            pdata["c:tfb"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, stat.v.fb, "#", o.darken); }
            // {{c:tsb}}
            pdata["c:tsb"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, stat.v.sb, "#", o.darken); }

            // Alpha
            // {{a:xeff}}
            pdata["a:xeff"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xeff);
            // {{a:xwn6}}
            pdata["a:xwn6"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn6);
            // {{a:xwn8}}
            pdata["a:xwn8"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn8);
            // {{a:xwn}}
            pdata["a:xwn"] = pdata["a:xwn8"];
            // {{a:eff}}
            pdata["a:eff"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_EFF, stat.e);
            // {{a:wn6}}
            pdata["a:wn6"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN6, stat.wn6);
            // {{a:wn8}}
            pdata["a:wn8"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN8, stat.wn8);
            // {{a:wn}}
            pdata["a:wn"] = pdata["a:wn8"];
            // {{a:e}}
            pdata["a:e"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_E, stat.v.te);
            // {{a:rating}}
            pdata["a:rating"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_RATING, stat.r);
            // {{a:kb}}
            pdata["a:kb"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_KB, stat.b / 1000);
            // {{a:avglvl}}
            pdata["a:avglvl"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_AVGLVL, stat.lvl);
            // {{a:t-rating}}
            pdata["a:t-rating"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_RATING, stat.v.r);
            // {{a:t-battles}}
            pdata["a:t-battles"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TBATTLES, stat.v.b);
            // {{a:tdb}}
            pdata["a:tdb"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TDB, stat.v.db);
            // {{a:tdv}}
            pdata["a:tdv"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TDV, stat.v.dv);
            // {{a:tfb}}
            pdata["a:tfb"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TFB, stat.v.fb);
            // {{a:tsb}}
            pdata["a:tsb"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TSB, stat.v.sb);
        }

        public static function RegisterBattleTierData(battletier:Number):void
        {
            // {{battletier}}
            globals["battletier"] = battletier;
        }

        // PRIVATE

        private static function modXvmDevLabel(name:String):String
        {
            switch (Config.gameRegion)
            {
                case "RU":
                    if (name == "M_r_A")
                        return "Флаттершай - лучшая пони!";
                    if (name == "sirmax2" || name == "0x01" || name == "_SirMax_")
                        return "«сэр Макс» (XVM)";
                    if (name == "STL1te")
                        return "О, СТЛайт!";
                    if (name == "Mixailos")
                        return "Михаил";
                    if (name == "Yusha")
                        return "Это же PROТанки!";
                    break;

                case "CT":
                    if (name == "M_r_A_RU" || name == "M_r_A_EU")
                        return "Fluttershy is best pony!";
                    if (name == "sirmax2_RU" || name == "sirmax2_EU" || name == "sirmax_NA" || name == "0x01_RU")
                        return "«sir Max» (XVM)";
                    break;

                case "EU":
                    if (name == "M_r_A")
                        return "Fluttershy is best pony!";
                    if (name == "sirmax2" || name == "0x01" || name == "_SirMax_")
                        return "«sir Max» (XVM)";
                    break;

                case "US":
                    if (name == "sirmax" || name == "0x01" || name == "_SirMax_")
                        return "«sir Max» (XVM)";
                    break;
            }

            return name;
        }

        //   src: ally, squadman, enemy, unknown, player (allytk, enemytk - how to detect?)
        public static function damageFlagToDamageSource(damageFlag:Number):String
        {
            switch (damageFlag)
            {
                case Defines.FROM_ALLY:
                    return "ally";
                case Defines.FROM_ENEMY:
                    return "enemy";
                case Defines.FROM_PLAYER:
                    return "player";
                case Defines.FROM_SQUAD:
                    return "squadman";
                case Defines.FROM_UNKNOWN:
                default:
                    return "unknown";
            }
        }



        private static var allMacros:Array = [
            "{{nick}}", "{{name}}", "{{clan}}", "{{clannb}}", "{{vehicle}}", "{{vehiclename}}",
            "{{vtype}}", "{{c:vtype}}", "{{level}}", "{{rlevel}}", "{{squad}}", "{{turret}}",
            "{{hp}}", "{{hp-ratio}}", "{{hp-max}}", "{{dmg}}", "{{dmg-ratio}}", "{{dmg-kind}}",
            "{{c:hp}}", "{{c:hp-ratio}}", "{{c:dmg}}", "{{c:dmg-kind}}", "{{c:system}}", "{{a:hp}}",
            "{{a:hp-ratio}}", "{{n}}", "{{n-player}}", "{{dmg-total}}", "{{dmg-avg}}", "{{dmg-player}}",
            "{{dead}}", "{{points}}", "{{extra}}", "{{tanks}}", "{{time}}", "{{time-sec}}",
            "{{speed}}", "{{vehicle-class}}", "{{cellsize}}",
            "{{vehicle-short}}", "{{vtype-l}}", "{{battletier-min}}",
            "{{battletier-max}}", "{{avglvl}}", "{{eff}}", "{{eff:4}}", "{{teff}}, {{e}}",
            "{{wn6}}", "{{wn8}}", "{{xeff}}", "{{xwn6}}", "{{xwn8}}", "{{rating}}", "{{rating:3}}",
            "{{battles}}", "{{wins}}", "{{kb}}", "{{kb:3}}",
            "{{t-rating}}", "{{t-rating:3}}", "{{t-battles}}", "{{t-battles:4}}",
            "{{t-wins}}", "{{t-kb}}", "{{t-kb-0}}", "{{t-kb:4}}", "{{t-hb}}", "{{t-hb:3}}", "{{tdb}}",
            "{{tdb:4}}", "{{tdv}}", "{{tfb}}", "{{tsb}}", "{{c:tdb}}", "{{c:tdv}}", "{{c:tfb}}",
            "{{c:tsb}}", "{{c:eff}}", "{{c:e}}", "{{c:wn6}}", "{{c:wn8}}", "{{c:xeff}}", "{{c:xwn}}",
            "{{c:rating}}", "{{c:kb}}", "{{c:avglvl}}", "{{c:t-rating}}", "{{c:t-battles}}"
        ]

        public static function TestMacros(playerName:String, options:MacrosFormatOptions = null):void
        {
            Logger.add("Macros::TestMacros(" + playerName + ")");
            for (var i:int = 0; i < allMacros.length; ++i)
                Logger.add("TEST: " + allMacros[i] + " => " + Macros.Format(playerName, allMacros[i], options));
            Logger.add("");
        }
    }
}


class MacrosFormatOptions
{
    public var skip:Object = null;
    public var curHealth:int = NaN;
    public var delta:int = NaN;
    public var damageType:String = null;
    public var damageFlag:int = NaN;
    public var entityName:String = null;
    public var dead:Boolean = false;
    public var blowedUp:Boolean = false;
    public var darken:Boolean = false;
}
