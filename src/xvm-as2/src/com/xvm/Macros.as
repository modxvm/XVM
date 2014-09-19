import com.xvm.*;
import com.xvm.DataTypes.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.dataTypes.*;

class com.xvm.Macros
{
    private static var macros_cache = { };

    private static var dict:Object = {}; //{ PLAYERNAME1: { macro1: func || value, macro2:... }, PLAYERNAME2: {...} }
    public static var globals:Object = {};

    public static function Format(pname:String, format:String, options:Object):String
    {
        //Logger.add("format:" + format + " player:" + pname);
        if (format == null || pname == null)
            return null;
        try
        {
            var player_cache = macros_cache[pname];
            if (player_cache == null)
            {
                macros_cache[pname] = { alive: { }, dead: { }};
                player_cache = macros_cache[pname];
            }
            var dead:Boolean = options != null && options.dead == true;
            var dead_value:String = dead ? "dead" : "alive";
            var cached_value = player_cache[dead_value][format];
            if (cached_value != undefined)
            {
                //Logger.add("cached: " + cached_value);
                return cached_value;
            }

            var formatArr:Array = format.split("{{");

            var res:String = formatArr[0];
            var len:Number = formatArr.length;
            var isStaticMacro = true;
            if (len > 1)
            {
                for (var i:Number = 1; i < len; ++i)
                {
                    var part:String = formatArr[i];
                    var arr2:Array = part.split("}}", 2);
                    var macro:String = arr2[0];
                    if (arr2.length == 1)
                    {
                        res += "{{" + part;
                    }
                    else
                    {
                        var pdata = dict[pname];
                        if (pdata != null)
                        {
                            var parts:Array = GetMacroParts(macro, pdata, dead);

                            var macroName = parts[0];
                            var norm = parts[1];
                            var def:String = parts[5];

                            //Logger.add("macroname:" + macroName + "| norm:" + norm + "| def:" + def + "| format:" + format);

                            var value = pdata[macroName];

                            if (value === undefined)
                                value = globals[macroName];

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
                player_cache[dead_value][format] = res;
            //else
            //    Logger.add(pname + "> " + format);

            //Logger.add(pname + "> " + format);
            //Logger.add(pname + "> " + res);
            return res;
        }
        catch (ex:Error)
        {
            Logger.add(ex.message);
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

    private static function FormatMacro(macro:String, parts:Array, value, pdata, options:Object):String
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

    // Macros registration

    public static function RegisterPlayerData(pname:String, data:Object, team:Number)
    {
        if (!Config.config)
            return;
        if (!data)
            return;
        if (!dict.hasOwnProperty(pname))
            dict[pname] = { };
        var pdata = dict[pname];

        //Logger.addObject(data);

        // Static macros

        // player name
        if (!pdata.hasOwnProperty("nick"))
        {
            var fname:String = data.label + (data.label.indexOf("[") >= 0 || !data.clanAbbrev ? "" : "[" + data.clanAbbrev + "]");
            var name:String = Macros.modXvmDevLabel(pname);
            var clan:String = Utils.GetClanNameWithBrackets(fname);
            var nick:String = name + clan;

            // {{nick}}
            pdata["nick"] = nick;
            // {{name}}
            pdata["name"] = name;
            // {{clan}}
            pdata["clan"] = clan;
            // {{clannb}}
            pdata["clannb"] = Utils.GetClanName(fname);
            // {{player}}
            pdata["player"] = data.himself == true ? "pl" : null;
        }

        // vehicle
        if (!pdata.hasOwnProperty("vehicle"))
        {
            var vdata:VehicleData = VehicleInfo.getByIcon(data.icon);
            //Logger.addObject(vdata);
            if (vdata != null)
            {
                // {{veh-id}}
                pdata["veh-id"] = vdata.vid;
                // {{vehicle}}
                pdata["vehicle"] = vdata.localizedName;
                // {{vehiclename}} - usa-M24_Chaffee
                pdata["vehiclename"] = VehicleInfo.getVIconName(vdata.key);
                // {{vehicle-short}}
                pdata["vehicle-short"] = vdata.shortName;
                // {{vtype}}
                pdata["vtype"] = VehicleInfo.getVTypeText(vdata.vtype);
                // {{c:vtype}}
                pdata["c:vtype"] = GraphicsUtil.GetVTypeColorValue(data.icon);
                // {{level}}
                pdata["level"] = vdata.level;
                // {{rlevel}}
                pdata["rlevel"] = Defines.ROMAN_LEVEL[vdata.level - 1];
            }
        }

        // squad
        if (!pdata.hasOwnProperty("squad") && data.hasOwnProperty("squad"))
        {
            // {{squad}}
            pdata["squad"] = data.squad > 10 ? "sq" : null;
        }

        // Dynamic macros

        if (!pdata.hasOwnProperty("hp"))
        {
            // {{frags}}
            pdata["frags"] = function(o):Number { return isNaN(o.frags) || o.frags == 0 ? NaN : o.frags; }
            // {{ready}}
            pdata["ready"] = function(o):String { return o.ready == true ? 'ready' : null; }
            // {{alive}}
            pdata["alive"] = function(o):String { return o.dead == true ? null : 'alive'; }
            // {{tk}}
            pdata["tk"] = function(o):String { return o.teamKiller == true ? 'tk' : null; }
            // {{gun-marks}}
            pdata["gun-marks"] = function(o):String { return isNaN(o.marksOnGun) ? null : Utils.getGunMarksText(o.marksOnGun); }

            // hp

            // {{hp}}
            pdata["hp"] = function(o):Number { return isNaN(o.curHealth) ? NaN : o.curHealth; }
            // {{hp-max}}
            pdata["hp-max"] = function(o):Number { return isNaN(o.maxHealth) ? data.maxHealth : o.maxHealth; };
            // {{hp-ratio}}
            pdata["hp-ratio"] = function(o):Number { return isNaN(o.curHealth) ? NaN : Math.round(o.curHealth / (o.maxHealth ? o.maxHealth : data.maxHealth) * 100); }
            // {{c:hp}}
            pdata["c:hp"] = function(o):String { return (isNaN(o.curHealth) && !o.dead) ? null : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, o.curHealth || 0); }
            // {{c:hp-ratio}}
            pdata["c:hp-ratio"] = function(o):String { return (isNaN(o.curHealth) && !o.dead) ? null : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO,
                isNaN(o.curHealth) ? 0 : o.curHealth / (o.maxHealth ? o.maxHealth : data.maxHealth) * 100); }
            // {{a:hp}}
            pdata["a:hp"] = function(o):Number { return (isNaN(o.curHealth) && !o.dead) ? NaN : GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, o.curHealth || 0); }
            // {{a:hp-ratio}}
            pdata["a:hp-ratio"] = function(o):Number { return (isNaN(o.curHealth) && !o.dead) ? NaN : GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO,
                isNaN(o.curHealth) ? 0 : o.curHealth / (o.maxHealth ? o.maxHealth : data.maxHealth) * 100); }

            // dmg

            // {{dmg}}
            pdata["dmg"] = function(o):Number { return isNaN(o.delta) ? NaN : o.delta; }
            // {{dmg-ratio}}
            pdata["dmg-ratio"] = function(o):Number { return isNaN(o.delta) ? NaN : Math.round(o.delta / data.maxHealth * 100); }
            // {{dmg-kind}}
            pdata["dmg-kind"] = function(o):String { return o.damageType == null ? null : Locale.get(o.damageType); }
            // {{c:dmg}}
            pdata["c:dmg"] = function(o):String
            {
                if isNaN(o.delta)
                    return null;
                switch (o.damageType)
                {
                    case "world_collision":
                    case "death_zone":
                    case "drowning":
                        return GraphicsUtil.GetDmgKindValue(o.damageType);
                    default:
                        return GraphicsUtil.GetDmgSrcValue(
                            Utils.damageFlagToDamageSource(o.damageFlag),
                            o.entityName == 'teamKiller' ? (data.team + "tk") : o.entityName,
                            o.dead, o.blowedUp);
                }
            }
            // {{c:dmg-kind}}
            pdata["c:dmg-kind"] = function(o):String { return o.damageType == null ? null : GraphicsUtil.GetDmgKindValue(o.damageType); }

            // {{c:system}}
            pdata["c:system"] = function(o):String
            {
                return "#" + Strings.padLeft(ColorsManager.getSystemColor(o.entityName, o.dead, o.blowedUp).toString(16), 6, "0");
            }

            // hitlog

            // {{dead}}
            pdata["dead"] = function(o):String
            {
                return o.curHealth < 0
                    ? Config.config.hitLog.blowupMarker
                    : (o.curHealth == 0 || o.dead) ? Config.config.hitLog.deadMarker : null;
            }

            // {{n}}
            pdata["n"] = function(o):Number { return o.global.hits.length }

            // {{dmg-total}}
            pdata["dmg-total"] = function(o):Number { return o.global.total }

            // {{dmg-avg}}
            pdata["dmg-avg"] = function(o):Number { return o.global.hits.length == 0 ? 0 : Math.round(o.global.total / o.global.hits.length); }

            // {{n-player}}
            pdata["n-player"] = function(o):Number { return o.hits.length };

            // {{dmg-player}}
            pdata["dmg-player"] = function(o):Number { return o.total };
        }
    }

    public static function RegisterBattleTierData(battletier:Number)
    {
        // {{battletier}}
        globals["battletier"] = battletier;
    }

    public static function RegisterStatMacros(pname:String, stat:StatData)
    {
        if (!stat)
            return;
        if (!dict.hasOwnProperty(pname))
            dict[pname] = { };
        var pdata = dict[pname];

        // {{squad-num}}
        pdata["squad-num"] = stat.squadnum > 0 ? stat.squadnum : null;

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
        pdata["c:xeff"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xeff, "#", false);
        pdata["c:xeff#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xeff, "#", true);
        // {{c:xwn6}}
        pdata["c:xwn6"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn6, "#", false);
        pdata["c:xwn6#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn6, "#", true);
        // {{c:xwn8}}
        pdata["c:xwn8"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn8, "#", false);
        pdata["c:xwn8#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn8, "#", true);
        // {{c:xwn}}
        pdata["c:xwn"] = pdata["c:xwn8"];
        pdata["c:xwn#d"] = pdata["c:xwn8#d"];
        // {{c:xwgr}}
        pdata["c:xwgr"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwgr, "#", false);
        pdata["c:xwgr#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwgr, "#", true);
        // {{c:eff}}
        pdata["c:eff"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, stat.e, "#", false);
        pdata["c:eff#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, stat.e, "#", true);
        // {{c:wn6}}
        pdata["c:wn6"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN6, stat.wn6, "#", false);
        pdata["c:wn6#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN6, stat.wn6, "#", true);
        // {{c:wn8}}
        pdata["c:wn8"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, stat.wn8, "#", false);
        pdata["c:wn8#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, stat.wn8, "#", true);
        // {{c:wn}}
        pdata["c:wn"] =   pdata["c:wn8"];
        pdata["c:wn#d"] = pdata["c:wn8#d"];
        // {{c:wgr}}
        pdata["c:wgr"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WGR, stat.wgr, "#", false);
        pdata["c:wgr#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WGR, stat.wgr, "#", true);
        // {{c:e}}
        pdata["c:e"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, stat.v.te, "#", false);
        pdata["c:e#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, stat.v.te, "#", true);
        // {{c:rating}}
        pdata["c:rating"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, stat.r, "#", false);
        pdata["c:rating#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, stat.r, "#", true);
        // {{c:kb}}
        pdata["c:kb"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, stat.b / 1000, "#", false);
        pdata["c:kb#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, stat.b / 1000, "#", true);
        // {{c:avglvl}}
        pdata["c:avglvl"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_AVGLVL, stat.lvl, "#", false);
        pdata["c:avglvl#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_AVGLVL, stat.lvl, "#", true);
        // {{c:t-rating}}
        pdata["c:t-rating"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, stat.v.r, "#", false);
        pdata["c:t-rating#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, stat.v.r, "#", true);
        // {{c:t-battles}}
        pdata["c:t-battles"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, stat.v.b, "#", false);
        pdata["c:t-battles#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, stat.v.b, "#", true);
        // {{c:tdb}}
        pdata["c:tdb"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, stat.v.db, "#", false);
        pdata["c:tdb#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, stat.v.db, "#", true);
        // {{c:tdv}}
        pdata["c:tdv"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, stat.v.dv, "#", false);
        pdata["c:tdv#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, stat.v.dv, "#", true);
        // {{c:tfb}}
        pdata["c:tfb"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, stat.v.fb, "#", false);
        pdata["c:tfb#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, stat.v.fb, "#", true);
        // {{c:tsb}}
        pdata["c:tsb"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, stat.v.sb, "#", false);
        pdata["c:tsb#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, stat.v.sb, "#", true);

        // Alpha
        // {{a:xeff}}
        pdata["a:xeff"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xeff);
        // {{a:xwn6}}
        pdata["a:xwn6"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn6);
        // {{a:xwn8}}
        pdata["a:xwn8"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn8);
        // {{a:xwn}}
        pdata["a:xwn"] = pdata["a:xwn8"];
        // {{a:xwgr}}
        pdata["a:xwgr"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwgr);
        // {{a:eff}}
        pdata["a:eff"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_EFF, stat.e);
        // {{a:wn6}}
        pdata["a:wn6"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN6, stat.wn6);
        // {{a:wn8}}
        pdata["a:wn8"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN8, stat.wn8);
        // {{a:wn}}
        pdata["a:wn"] = pdata["a:wn8"];
        // {{a:wgr}}
        pdata["a:wgr"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WGR, stat.wgr);
        // {{a:e}}
        pdata["a:e"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_E, stat.v.te);
        // {{a:rating}}
        pdata["a:rating"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_RATING, stat.r);
        // {{a:kb}}
        pdata["a:kb"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_KB, stat.b / 1000);
        // {{a:avglvl}}
        pdata["a:avglvl"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_AVGLVL, stat.lvl);
        // {{a:t-rating}}
        pdata["a:t-rating"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_RATING, stat.v.r);
        // {{a:t-battles}}
        pdata["a:t-battles"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TBATTLES, stat.v.b);
        // {{a:tdb}}
        pdata["a:tdb"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TDB, stat.v.db);
        // {{a:tdv}}
        pdata["a:tdv"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TDV, stat.v.dv);
        // {{a:tfb}}
        pdata["a:tfb"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TFB, stat.v.fb);
        // {{a:tsb}}
        pdata["a:tsb"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TSB, stat.v.sb);
    }

    public static function RegisterMinimapMacros(player:Player, vehicleClassSymbol:String)
    {
        if (!player)
            return;
        var pname:String = player.userName;
        if (!dict.hasOwnProperty(pname))
            dict[pname] = { };
        var pdata = dict[pname];

        // {{vehicle-class}} - returns special symbol depending on class
        pdata["vehicle-class"] = vehicleClassSymbol;
    }

    public static function RegisterMarkerData(pname:String, data:Object)
    {
        if (!data)
            return;
        if (!dict.hasOwnProperty(pname))
            dict[pname] = { };
        var pdata = dict[pname];

        // {{turret}}
        pdata["turret"] = data.turret || "";
    }

    // PRIVATE

    private static function modXvmDevLabel(pname:String):String
    {
        switch (Config.config.region)
        {
            case "RU":
                if (pname == "M_r_A")
                    return "Флаттершай - лучшая пони!";
                if (pname == "sirmax2" || pname == "0x01" || pname == "_SirMax_")
                    return "«сэр Макс» (XVM)";
                if (pname == "Mixailos")
                    return "Михаил";
                if (pname == "STL1te")
                    return "О, СТЛайт!";
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

        return pname;
    }
}
