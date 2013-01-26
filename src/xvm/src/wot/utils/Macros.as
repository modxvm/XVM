import com.natecook.Sprintf;
import wot.utils.Cache;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GraphicsUtil;
import wot.utils.Locale;
import wot.utils.Logger;
import wot.utils.Utils;
import wot.utils.VehicleInfo;

class wot.utils.Macros
{
    private static var dummy = Logger.dummy;

    // Level in roman numerals
    public static var rlevel: Array = [ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" ];

    private static var data_provider: Object = {}; //{ PLAYERNAME1: { macro1: func || value, macro2:... }, PLAYERNAME2: {...} }

    public static function Format(playerName, format: String, options:Object): String
    {
        var formatArr:Array = format.split("{{");

        var len = formatArr.length;
        if (len == 1)
            return format;

        var res = formatArr[0];
        var pdata: String = data_provider[Utils.GetNormalizedPlayerName(playerName)];
        for (var i = 1; i < len; ++i)
        {
            var arr2:Array = formatArr[i].split("}}", 2);
            if (arr2.length == 1 || (options && options.skip && options.skip[arr2[0]]))
                res += "{{" + formatArr[i];
            else
            {
                var value = !pdata ? "" : pdata[arr2[0]] || "";
                if (typeof value == "function")
                    res += options ? value(options) : "{{" + arr2[0] + "}}";
                else
                    res += value;
                res += arr2[1];
            }
        }

//Logger.add(playerName + "> " + format);
//Logger.add(playerName + "> " + res);
        return res;
    }

    public static function RegisterPlayerData(playerName:String, data:Object)
    {
        if (!data)
            return;

        var pname:String = Utils.GetNormalizedPlayerName(playerName);
        Cache.Get("_m/" + pname + "/" + data.vehicle, function()
        {
            if (!Macros.data_provider.hasOwnProperty(pname))
                Macros.data_provider[pname] = { };
            var pdata = Macros.data_provider[pname];

            // vars
            var nick = Macros.modXvmDevLabel(data.label +
                (data.label.indexOf("[") >= 0 || !data.clanAbbrev ? "" : "[" + data.clanAbbrev + "]"));

            // {{nick}}
            pdata["nick"] = nick;
            // {{name}}
            pdata["name"] = Utils.GetPlayerName(nick);
            // {{clan}}
            pdata["clan"] = Utils.GetClanNameWithBrackets(nick);
            // {{vehicle}}
            pdata["vehicle"] = VehicleInfo.mapVehicleName(data.icon, data.vehicle);
            // {{vtype}}
            pdata["vtype"] = VehicleInfo.GetVTypeValue(data.icon);
            // {{c:vtype}}
            pdata["c:vtype"] = GraphicsUtil.GetVTypeColorValue(data.icon, data.vtype);

            // VMM only - static
            // {{squad}}
            pdata["squad"] = data.squad || "";
            // {{level}}
            pdata["level"] = data.level ? String(data.level) : "";
            // {{rlevel}}
            pdata["rlevel"] = data.level ? Macros.rlevel[data.level - 1] : "";
            // {{hp-max}}
            pdata["hp-max"] = data.maxHealth ? String(data.maxHealth) : "";
            // {{turret}}
            pdata["turret"] = data.turret || "";

            // VMM only - dynamic
            // {{hp}}
            pdata["hp"] = function(o) { return o && o.curHealth != undefined ? String(o.curHealth) : ""; }
            // {{hp-ratio}}
            pdata["hp-ratio"] = function(o) { return o && o.curHealth != undefined ? Math.round(o.curHealth / data.maxHealth * 100) : ""; }
            // {{dmg}}
            pdata["dmg"] = function(o) { return o && o.delta != undefined ? String(o.delta) : ""; }
            // {{dmg-ratio}}
            pdata["dmg-ratio"] = function(o) { return o && o.delta != undefined ? Math.round(o.delta / data.maxHealth * 100) : ""; }
            // {{dmg-kind}}
            pdata["dmg-kind"] = function(o) { return o && o.delta != undefined ? Locale.get(o.damageType) : ""; }

            // Colors
            // {{c:hp}}
            pdata["c:hp"] = function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, o.curHealth); }
            // {{c:hp-ratio}}, {{c:hp_ratio}}
            pdata["c:hp-ratio"] = function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, o.curHealth / data.maxHealth * 100); }
            pdata["c:hp_ratio"] = pdata["c:hp-ratio"];
            // {{c:dmg}}
            pdata["c:dmg"] = function(o)
                {
                    return o.delta ? GraphicsUtil.GetDmgSrcValue(
                        Macros.damageFlagToDamageSource(o.damageFlag),
                        o.entityName == 'teamKiller' ? (data.team + "tk") : o.entityName,
                        o.dead, o.blowedUp) : "";
                }
            // {{c:dmg-kind}}, {{c:dmg_kind}}
            pdata["c:dmg-kind"] = function(o) { return o.delta ? GraphicsUtil.GetDmgKindValue(o.damageType) : ""; }
            pdata["c:dmg_kind"] = pdata["c:dmg-kind"];
            // {{c:system}}
            pdata["c:system"] = function(o) { return "#" + Utils.padLeft(o.getSystemColor(o).toString(16), 6, "0"); }

