import com.xvm.*;
import com.xvm.DataTypes.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.dataTypes.*;

class com.xvm.Macros
{
    private static var dict:Object = {}; //{ PLAYERNAME1: { macro1: func || value, macro2:... }, PLAYERNAME2: {...} }
    public static var globals:Object = {};

    public static function Format(playerName:String, format:String, options:Object):String
    {
        //Logger.add("format:" + format + " player:" + playerName);
        try
        {
            var formatArr:Array = format.split("{{");

            var res:String = formatArr[0];
            var len:Number = formatArr.length;
            if (len > 1)
            {
                var name:String = Utils.GetPlayerName(playerName);
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
            Logger.add(ex.message);
        }

        return "";
    }

    private static function FormatMacro(macro:String, pdata:Object, options:Object):String
    {
        //Logger.addObject(pdata);
        var parts:Array = [null,null,null,null,null];

        // split parts: name[:norm][%fmt][~suf][|def]
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
                    if (section < 1 && pdata.hasOwnProperty(part))
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
                case "|":
                    if (section < 4)
                    {
                        parts[section] = part;
                        section = 4;
                        part = "";
                        continue;
                    }
                    break;
            }
            part += ch;
        }
        parts[section] = part;

        var name:String = parts[0];
        var norm:String = parts[1];
        var fmt:String = parts[2];
        var suf:String = parts[3];
        var def:String = parts[4] || "";

        // substitute
        //Logger.add("name:" + name + " norm:" + norm + " fmt:" + fmt + " suf:" + suf + " def:" + def);

        if (options.dead && Strings.startsWith("c:", name) && pdata.hasOwnProprty(name + "#d"))
            name += "#d";

        if (!pdata.hasOwnProperty(name) && !globals.hasOwnProperty(name))
        {
            //Logger.add("Warning: unknown macro: " + macro);
            return def;
        }

        var value = pdata.hasOwnProperty(name) ? pdata[name] : globals[name];
        //Logger.add("value:" + value);
        if (value == null)
            return normalizeValue(NaN, name, norm, def, pdata);

        var type:String = typeof value;
        //Logger.add("type:" + type + " value:" + value + " name:" + name + " fmt:" + fmt + " suf:" + suf + " def:" + def + " macro:" + macro);

        if (type == "number" && isNaN(value))
            return normalizeValue(NaN, name, norm, def, pdata);

        var res:String = value;
        if (typeof value == "function")
        {
            value = options ? value(options) : "{{" + macro + "}}";
            if (value == null)
                return normalizeValue(NaN, name, norm, def, pdata);
            type = typeof value;
            if (type == "number" && isNaN(value))
                return normalizeValue(NaN, name, norm, def, pdata);
            res = value;
        }

        if (norm != null && type == "number")
            res = normalizeValue(value, name, norm, def, pdata);

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

    private static function normalizeValue(value:Number, name:String, norm:String, def:String, pdata:Object):String
    {
        if (norm == null)
            return def;

        var res:String = def;
        switch (name)
        {
            case "hp":
            case "hp-max":
                if (isNaN(value))
                {
                    var vdata:VehicleData = VehicleInfo.get(pdata["veh-id"]);
                    if (vdata != null)
                        value = vdata.hpTop;
                }
                res = Math.round(parseInt(norm) * value / Defines.MAX_BATTLETIER_HPS[globals["battletier"] - 1]).toString();
                //Logger.add("res: " + res);
                break;
            case "hp-ratio":
                if (isNaN(value))
                    value = 100;
                res = Math.round(parseInt(norm) * value / 100).toString();
                break;
        }

        return res;
    }

    // Macros registration

