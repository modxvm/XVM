/**
 * XVM Macro substitutions
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.utils
{
    import com.xvm.*;
    import com.xvm.io.*;
    import com.xvm.types.*;
    import com.xvm.utils.*;
    import com.xvm.types.stat.*;
    import com.xvm.types.veh.*;
    import flash.utils.*;
    import org.idmedia.as3commons.util.*;

    public class Macros
    {
        private static var macros_cache:Object = { };
        private static var dict:Object = new Object(); //{ PLAYERNAME1: { macro1: func || value, macro2:... }, PLAYERNAME2: {...} }
        private static var globals:Object = new Object();
        public static var comments:Object = null;

        /**
         * Format string with macros substitutions
         * @param pname player name without extra tags (clan, region, etc)
         * @param format string template
         * @param options data for dynamic values
         * @return Formatted string
         */
        public static function Format(pname:String, format:String, options:MacrosFormatOptions = null):String
        {
            //Logger.add("format:" + format + " player:" + pname);
            if (format == null || format == "")
                return "";

            if (format.indexOf("{{") < 0)
                return Utils.fixImgTag(format);

            try
            {
                if (options == null)
                    options = new MacrosFormatOptions();

                // Check cached value
                var player_cache:Object;
                var dead_value:String;
                if (pname != null && pname != "")
                {
                    player_cache = macros_cache[pname];
                    if (player_cache == null)
                    {
                        macros_cache[pname] = { alive: { }, dead: { }};
                        player_cache = macros_cache[pname];
                    }
                    dead_value = (options.alive == true) ? "alive" : "dead";
                    var cached_value:* = player_cache[dead_value][format];
                    if (cached_value !== undefined)
                    {
                        //Logger.add("cached: " + cached_value);
                        return cached_value;
                    }
                }

                // Split tags
                var formatArr:Array = format.split("{{");

                var res:String = formatArr[0];
                var len:int = formatArr.length;
                var isStaticMacro:Boolean = true;
                if (len > 1)
                {
                    for (var i:int = 1; i < len; ++i)
                    {
                        var part:String = formatArr[i];
                        var arr2:Array = part.split("}}", 2);
                        var macro:String = arr2[0];
                        if (arr2.length == 1 || (options.skip && options.skip.hasOwnProperty[macro]))
                        {
                            res += "{{" + part;
                        }
                        else
                        {
                            // Process tag
                            var pdata:* = pname == null ? globals : dict[pname];
                            if (pdata != null)
                            {
                                var parts:Array = GetMacroParts(macro, pdata);

                                var macroName:String = parts[0];
                                var norm:String = parts[1];
                                var def:String = parts[5];

                                var dotPos:int = macroName.indexOf(".");
                                if (dotPos > 0 && options != null)
                                {
                                    options.__subname = macroName.slice(dotPos + 1);
                                    macroName = parts[0] = macroName.slice(0, dotPos);
                                }

                                var value:* = pdata[macroName];

                                if (value === undefined)
                                    value = globals[macroName];

                                //Logger.add("macroname:" + macroName + "| norm:" + norm + "| def:" + def + "| value:" + value + "| format:" + format);

                                if (value === undefined)
                                {
                                    //process l10n macro
                                    if (macroName.indexOf("l10n") == 0)
                                        res += prepareValue(NaN, macroName, norm, def, pdata);
                                    else
                                        res += def;
                                    isStaticMacro = false;
                                }
                                else if (value == null)
                                {
                                    //Logger.add(macroName + " " + norm + " " + def + "  " + format);
                                    res += prepareValue(NaN, macroName, norm, def, pdata);
                                }
                                else
                                {
                                    // is static macro
                                    var type:String = typeof value;
                                    if (type == "function" && macroName != "alive")
                                        isStaticMacro = false;

                                    res += FormatMacro(macro, parts, value, pdata, options);
                                }
                            }
                            res += arr2[1];
                        }
                    }
                }

                res = Utils.fixImgTag(res);

                if (isStaticMacro)
                {
                    if (pname != null && pname != "")
                        player_cache[dead_value][format] = res;
                }
                //else
                //    Logger.add(pname + "> " + format);

                //Logger.add(pname + "> " + format);
                //Logger.add(pname + "> " + res);
                return res;
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
            return "";
        }

        private static function GetMacroParts(macro:String, pdata:Object):Array
        {
            //Logger.addObject(pdata);
            var parts:Array = [null,null,null,null,null,null];

            // split parts: name[:norm][%[flag][width][.prec]type][~suf][?rep][|def]
            var macroArr:Array = macro.split("");
            var len:Number = macroArr.length;
            var part:String = "";
            var section:Number = 0;
            for (var i:Number = 0; i < len; ++i)
            {
                var ch:String = macroArr[i];
                switch (ch)
                {
                    case ":":
                        if (section < 1 && ( pdata.hasOwnProperty(part) || (macro.indexOf("l10n") == 0) ) )
                        {
                            parts[section] = part;
                            section = 1;
                            part = "";
                            continue;
                        }
                        break;
                    case "%":
                        if (section < 2)
                        {
                            parts[section] = part;
                            section = 2;
                            part = "";
                            continue;
                        }
                        break;
                    case "~":
                        if (section < 3)
                        {
                            parts[section] = part;
                            section = 3;
                            part = "";
                            continue;
                        }
                        break;
                    case "?":
                        if (section < 4)
                        {
                            parts[section] = part;
                            section = 4;
                            part = "";
                            continue;
                        }
                        break;
                    case "|":
                        if (section < 5)
                        {
                            parts[section] = part;
                            section = 5;
                            part = "";
                            continue;
                        }
                        break;
                }
                part += ch;
            }
            parts[section] = part;

            if (parts[5] == null)
                parts[5] = "";

            //Logger.add("[AS2][MACROS][GetMacroParts]: [0]:" + parts[0] +"| [1]:" + parts[1] +"| [2]:" + parts[2] +"| [3]:" + parts[3] +"| [4]:" + parts[4] +"| [5]:" + parts[5]);
            return parts;
        }

        private static function FormatMacro(macro:String, parts:Array, value:*, pdata:Object, options:Object):String
        {
            var name:String = parts[0];
            var norm:String = parts[1];
            var fmt:String = parts[2];
            var suf:String = parts[3];
            var rep:String = parts[4];
            var def:String = parts[5];

            // substitute
            //Logger.add("name:" + name + " norm:" + norm + " fmt:" + fmt + " suf:" + suf + " rep:" + rep + " def:" + def);

            var type:String = typeof value;
            //Logger.add("type:" + type + " value:" + value + " name:" + name + " fmt:" + fmt + " suf:" + suf + " def:" + def + " macro:" + macro);

            if (type == "number" && isNaN(value))
                return prepareValue(NaN, name, norm, def, pdata);

            var res:String = value;
            if (type == "function")
            {
                if (options == null)
                    return "{{" + macro + "}}";
                value = value(options);
                if (value == null)
                    return prepareValue(NaN, name, norm, def, pdata);
                type = typeof value;
                if (type == "number" && isNaN(value))
                    return prepareValue(NaN, name, norm, def, pdata);
                res = value;
            }

            if (rep != null)
                return rep;

            if (norm != null && type == "number")
                res = prepareValue(value, name, norm, def, pdata);

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
                            var len:Number = parts.length;
                            var precision:Number = 0;
                            for (var i:Number = 0; i < len; ++i)
                            {
                                var ch:String = parts[i];
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

        private static function prepareValue(value:Number, name:String, norm:String, def:String, pdata:Object):String
        {
            if (norm == null)
                return def;

            var res:String = def;
            switch (name)
            {
                case "hp":
                case "hp-max":
                    if (Config.config.battle.allowHpInPanelsAndMinimap == false)
                        break;
                    if (isNaN(value))
                    {
                        var vdata:VehicleData = VehicleInfo.get(pdata["veh-id"]);
                        if (vdata == null)
                            break;
                        value = vdata.hpTop;
                    }
                    res = Math.round(parseInt(norm) * value / Defines.MAX_BATTLETIER_HPS[globals["battletier"] - 1]).toString();
                    //Logger.add("res: " + res);
                    break;
                case "hp-ratio":
                    if (Config.config.battle.allowHpInPanelsAndMinimap == false)
                        break;
                    if (isNaN(value))
                        value = 100;
                    res = Math.round(parseInt(norm) * value / 100).toString();
                    break;
                case "l10n":
                    res = Locale.get(norm);
                    break;
            }

            return res;
        }

        public static function getGlobalValue(key:String):*
        {
            return globals[key];
        }

        // Macros registration

        /**
         * Register minimal macros values for player
         * @param fullPlayerName full player name with extra tags (clan, region, etc)
         * @param vid vehicle id
         */
        public static function RegisterMinimalMacrosData(playerId:Number, fullPlayerName:String, vid:int):void
        {
            if (fullPlayerName == null || fullPlayerName == "")
                throw new Error("empty name");

            var pname:String = WGUtils.GetPlayerName(fullPlayerName);

            // check if already registered
            if (dict.hasOwnProperty(pname))
            {
                if (dict[pname]["vid"] == vid)
                    return;
            }
            else
            {
                dict[pname] = new Object();
            }

            var pdata:Object = dict[pname];

            var nick:String = getCustomPlayerName(pname, playerId);
            var clanIdx:int = nick.indexOf("[");
            if (clanIdx > 0)
            {
                fullPlayerName = nick;
                nick = StringUtils.trim(nick.slice(0, clanIdx));
            }
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
            // {{hp-max}}
            pdata["hp-max"] = vdata.hpTop;

            // Dynamic macros

            if (!pdata.hasOwnProperty("alive"))
            {
                // {{alive}}
                pdata["alive"] = function(o:MacrosFormatOptions):String { return o.alive ? 'alive' : null; }
                // {{ready}}
                pdata["ready"] = function(o:MacrosFormatOptions):String { return o.ready ? 'ready' : null; }
                // {{player}}
                pdata["player"] = function(o:MacrosFormatOptions):String { return o.isCurrentPlayer ? 'pl' : null; }
                // {{squad}}
                pdata["squad"] = function(o:MacrosFormatOptions):String { return o.isCurrentSquad ? 'sq' : null; }
                // {{tk}}
                pdata["tk"] = function(o:MacrosFormatOptions):String { return o.isTeamKiller ? 'tk' : null; }
                // {{squad}}
                pdata["squad"] = function(o:MacrosFormatOptions):String { return o.isCurrentSquad ? 'sq' : null; }
                // {{squad-num}}
                pdata["squad-num"] = function(o:MacrosFormatOptions):Number { return o.squadIndex <= 0 ? NaN : o.squadIndex; }
            }
        }

        /**
         * Register stat macros values for player
         * @param pname player name without extra tags (clan, region, etc)
         */
        public static function RegisterStatMacrosData(pname:String):void
        {
            var stat:StatData = Stat.getData(pname);
            if (stat == null)
                return;

            RegisterMinimalMacrosData(stat._id, stat.name + (stat.clan == null || stat.clan == "" ? "" : "[" + stat.clan + "]"), stat.v.id);

            var pdata:Object = dict[pname];

            if (Config.networkServicesSettings.servicesActive == false)
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
            // {{xwgr}}
            pdata["xwgr"] = isNaN(stat.xwgr) ? null : stat.xwgr == 100 ? "XX" : (stat.xwgr < 10 ? "0" : "") + stat.xwgr;
            // {{eff}}
            pdata["eff"] = stat.e;
            // {{wn6}}
            pdata["wn6"] = stat.wn6;
            // {{wn8}}
            pdata["wn8"] = stat.wn8;
            // {{wn}}
            pdata["wn"] = pdata["wn8"];
            // {{wgr}}
            pdata["wgr"] = stat.wgr;
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
            pdata["c:xeff"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xeff, "#"); }
            // {{c:xwn6}}
            pdata["c:xwn6"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn6, "#"); }
            // {{c:xwn8}}
            pdata["c:xwn8"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn8, "#"); }
            // {{c:xwn}}
            pdata["c:xwn"] = pdata["c:xwn8"]
            // {{c:xwgr}}
            pdata["c:xwgr"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwgr, "#"); }
            // {{c:eff}}
            pdata["c:eff"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, stat.e, "#"); }
            // {{c:wn6}}
            pdata["c:wn6"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN6, stat.wn6, "#"); }
            // {{c:wn8}}
            pdata["c:wn8"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, stat.wn8, "#"); }
            // {{c:wn}}
            pdata["c:wn"] = pdata["c:wn8"];
            // {{c:wgr}}
            pdata["c:wgr"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WGR, stat.wgr, "#"); }
            // {{c:e}}
            pdata["c:e"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, stat.v.te, "#"); }
            // {{c:rating}}
            pdata["c:rating"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, stat.r, "#"); }
            // {{c:kb}}
            pdata["c:kb"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, stat.b / 1000.0, "#"); }
            // {{c:avglvl}}
            pdata["c:avglvl"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_AVGLVL, stat.lvl, "#"); }
            // {{c:t-rating}}
            pdata["c:t-rating"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, stat.v.r, "#"); }
            // {{c:t-battles}}
            pdata["c:t-battles"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, stat.v.b, "#"); }
            // {{c:tdb}}
            pdata["c:tdb"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, stat.v.db, "#"); }
            // {{c:tdv}}
            pdata["c:tdv"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, stat.v.dv, "#"); }
            // {{c:tfb}}
            pdata["c:tfb"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, stat.v.fb, "#"); }
            // {{c:tsb}}
            pdata["c:tsb"] = function(o:MacrosFormatOptions):String { return MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, stat.v.sb, "#"); }

            // Alpha
            // {{a:xeff}}
            pdata["a:xeff"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xeff);
            // {{a:xwn6}}
            pdata["a:xwn6"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn6);
            // {{a:xwn8}}
            pdata["a:xwn8"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn8);
            // {{a:xwn}}
            pdata["a:xwn"] = pdata["a:xwn8"];
            // {{a:xwgr}}
            pdata["a:xwgr"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwgr);
            // {{a:eff}}
            pdata["a:eff"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_EFF, stat.e);
            // {{a:wn6}}
            pdata["a:wn6"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN6, stat.wn6);
            // {{a:wn8}}
            pdata["a:wn8"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN8, stat.wn8);
            // {{a:wn}}
            pdata["a:wn"] = pdata["a:wn8"];
            // {{a:wgr}}
            pdata["a:wgr"] = MacrosUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WGR, stat.wgr);
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

        public static function RegisterVehiclesMacros():void
        {
            if (!globals.hasOwnProperty("v"))
            {
                globals["v"] = function(o:MacrosFormatOptions):* {
                    if (o == null || o.__subname == null || o.vdata == null)
                        return null;
                    return o.vdata[o.__subname];
                }
            }
        }

        public static function RegisterClockMacros():void
        {
            if (!globals.hasOwnProperty("_clock"))
            {
                globals["_clock"] = function(o:MacrosFormatOptions):* {
                    if (o == null || o.__subname == null)
                        return null;
                    var date:Date = App.utils.dateTime.now();
                    switch (o.__subname)
                    {
                        case "Y": return date.fullYear;
                        case "M": return date.month + 1;
                        case "MM": return App.utils.dateTime.getMonthName(date.month + 1, true, false);
                        case "MMM": return App.utils.dateTime.getMonthName(date.month + 1, true, true);
                        case "D": return date.date;
                        case "W": return App.utils.dateTime.getDayName(date.day == 0 ? 7 : date.day, true, false);
                        case "WW": return App.utils.dateTime.getDayName(date.day == 0 ? 7 : date.day, true, true);
                        case "h": return date.hours;
                        case "m": return date.minutes;
                        case "s": return date.seconds;
                        case "H": return date.hours % 12;
                        case "AM": return date.hours < 12 ? "AM" : null;
                        default: return "";
                    }
                }
            }
        }

        public static function RegisterCommentsData():void
        {
            //Logger.add("Macros::RegisterCommentsData");
            Cmd.getComments(null, onGetCommentsReceived);
        }

        public static function onGetCommentsReceived(json_str:String):void
        {
            try
            {
                //Logger.addObject(json_str);
                var o:Object = JSONx.parse(json_str);
                comments = (o != null && o.hasOwnProperty("players")) ? o.players : null;
                //Logger.addObject(comments);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        // PRIVATE

        /**
         * Change nicks for XVM developers.
         * @param pname player name
         * @return personal name
         */
        private static function getCustomPlayerName(pname:String, uid:Number):String
        {
            switch (Config.gameRegion)
            {
                case "RU":
                    if (pname == "M_r_A")
                        return "Флаттершай - лучшая пони!";
                    if (pname == "sirmax2" || pname == "0x01" || pname == "_SirMax_")
                        return "«сэр Макс» (XVM)";
                    if (pname == "STL1te")
                        return "О, СТЛайт!";
                    if (pname == "Mixailos")
                        return "Михаил";
                    break;

                case "CT":
                    if (pname == "M_r_A_RU" || pname == "M_r_A_EU")
                        return "Fluttershy is best pony!";
                    if (pname == "sirmax2_RU" || pname == "sirmax2_EU" || pname == "sirmax_NA" || pname == "0x01_RU")
                        return "«sir Max» (XVM)";
                    break;

                case "EU":
                    if (pname == "M_r_A")
                        return "Fluttershy is best pony!";
                    if (pname == "sirmax2" || pname == "0x01" || pname == "_SirMax_")
                        return "«sir Max» (XVM)";
                    break;

                case "US":
                    if (pname == "sirmax" || pname == "0x01" || pname == "_SirMax_")
                        return "«sir Max» (XVM)";
                    break;
            }

            if (comments != null)
            {
                var cdata:Object = comments[String(uid)];
                if (cdata != null)
                {
                    if (cdata.nick != null && cdata.nick != "")
                        pname = cdata.nick;
                }
            }

            return pname;
        }
    }
}