            // {{a:hp}}
            pdata["a:hp"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, o.curHealth); }
            // {{a:hp-ratio}}, {{a:hp_ratio}}
            pdata["a:hp-ratio"] = function(o) { return GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO,
                Math.round(o.curHealth / data.maxHealth * 100)); }
            pdata["a:hp_ratio"] = pdata["a:hp-ratio"];

            return true;
        });
    }

    public static function RegisterStatMacros(playerName:String, stat:Object)
    {
        if (!stat)
            return;

        var pname:String = Utils.GetNormalizedPlayerName(playerName);
        if (!data_provider.hasOwnProperty(pname))
            data_provider[pname] = { };
        var pdata = data_provider[pname];

        // vars
        var r:Number = Utils.toInt(stat.r, 0);
        var eff:Number = Utils.toInt(stat.e, 0);
        var b:Number = Utils.toInt(stat.b, 0);
        var w:Number = Utils.toInt(stat.w, 0);
        var tr:Number = Utils.toInt(stat.tr, 0);
        var tb:Number = Utils.toInt(stat.tb, 0);
        var tw:Number = Utils.toInt(stat.tw, 0);
        var tbK:Number = Math.round(tb / 100) / 10;

        // {{eff}}, {{eff:4}}
        pdata["eff"] = eff <= 0 ? "--" : String(eff);
        pdata["eff:4"] = eff <= 0 ? " -- " : Utils.padLeft(pdata["eff"], 4);
        // {{wn}}
        pdata["wn"] = stat.wn <= 0 ? " -- " : Utils.padLeft(String(stat.wn), 4);
        // {{twr}}
        pdata["twr"] = stat.twr <= 0 ? "--%" : Utils.padLeft(String(stat.twr) + "%", 3);
        // {{e}}
        pdata["e"] = stat.te == null ? "-" : stat.te >= 10 ? "E" : String(stat.te);
        // {{teff}}
        pdata["teff"] = stat.teff == null ? " -- " : Utils.padLeft(String(stat.teff), 4);
        // {{teff}}
        pdata["teff"] = stat.teff == null ? " -- " : Utils.padLeft(String(stat.teff), 4);
        // {{teff2}}
        pdata["teff2"] = stat.teff2 == null ? " -- " : Utils.padLeft(String(stat.teff2), 4);

        // {{rating}}, {{rating:3}}
        pdata["rating"] = r <= 0 ? "--%" : String(r) + "%";
        pdata["rating:3"] = Utils.padLeft(pdata["rating"], 3);
        // {{battles}}
        pdata["battles"] = b <= 0 ? "" : String(b);
        // {{wins}}
        pdata["wins"] = b <= 0 ? "" : String(w);
        // {{kb}}, {{kb:3}}
        pdata["kb"] = b <= 0 ? "" : String(Math.round(b / 1000)) + "k";
        pdata["kb:3"] = Utils.padLeft(pdata["kb"], 3);

        // {{t-rating}}, {{t-rating:3}}
        pdata["t-rating"] = tr <= 0 ? "--%" : String(tr) + "%";
        pdata["t-rating:3"] = Utils.padLeft(pdata["t-rating"], 3);
        // {{t-battles}}, {{t-battles:4}}
        pdata["t-battles"] = tb <= 0 ? "" : String(tb);
        pdata["t-battles:4"] = Utils.padLeft(pdata["t-battles"], 4);
        // {{t-wins}}
        pdata["t-wins"] = tb <= 0 ? "" : String(tw);
        // {{t-kb}}, {{t-kb-0}}, {{t-kb:4}}
        pdata["t-kb-0"] = tb <= 0 ? "    " : Utils.padLeft(Sprintf.format("%.1fk", tbK, 4));
        pdata["t-kb:4"] = tbK < 1 ? pdata["t-kb-0"].split("0.", 2).join(" .") : pdata["t-kb-0"]; // remove leading zero before dot
        pdata["t-kb"] = Utils.trim(pdata["t-kb:4"]);
        // {{t-hb}}, {{t-hb:3}}
        pdata["t-hb"] = tb <= 0 ? "" : String(Math.round(tb / 100)) + "h";
        pdata["t-hb:3"] = Utils.padLeft(pdata["t-hb"], 3);
        // {{tdb}}, {{tdb:4}}
        pdata["tdb"] = stat.tdb == null ? "   " : String(stat.tdb);
        pdata["tdb:4"] = Utils.padLeft(pdata["tdb"], 4);
        // {{tdv}}
        pdata["tdv"] = stat.tdv == null ? "   " : Sprintf.format("%.1f", stat.tdv);
        // {{tfb}}
        pdata["tfb"] = stat.tfb == null ? "   " : Sprintf.format("%.1f", stat.tfb);
        // {{tsb}}
        pdata["tsb"] = stat.tsb == null ? "   " : Sprintf.format("%.1f", stat.tsb);

        // Dynamic colors
        // {{c:eff}}
        pdata["c:eff"] = eff <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, eff, "#", o.darken) };
        // {{c:e}}
        pdata["c:e"] = stat.te == null ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, stat.te, "#", o.darken); }
        pdata["c:wn"] = !stat.wn ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN, stat.wn, "#", o.darken) };
        pdata["c:twr"] = !stat.twr ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TWR, stat.twr, "#", o.darken) };
        // {{c:rating}}
        pdata["c:rating"] = r <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, r, "#", o.darken); }
        // {{c:kb}}
        pdata["c:kb"] = b <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, b / 1000, "#", o.darken); }
        // {{c:t-rating}}, {{c:t_rating}}
        pdata["c:t-rating"] = tr <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, tr, "#", o.darken); }
        pdata["c:t_rating"] = pdata["c:t-rating"];
        // {{c:t-battles}}, {{c:t_battles}}
        pdata["c:t-battles"] = tb <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, tb, "#", o.darken); }
        pdata["c:t_battles"] = pdata["c:t-battles"];
        // {{c:tdb}}
        pdata["c:tdb"] = stat.tdb <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, stat.tdb, "#", o.darken); }
        // {{c:tdv}}
        pdata["c:tdv"] = stat.tdv <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, stat.tdv, "#", o.darken); }
        // {{c:tfb}}
        pdata["c:tfb"] = stat.tfb <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, stat.tfb, "#", o.darken); }
        // {{c:tsb}}
        pdata["c:tsb"] = stat.tsb <= 0 ? ""
            : function(o) { return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, stat.tsb, "#", o.darken); }
    }

    // PRIVATE

    private static function modXvmDevLabel(nick:String):String
    {
        var label = Utils.GetPlayerName(nick);
        switch (Config.s_game_region)
        {
            case "RU":
                if (label == "XlebniDizele4ku")
                    return "XlebniDizele4ku!!";
                if (label == "sirmax2" || label == "0x01")
                    return "Сэр Макс (XVM)";
                /** Придурки */
                if (label == "6eC_IIaHuKu") //26.01.13
                    return "kassit macdonalds";
                break;

            case "CT":
                if (label == "XlebniDizele4ku_RU")
                    return "XlebniDizele4ku_XVM";
                if (label == "sirmax2_RU" || label == "0x01_RU")
                    return "Sir Max (XVM)";
                break;

            case "EU":
                if (label == "sirmax2" || label == "0x01")
                    return "Sir Max (XVM)";
                break;

            case "US":
                if (label == "sirmax" || label == "0x01")
                    return "Sir Max (XVM)";
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