    public static function RegisterPlayerData(playerName:String, data:Object, team:Number)
    {
        if (!Config.config)
            return;
        if (!data)
            return;
        var pname:String = Utils.GetPlayerName(playerName);
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
                // {{vtype}}
                pdata["vtype"] = VehicleInfo.getVTypeText(vdata.vtype);
                // {{c:vtype}}
                pdata["c:vtype"] = GraphicsUtil.GetVTypeColorValue(data.icon);
            }
        }

        // squad
        if (!pdata.hasOwnProperty("squad") && data.hasOwnProperty("squad"))
        {
            // {{squad}}
            pdata["squad"] = data.squad;
        }

        // level
        if (!pdata.hasOwnProperty("level") && data.hasOwnProperty("level"))
        {
            // {{level}}
            pdata["level"] = data.level;
            // {{rlevel}}
            pdata["rlevel"] = data.level ? Defines.ROMAN_LEVEL[data.level - 1] : "";
        }

        // Dynamic macros

        if (!pdata.hasOwnProperty("hp"))
        {
            // {{frags}}
            pdata["frags"] = function(o):Number { return isNaN(o.frags) ? NaN : o.frags; }
            // {{alive}}
            pdata["alive"] = function(o):String { return o.dead == true ? null : 'alive'; }

            // hp

            // {{hp}}
            pdata["hp"] = function(o):Number { return isNaN(o.curHealth) ? NaN : o.curHealth; }
            // {{hp-max}}
            pdata["hp-max"] = function(o):Number { return isNaN(o.maxHealth) ? data.maxHealth : o.maxHealth; };
            // {{hp-ratio}}
            pdata["hp-ratio"] = function(o):Number { return isNaN(o.curHealth) ? NaN : Math.round(o.curHealth / (o.maxHealth ? o.maxHealth : data.maxHealth) * 100); }
            // {{c:hp}}
            pdata["c:hp"] = function(o):String { return isNaN(o.curHealth) ? null : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, o.curHealth); }
            // {{c:hp-ratio}}
            pdata["c:hp-ratio"] = function(o):String { return isNaN(o.curHealth) ? null : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, o.curHealth / (o.maxHealth ? o.maxHealth : data.maxHealth) * 100); }
            // {{a:hp}}
            pdata["a:hp"] = function(o):Number { return isNaN(o.curHealth) ? NaN : GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, o.curHealth); }
            // {{a:hp-ratio}}
            pdata["a:hp-ratio"] = function(o):Number { return isNaN(o.curHealth) ? NaN : GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO,
                Math.round(o.curHealth / (o.maxHealth ? o.maxHealth : data.maxHealth) * 100)); }

            // dmg

            // {{dmg}}
            pdata["dmg"] = function(o):Number { return isNaN(o.delta) ? NaN : o.delta; }
            // {{dmg-ratio}}
            pdata["dmg-ratio"] = function(o):Number { return isNaN(o.delta) ? NaN : Math.round(o.delta / (o.maxHealth ? o.maxHealth : data.maxHealth) * 100); }
            // {{dmg-kind}}
            pdata["dmg-kind"] = function(o):String { return o.damageType == null ? null : Locale.get(o.damageType); }
            // {{c:dmg}}
            pdata["c:dmg"] = function(o):String
                {
                    return isNaN(o.delta) ? null : GraphicsUtil.GetDmgSrcValue(
                        Utils.damageFlagToDamageSource(o.damageFlag),
                        o.entityName == 'teamKiller' ? (data.team + "tk") : o.entityName,
                        o.dead, o.blowedUp);
                }
            // {{c:dmg-kind}}
            pdata["c:dmg-kind"] = function(o):String { return o.damageType == null ? null : GraphicsUtil.GetDmgKindValue(o.damageType); }

            // {{c:system}}
            pdata["c:system"] = function(o):String { return "#" + Strings.padLeft(o.getSystemColor(o).toString(16), 6, "0"); }
        }
    }

    public static function RegisterBattleTierData(battletier:Number)
    {
        // {{battletier}}
        globals["battletier"] = battletier;
    }

    public static function RegisterStatMacros(playerName:String, stat:StatData)
    {
        if (!stat)
            return;
        var pname:String = Utils.GetPlayerName(playerName);
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
        // {{a:eff}}
        pdata["a:eff"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_EFF, stat.e);
        // {{a:wn6}}
        pdata["a:wn6"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN6, stat.wn6);
        // {{a:wn8}}
        pdata["a:wn8"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN8, stat.wn8);
        // {{a:wn}}
        pdata["a:wn"] = pdata["a:wn8"];
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
        var pname:String = Utils.GetPlayerName(player.userName);
        if (!dict.hasOwnProperty(pname))
            dict[pname] = { };
        var pdata = dict[pname];

        var vdata:VehicleData = VehicleInfo.getByIcon(player.icon);

        // {{level}}
        pdata["level"] = vdata.level;

        // {{vehicle-class}} - returns special symbol depending on class
        pdata["vehicle-class"] = vehicleClassSymbol;

        // {{vehicle}} - Vehicle type readable - Chaffee
        pdata["vehicle"] = vdata.localizedName;

        // {{vehiclename}} - Vehicle system name - usa-M24_Chaffee
        pdata["vehiclename"] = VehicleInfo.getVIconName(vdata.key);

        // {{vehicle-short}}
        pdata["vehicle-short"] = vdata.shortName;
    }

    public static function RegisterMarkerData(playerName:String, data:Object)
    {
        if (!data)
            return;
        var pname:String = Utils.GetPlayerName(playerName);
        if (!dict.hasOwnProperty(pname))
            dict[pname] = { };
        var pdata = dict[pname];

        // {{turret}}
        pdata["turret"] = data.turret || "";
    }

    public static function RegisterHitlogMacros(playerName:String, data:Object, hits:Array, total:Number)
    {
        if (!data)
            return;
        var pname:String = Utils.GetPlayerName(playerName);
        if (!dict.hasOwnProperty(pname))
            dict[pname] = { };
        var pdata = dict[pname];

        // {{dead}}
        pdata["dead"] = data.curHealth < 0
            ? Config.config.hitLog.blowupMarker
            : (data.curHealth == 0 || data.dead) ? Config.config.hitLog.deadMarker : "";

        // {{n}}
        pdata["n"] = hits.length;

        // {{n-player}}
        pdata["n-player"] = data.hits.length;

        // {{dmg-total}}
        pdata["dmg-total"] = total;

        // {{dmg-avg}}
        pdata["dmg-avg"] = hits.length == 0 ? 0 : Math.round(total / hits.length);

        // {{dmg-player}}
        pdata["dmg-player"] = data.total;
    }

    // PRIVATE

    private static function modXvmDevLabel(nick:String):String
    {
        var label = Utils.GetPlayerName(nick);
        switch (Config.config.region)
        {
            case "RU":
                if (label == "M_r_A")
                    return "Флаттершай - лучшая пони!";
                if (label == "sirmax2" || label == "0x01" || label == "_SirMax_")
                    return "«сэр Макс» (XVM)";
                if (label == "Mixailos")
                    return "Михаил";
                if (label == "STL1te")
                    return "О, СТЛайт!";
                break;

            case "CT":
                if (label == "M_r_A_RU" || label == "M_r_A_EU")
                    return "Fluttershy is best pony!";
                if (label == "sirmax2_RU" || label == "sirmax2_EU" || label == "sirmax_NA" || label == "0x01_RU")
                    return "«sir Max» (XVM)";
                break;

            case "EU":
                if (label == "M_r_A")
                    return "Fluttershy is best pony!";
                if (label == "sirmax2" || label == "0x01" || label == "_SirMax_")
                    return "«sir Max» (XVM)";
                break;

            case "US":
                if (label == "sirmax" || label == "0x01" || label == "_SirMax_")
                    return "«sir Max» (XVM)";
                break;
        }

        return nick;
    }
}
