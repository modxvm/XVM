import com.natecook.Sprintf;
import com.xvm.*;
import com.xvm.DataTypes.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.dataTypes.*;

class com.xvm.Macros
{
    private static var dict: Object = {}; //{ PLAYERNAME1: { macro1: func || value, macro2:... }, PLAYERNAME2: {...} }

    public static function Format(playerName:String, format:String, options:Object):String
    {
        //Logger.add("format:" + format + " player:" + playerName);

        var res:String = "";
        try
        {
            var formatArr:Array = format.split("{{");

            res = formatArr[0];
            var len:Number = formatArr.length;
            if (len > 1)
            {
                var name:String = Utils.GetNormalizedPlayerName(playerName);
                for (var i:Number = 1; i < len; ++i)
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
            Logger.add(ex.message);
        }
        return res;
    }

    private static function FormatMacro(macro:String, pdata:Object, options:Object):String
    {
        //Logger.addObject(pdata);
        var parts:Array = [null,null,null,null];

        // split parts: name[%fmt][~suf][|def]
        var macroArr:Array = macro.split("");
        var len:Number = macroArr.length;
        var part:String = "";
        var section:Number = 0;
        for (var i:Number = 0; i < len; ++i)
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

        if (!pdata.hasOwnProperty(name))
        {
            //Logger.add("Warning: unknown macro: " + macro);
            return def;
        }

        var value = pdata[name];
        //Logger.add("value:" + value);
        if (value == null)
            return def;

        var type:String = typeof value;
        //Logger.add("type:" + type + " value:" + value + " name:" + name + " fmt:" + fmt + " suf:" + suf + " def:" + def + " macro:" + macro);

        if (type == "number" && isNaN(value))
            return def;

        var res:String = value;
        if (typeof value == "function")
            res = options ? value(options) : "{{" + macro + "}}";

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
                        if (res.length == precision)
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

    public static function RegisterPlayerData(name:String, data:Object, team:Number)
    {
        if (!data)
            return;

        var pname = Utils.GetNormalizedPlayerName(name);

        Cache.Get("_m/" + pname + "/" + data.vehicle + "/" + (VehicleInfo.initialized && Config.s_loaded), function()
        {
            //Logger.addObject(data);
            if (!Macros.dict.hasOwnProperty(pname))
                Macros.dict[pname] = { };
            var pdata = Macros.dict[pname];

            // vars
            var nick = Macros.modXvmDevLabel(data.label +
                (data.label.indexOf("[") >= 0 || !data.clanAbbrev ? "" : "[" + data.clanAbbrev + "]"));

            var vdata:VehicleData = VehicleInfo.getByIcon(data.icon);
            //Logger.addObject(vdata);

            // {{nick}}
            pdata["nick"] = nick;
            // {{name}}
            var nm:String = Utils.GetPlayerName(nick);
            pdata["name"] = nm;
            // {{clan}}
            pdata["clan"] = Utils.GetClanNameWithBrackets(nick);
            // {{clannb}}
            pdata["clannb"] = Utils.GetClanName(nick);
            // {{vehicle}}
            pdata["vehicle"] = vdata.localizedName;
            // {{vehiclename}} - usa-M24_Chaffee
            pdata["vehiclename"] = VehicleInfo.getVIconName(vdata.key);
            // {{vtype}}
            pdata["vtype"] = VehicleInfo.getVTypeText(vdata.vtype);
            // {{c:vtype}}
            pdata["c:vtype"] = GraphicsUtil.GetVTypeColorValue(data.icon);

            // VMM only - static
            // {{squad}}
            pdata["squad"] = data.squad || "";
            // {{level}}
            pdata["level"] = data.level;
            // {{rlevel}}
            pdata["rlevel"] = data.level ? Defines.ROMAN_LEVEL[data.level - 1] : "";
            // {{hp-max}}
            pdata["hp-max"] = data.maxHealth;
            // {{turret}}
            pdata["turret"] = data.turret || "";

            // VMM only - dynamic
            // {{hp}}
            pdata["hp"] = function(o) { return o && o.curHealth != undefined ? o.curHealth : NaN; }
            // {{hp-ratio}}
            pdata["hp-ratio"] = function(o) { return o && o.curHealth != undefined ? Math.round(o.curHealth / data.maxHealth * 100) : NaN; }
            // {{dmg}}
            pdata["dmg"] = function(o) { return o && o.delta != undefined ? String(o.delta) : NaN; }
            // {{dmg-ratio}}
            pdata["dmg-ratio"] = function(o) { return o && o.delta != undefined ? Math.round(o.delta / data.maxHealth * 100) : NaN; }
            // {{dmg-kind}}
            pdata["dmg-kind"] = function(o) { return o && o.delta != undefined ? Locale.get(o.damageType) : ""; }

            // Colors
            // {{c:hp}}
            pdata["c:hp"] = function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, o.curHealth); }
            // {{c:hp-ratio}}
            pdata["c:hp-ratio"] = function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, o.curHealth / data.maxHealth * 100); }
            // {{c:dmg}}
            pdata["c:dmg"] = function(o)
                {
                    return o.delta ? GraphicsUtil.GetDmgSrcValue(
                        Macros.damageFlagToDamageSource(o.damageFlag),
                        o.entityName == 'teamKiller' ? (data.team + "tk") : o.entityName,
                        o.dead, o.blowedUp) : "";
                }
            // {{c:dmg-kind}}
            pdata["c:dmg-kind"] = function(o) { return o.delta ? GraphicsUtil.GetDmgKindValue(o.damageType) : ""; }
            // {{c:system}}
            pdata["c:system"] = function(o) { return "#" + Strings.padLeft(o.getSystemColor(o).toString(16), 6, "0"); }

            // Alpha
            // {{a:hp}}
            pdata["a:hp"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, o.curHealth); }
            // {{a:hp-ratio}}
            pdata["a:hp-ratio"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO,
                Math.round(o.curHealth / data.maxHealth * 100)); }

            return true;
        });
    }

    public static function RegisterStatMacros(playerName:String, stat:StatData)
    {
        if (!stat)
            return;

        var pname:String = Utils.GetNormalizedPlayerName(playerName);
        if (!dict.hasOwnProperty(pname))
            dict[pname] = { };
        var pdata = dict[pname];

        // vars
        var r:Number = Utils.toInt(stat.r, 0);
        var eff:Number = Utils.toInt(stat.e, 0);
        var b:Number = Utils.toInt(stat.b, 0);
        var w:Number = Utils.toInt(stat.w, 0);
        var tr:Number = Utils.toInt(stat.v.r, 0);
        var tb:Number = Utils.toInt(stat.v.b, 0);
        var tw:Number = Utils.toInt(stat.v.w, 0);

        // {{avglvl}}
        var avglvl = Math.round(Utils.toFloat(stat.lvl, 0));
        pdata["avglvl"] = avglvl < 1 ? null : avglvl == 10 ? "X" : String(avglvl);
        // {{xeff}}
        pdata["xeff"] = stat.xeff == null ? null : stat.xeff == 100 ? "XX" : (stat.xeff < 10 ? "0" : "") + stat.xeff;
        // {{xwn6}}
        pdata["xwn6"] = stat.xwn6 == null ? null : stat.xwn6 == 100 ? "XX" : (stat.xwn6 < 10 ? "0" : "") + stat.xwn6;
        // {{xwn8}}
        pdata["xwn8"] = stat.xwn8 == null ? null : stat.xwn8 == 100 ? "XX" : (stat.xwn8 < 10 ? "0" : "") + stat.xwn8;
        // {{xwn}}
        pdata["xwn"] = pdata["xwn8"];
        // {{eff}}
        pdata["eff"] = eff <= 0 ? NaN : eff;
        // {{wn6}}
        pdata["wn6"] = stat.wn6 <= 0 ? NaN : stat.wn6;
        // {{wn8}}
        pdata["wn8"] = stat.wn8 <= 0 ? NaN : stat.wn8;
        // {{wn}}
        pdata["wn"] = pdata["wn8"];
        // {{e}}
        pdata["e"] = stat.v.te == null ? null : stat.v.te >= 10 ? "E" : String(stat.v.te);
        // {{teff}}
        pdata["teff"] = stat.v.teff == null ? NaN : stat.v.teff;

        // {{rating}}
        pdata["rating"] = r <= 0 ? NaN : r;
        // {{battles}}
        pdata["battles"] = b <= 0 ? NaN : b;
        // {{wins}}
        pdata["wins"] = b <= 0 ? NaN : w;
        // {{kb}}
        pdata["kb"] = b <= 0 ? NaN : b / 1000;

        // {{t-rating}}
        pdata["t-rating"] = tr <= 0 ? NaN : tr;
        // {{t-battles}}
        pdata["t-battles"] = tb <= 0 ? NaN : tb;
        // {{t-wins}}
        pdata["t-wins"] = tb <= 0 ? NaN : tw;
        // {{t-kb}}
        pdata["t-kb"] = tb <= 0 ? NaN : tb / 1000;
        // {{t-hb}}
        pdata["t-hb"] = tb <= 0 ? NaN : tb / 100;
        // {{tdb}}
        pdata["tdb"] = stat.v.db == null ? NaN : stat.v.db;
        // {{tdv}}
        pdata["tdv"] = stat.v.dv == null ? NaN : stat.v.dv;
        // {{tfb}}
        pdata["tfb"] = stat.v.fb == null ? NaN : stat.v.fb;
        // {{tsb}}
        pdata["tsb"] = stat.v.sb == null ? NaN : stat.v.sb;

        // Dynamic colors
        // {{c:xeff}}
        pdata["c:xeff"] = stat.xeff == null ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xeff, "#", o.darken); }
        // {{c:xwn6}}
        pdata["c:xwn6"] = stat.xwn6 == null ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn6, "#", o.darken); }
        // {{c:xwn8}}
        pdata["c:xwn8"] = stat.xwn8 == null ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn8, "#", o.darken); }
        // {{c:xwn}}
        pdata["c:xwn"] = pdata["c:xwn8"];
        // {{c:eff}}
        pdata["c:eff"] = eff <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, eff, "#", o.darken); }
        // {{c:wn6}}
        pdata["c:wn6"] = !stat.wn6 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN6, stat.wn6, "#", o.darken); }
        // {{c:wn8}}
        pdata["c:wn8"] = !stat.wn8 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, stat.wn8, "#", o.darken); }
        // {{c:wn}}
        pdata["c:wn"] = pdata["c:wn8"];
        // {{c:e}}
        pdata["c:e"] = stat.v.te == null ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, stat.v.te, "#", o.darken); }
        // {{c:rating}}
        pdata["c:rating"] = r <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, r, "#", o.darken); }
        // {{c:kb}}
        pdata["c:kb"] = b <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, b / 1000, "#", o.darken); }
        // {{c:avglvl}}
        pdata["c:avglvl"] = stat.lvl <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_AVGLVL, Math.round(Utils.toFloat(stat.lvl, 0)), "#", o.darken); }
        // {{c:t-rating}}
        pdata["c:t-rating"] = tr <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, tr, "#", o.darken); }
        // {{c:t-battles}}
        pdata["c:t-battles"] = tb <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, tb, "#", o.darken); }
        // {{c:tdb}}
        pdata["c:tdb"] = stat.v.db <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, stat.v.db, "#", o.darken); }
        // {{c:tdv}}
        pdata["c:tdv"] = stat.v.dv <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, stat.v.dv, "#", o.darken); }
        // {{c:tfb}}
        pdata["c:tfb"] = stat.v.fb <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, stat.v.fb, "#", o.darken); }
        // {{c:tsb}}
        pdata["c:tsb"] = stat.v.sb <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, stat.v.sb, "#", o.darken); }

        // Alpha
        // {{a:xeff}}
        pdata["a:xeff"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xeff); }
        // {{a:xwn6}}
        pdata["a:xwn6"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn6); }
        // {{a:xwn8}}
        pdata["a:xwn8"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn8); }
        // {{a:xwn}}
        pdata["a:xwn"] = pdata["a:xwn8"];
        // {{a:eff}}
        pdata["a:eff"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_EFF, eff); }
        // {{a:wn6}}
        pdata["a:wn6"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN6, stat.wn6); }
        // {{a:wn8}}
        pdata["a:wn8"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN8, stat.wn8); }
        // {{a:wn}}
        pdata["a:wn"] = pdata["a:wn8"];
        // {{a:e}}
        pdata["a:e"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_E, stat.v.te); }
        // {{a:rating}}
        pdata["a:rating"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_RATING, r); }
        // {{a:kb}}
        pdata["a:kb"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_KB, b / 1000); }
        // {{a:avglvl}}
        pdata["a:avglvl"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_AVGLVL, stat.lvl); }
        // {{a:t-rating}}
        pdata["a:t-rating"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_RATING, tr); }
        // {{a:t-battles}}
        pdata["a:t-battles"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TBATTLES, tb); }
        // {{a:tdb}}
        pdata["a:tdb"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TDB, stat.v.db); }
        // {{a:tdv}}
        pdata["a:tdv"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TDV, stat.v.dv); }
        // {{a:tfb}}
        pdata["a:tfb"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TFB, stat.v.fb); }
        // {{a:tsb}}
        pdata["a:tsb"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TSB, stat.v.sb); }
    }

    public static function RegisterMinimapMacros(player:Player, vehicleClassSymbol:String)
    {
        if (!player)
            return;

        var pname:String = Utils.GetNormalizedPlayerName(player.userName);
        if (!dict.hasOwnProperty(pname))
            dict[pname] = { };
        var pdata = dict[pname];

        var vdata:VehicleData = VehicleInfo.getByIcon(player.icon);

        // {{level}}
        pdata["level"] = vdata.level;

        // {{short-nick}}
        pdata["short-nick"] = player.userName.slice(0, MapConfig.nickShrink)

        // {{vehicle-class}} - returns special symbol depending on class
        pdata["vehicle-class"] = vehicleClassSymbol;

        // {{vehicle}} - Vehicle type readable - Chaffee
        pdata["vehicle"] = vdata.localizedName;

        // {{vehicle-name}} - Vehicle system name - usa-M24_Chaffee
        pdata["vehicle-name"] = VehicleInfo.getVIconName(vdata.key)

        // {{vehicle-short}}
        pdata["vehicle-short"] = vdata.shortName;
    }

    public static function RegisterHitlogMacros(playerName:String, data:Object, hits:Array, total:Number)
    {
        if (!data)
            return;

        var pname:String = Utils.GetNormalizedPlayerName(playerName);
        if (!dict.hasOwnProperty(pname))
            dict[pname] = { };
        var pdata = dict[pname];

        // {{dead}}
        pdata["dead"] = data.curHealth < 0
            ? Config.s_config.hitLog.blowupMarker
            : (data.curHealth == 0 || data.dead) ? Config.s_config.hitLog.deadMarker : "";

        // {{n}}
        pdata["n"] = hits.length;

        // {{n-player}}
        pdata["n-player"] = data.hits.length;

        // {{dmg}}
        pdata["dmg"] = data.dmg;

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
        switch (Config.s_game_region)
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
}
