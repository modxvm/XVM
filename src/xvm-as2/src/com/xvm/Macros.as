/**
 * XVM Macro substitutions
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.*;
import com.xvm.DataTypes.*;
import wot.Minimap.dataTypes.*;

class com.xvm.Macros
{
    // PUBLIC STATIC

    public static function Format(pname:String, format:String, options:Object):String
    {
        return _instance._Format(pname, format, options);
    }

    public static function FormatGlobalNumberValue(value):Number
    {
        return _instance._FormatGlobalNumberValue(value);
    }

    public static function FormatGlobalBooleanValue(value):Boolean
    {
        return _instance._FormatGlobalBooleanValue(value);
    }

    public static function FormatGlobalStringValue(value):String
    {
        return _instance._FormatGlobalStringValue(value);
    }

    public static function IsCached(pname:String, format:String, alive:Boolean):Boolean
    {
        return _instance._IsCached(pname, format, alive);
    }

    public static function getGlobalValue(key:String)
    {
        return _instance.m_globals[key];
    }

    public static function RegisterPlayerData(pname:String, data:Object, team:Number)
    {
        _instance._RegisterPlayerData(pname, data, team);
    }

    public static function RegisterGlobalMacrosData(battleTier:Number, battleType:Number)
    {
        _instance._RegisterGlobalMacrosData(battleTier, battleType);
    }

    public static function RegisterStatMacros(pname:String, stat:StatData)
    {
        _instance._RegisterStatMacros(pname, stat);
    }

    public static function RegisterMinimapMacros(player:Player, vehicleClassSymbol:String)
    {
        _instance._RegisterMinimapMacros(player, vehicleClassSymbol);
    }

    public static function RegisterMarkerData(pname:String, data:Object)
    {
        _instance._RegisterMarkerData(pname, data);
    }

    public static function UpdateMyFrags(frags:Number)
    {
        if (Macros.s_my_frags == frags)
            return false;
        Macros.s_my_frags = frags;
        return true;
    }

    public static var s_my_frags:Number = 0;

    // PRIVATE

    private static var PART_NAME:Number = 0;
    private static var PART_NORM:Number = 1;
    private static var PART_FMT:Number = 2;
    private static var PART_SUF:Number = 3;
    private static var PART_MATCH_OP:Number = 4;
    private static var PART_MATCH:Number = 5;
    private static var PART_REP:Number = 6;
    private static var PART_DEF:Number = 7;

    private static var _instance:Macros = new Macros();

    private var m_macros_cache:Object = { };
    private var m_macros_cache_global:Object = { };
    private var m_dict:Object = { }; //{ PLAYERNAME1: { macro1: func || value, macro2:... }, PLAYERNAME2: {...} }
    private var m_globals:Object = { };
    private var m_contacts:Object = { };

    private var isStaticMacro:Boolean;

    /**
     * Format string with macros substitutions
     *   {{name[:norm][%[flag][width][.prec]type][~suf][(=|!=|<|<=|>|>=)match][?rep][|def]}}
     * @param pname player name without extra tags (clan, region, etc)
     * @param format string template
     * @param options data for dynamic values
     * @return Formatted string
     */
    private function _Format(pname:String, format:String, options:Object):String
    {
        //Logger.add("format:" + format + " player:" + pname);
        if (format == null || format == "")
            return "";

        try
        {
            // Check cached value
            var player_cache:Object;
            var dead_value:String;
            var cached_value;
            if (pname != null && pname != "" && options != null)
            {
                player_cache = m_macros_cache[pname];
                if (player_cache == null)
                {
                    m_macros_cache[pname] = { alive: { }, dead: { }};
                    player_cache = m_macros_cache[pname];
                }
                dead_value = options.dead == true ? "dead" : "alive";
                cached_value = player_cache[dead_value][format];
            }
            else
            {
                cached_value = m_macros_cache_global[format];
            }

            if (cached_value !== undefined)
            {
                //Logger.add("cached: " + cached_value);
                return cached_value;
            }

            // Split tags
            var formatArr:Array = format.split("{{");

            var res:String = formatArr[0];
            var len:Number = formatArr.length;
            isStaticMacro = true;
            if (len > 1)
            {
                for (var i:Number = 1; i < len; ++i)
                {
                    var part:String = formatArr[i];
                    var idx:Number = part.indexOf("}}");
                    if (idx < 0)
                    {
                        res += "{{" + part;
                    }
                    else
                    {
                        res += FormatPart(part.slice(0, idx), pname, options) + part.slice(idx + 2);
                    }
                }
            }

            if (res != format)
            {
                var iMacroPos:Number = res.indexOf("{{");
                if (iMacroPos >= 0 && res.indexOf("}}", iMacroPos) >= 0)
                {
                    //Logger.add("recursive: " + pname + " " + res);
                    var isStatic:Boolean = isStaticMacro;
                    res = _Format(pname, res, options);
                    isStaticMacro = isStatic && isStaticMacro;
                }
            }

            res = Utils.fixImgTag(res);

            if (isStaticMacro)
            {
                if (pname != null && pname != "")
                {
                    if (options != null)
                    {
                        //Logger.add("add to cache: " + format + " => " + res);
                        player_cache[dead_value][format] = res;
                    }
                }
                else
                {
                    m_macros_cache_global[format] = res;
                }
            }
            //else
            //    Logger.add(pname + "> " + format);

            //Logger.add(pname + "> " + format);
            //Logger.add(pname + "= " + res);

            return res;
        }
        catch (ex:Error)
        {
            Logger.add(ex.message);
        }

        return "";
    }

    private function FormatPart(macro:String, pname:String, options:Object):String
    {
        // Process tag
        var pdata = pname == null ? m_globals : m_dict[pname];
        if (pdata == null)
            return "";

        var res:String = "";

        var parts:Array = GetMacroParts(macro, pdata);

        var macroName:String = parts[PART_NAME];
        var norm:String = parts[PART_NORM];
        var def:String = parts[PART_DEF];

        var vehId:Number = pdata["veh-id"];

        var value;

        var dotPos:Number = macroName.indexOf(".");
        if (dotPos == 0)
        {
            value = SubstituteConfigPart(macroName.slice(1));
        }
        else
        {
            if (dotPos > 0)
            {
                if (options == null)
                    options = { };
                options.__subname = macroName.slice(dotPos + 1);
                macroName = macroName.slice(0, dotPos);
            }

            value = pdata[macroName];

            if (value === undefined)
                value = m_globals[macroName];
        }

        //Logger.add("macro:" + macro + " | macroname:" + macroName + " | norm:" + norm + " | def:" + def + " | value:" + value);

        if (value === undefined)
        {
            //process l10n macro
            if (macroName.indexOf("l10n") == 0)
                res += prepareValue(NaN, macroName, norm, def, vehId);
            else
            {
                res += def;
                if (dotPos != 0)
                    isStaticMacro = false;
            }
        }
        else if (value == null)
        {
            //Logger.add(macroName + " " + norm + " " + def + "  " + format);
            res += prepareValue(NaN, macroName, norm, def, vehId);
        }
        else
        {
            // is static macro
            var type:String = typeof value;
            if (type == "function" && (macroName != "alive" || options == null))
                isStaticMacro = false;

            res += FormatMacro(macro, parts, value, vehId, options);
        }

        return res;
    }

    private var _macro_parts_cache:Object = {};
    private function GetMacroParts(macro:String, pdata:Object):Array
    {
        var parts:Array = _macro_parts_cache[macro];
        if (parts)
            return parts;

        //Logger.add("GetMacroParts: " + macro);
        //Logger.addObject(pdata);

        parts = [null,null,null,null,null,null,null,null];

        // split parts: name[:norm][%[flag][width][.prec]type][~suf][(=|!=|<|<=|>|>=)match][?rep][|def]
        var macroArr:Array = macro.split("");
        var len:Number = macroArr.length;
        var part:String = "";
        var section:Number = 0;
        var nextSection:Number = section;
        for (var i:Number = 0; i < len; ++i)
        {
            var ch:String = macroArr[i];
            switch (ch)
            {
                case ":":
                    if (section < 1 && (pdata.hasOwnProperty(part) || (macro.indexOf("l10n") == 0)))
                        nextSection = 1;
                    break;
                case "%":
                    if (section < 2)
                        nextSection = 2;
                    break;
                case "~":
                    if (section < 3)
                        nextSection = 3;
                    break;
                case "!":
                case "=":
                case ">":
                case "<":
                    if (section < 4)
                    {
                        if (i < len - 1 && macroArr[i + 1] == "=")
                        {
                            i++;
                            ch += macroArr[i];
                        }
                        parts[PART_MATCH_OP] = ch;
                        nextSection = 5;
                    }
                    break;
                case "?":
                    if (section < 6)
                        nextSection = 6;
                    break;
                case "|":
                    if (section < 7)
                        nextSection = 7;
                    break;
            }

            if (nextSection == section)
            {
                part += ch;
            }
            else
            {
                parts[section] = part;
                section = nextSection;
                part = "";
            }
        }
        parts[section] = part;

        if (parts[PART_DEF] == null)
            parts[PART_DEF] = "";

        if (parts[PART_NAME] == "r" && parts[PART_DEF] == "")
            parts[PART_DEF] = getRatingDefaultValue();

        //Logger.add("[AS2][MACROS][GetMacroParts]: " + parts.join(", "));
        _macro_parts_cache[macro] = parts;
        return parts;
    }

    private function SubstituteConfigPart(path:String):String
    {
        var res = Utils.getObjectValueByPath(Config.config, path);
        //Logger.addObject(res, 1, path);
        if (res == null)
            return res;
        if (typeof(res) == "object")
            return JSONx.stringify(res, "", true);
        return String(res);
    }

    private var _format_macro_fmt_suf_cache:Object = {};
    private function FormatMacro(macro:String, parts:Array, value, vehId:Number, options:Object):String
    {
        var name:String = parts[PART_NAME];
        var norm:String = parts[PART_NORM];
        var fmt:String = parts[PART_FMT];
        var suf:String = parts[PART_SUF];
        var match_op:String = parts[PART_MATCH_OP];
        var match:String = parts[PART_MATCH];
        var rep:String = parts[PART_REP];
        var def:String = parts[PART_DEF];

        // substitute
        //Logger.add("name:" + name + " norm:" + norm + " fmt:" + fmt + " suf:" + suf + " rep:" + rep + " def:" + def);

        var type:String = typeof value;
        //Logger.add("type:" + type + " value:" + value + " name:" + name + " fmt:" + fmt + " suf:" + suf + " def:" + def + " macro:" + macro);

        if (type == "number" && isNaN(value))
            return prepareValue(NaN, name, norm, def, vehId);

        var res:String = value;
        if (type == "function")
        {
            if (options == null)
                return "{{" + macro + "}}";
            value = value(options);
            if (value == null)
                return prepareValue(NaN, name, norm, def, vehId);
            type = typeof value;
            if (type == "number" && isNaN(value))
                return prepareValue(NaN, name, norm, def, vehId);
            res = value;
        }

        if (match != null)
        {
            var matched:Boolean = false;
            switch (match_op)
            {
                case "=":
                case "==":
                    matched = value == match;
                    break;
                case "!=":
                    matched = value != match;
                    break;
                case "<":
                    matched = Number(value) < Number(match);
                    break;
                case "<=":
                    matched = Number(value) <= Number(match);
                    break;
                case ">":
                    matched = Number(value) > Number(match);
                    break;
                case ">=":
                    matched = Number(value) >= Number(match);
                    break;
            }
            if (!matched)
                return prepareValue(NaN, name, norm, def, vehId);
        }

        if (rep != null)
            return rep;

        if (norm != null && type == "number")
            res = prepareValue(value, name, norm, def, vehId);

        if (fmt == null && suf == null)
            return res;

        var fmt_suf_key:String = fmt + "," + suf + "," + res;
        var fmt_suf_res:String = _format_macro_fmt_suf_cache[fmt_suf_key];
        if (fmt_suf_res)
            return fmt_suf_res;

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
                    var fmt_parts:Array = fmt.split(".", 2);
                    if (fmt_parts.length == 2)
                    {
                        fmt_parts = fmt_parts[1].split('');
                        var len:Number = fmt_parts.length;
                        var precision:Number = 0;
                        for (var i:Number = 0; i < len; ++i)
                        {
                            var ch:String = fmt_parts[i];
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
        _format_macro_fmt_suf_cache[fmt_suf_key] = res;
        return res;
    }

    private var _prepare_value_cache:Object = {};
    private function prepareValue(value:Number, name:String, norm:String, def:String, vehId:Number):String
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
                var key:String = name + "," + norm + "," + value + "," + vehId;
                res = _prepare_value_cache[key];
                if (res)
                    return res;
                if (isNaN(value))
                {
                    var vdata:VehicleData = VehicleInfo.get(vehId);
                    if (vdata == null)
                        break;
                    value = vdata.hpTop;
                }
                if (!isNaN(value))
                {
                    var maxHp:Number = m_globals["maxhp"];
                    res = Math.round(parseInt(norm) * value / maxHp).toString();
                }
                _prepare_value_cache[key] = res;
                //Logger.add(key + " => " + res);
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

    private function _FormatGlobalNumberValue(value):Number
    {
        if (!isNaN(value))
            return value;
        return parseFloat(_Format(null, value, {}));
    }

    private function _FormatGlobalBooleanValue(value):Boolean
    {
        if (typeof value == "boolean")
            return value;
        return String(_Format(null, value, {})).toLowerCase() == 'true';
    }

    private function _FormatGlobalStringValue(value):String
    {
        return _Format(null, String(value), {});
    }

    /**
     * Is macros value cached
     * @param pname player name without extra tags (clan, region, etc)
     * @param format string template
     * @param options data for dynamic values
     * @return true if macros value is cached else false
     */
    private function _IsCached(pname:String, format:String, alive:Boolean):Boolean
    {
        if (format == null || format == "")
            return false;

        if (pname != null && pname != "")
        {
            var player_cache:Object = m_macros_cache[pname];
            if (player_cache == null)
                return false;
            return player_cache[alive ? "alive" : "dead"][format] !== undefined;
        }
        else
        {
            return m_macros_cache_global[format] !== undefined;
        }
    }

    // Macros registration

    private function _RegisterGlobalMacrosData(battleTier:Number, battleType:Number)
    {
        // {{xvm-stat}}
        m_globals["xvm-stat"] = Config.networkServicesSettings.statBattle == true ? 'stat' : null;

        // {{r_size}}
        m_globals["r_size"] = getRatingDefaultValue().length;

        switch (battleType)
        {
            case Defines.BATTLE_TYPE_CYBERSPORT:
                battleTier = 8;
                break;
            case Defines.BATTLE_TYPE_REGULAR:
                break;
            default:
                battleTier = 10;
                break;
        }

        // {{battletype}}
        m_globals["battletype"] = Utils.getBattleTypeText(battleType);
        // {{battletier}}
        m_globals["battletier"] = battleTier;

        // {{my-frags}}
        m_globals["my-frags"] = function(o:Object) { return isNaN(Macros.s_my_frags) || Macros.s_my_frags == 0 ? NaN : Macros.s_my_frags; }
    }

    /**
     * Register minimal macros values for player
     * @param pname plain player name without extra tags (clan, region, etc)
     * @param playerId player id
     * @param fullPlayerName full player name with extra tags (clan, region, etc)
     */
    private function _RegisterMinimalMacrosData(pname:String, playerId:Number, fullPlayerName:String, team:Number)
    {
        if (!Config.config)
            return;
        if (!m_dict.hasOwnProperty(pname))
            m_dict[pname] = { };
        var pdata = m_dict[pname];

        if (!pdata.hasOwnProperty("name"))
        {
            var name:String = getCustomPlayerName(pname, playerId);
            var clanIdx:Number = name.indexOf("[");
            if (clanIdx > 0)
            {
                fullPlayerName = name;
                name = Strings.trim(name.slice(0, clanIdx));
            }

            var clanWithoutBrackets:String = Utils.GetClanNameWithoutBrackets(fullPlayerName);
            var clanWithBrackets:String = Utils.GetClanNameWithBrackets(fullPlayerName);

            // {{nick}}
            pdata["nick"] = name + (clanWithBrackets || "");
            // {{name}}
            pdata["name"] = name;
            // {{clan}}
            pdata["clan"] = clanWithBrackets;
            // {{clannb}}
            pdata["clannb"] = clanWithoutBrackets;
            // {{ally}}
            pdata["ally"] = team == Defines.TEAM_ALLY ? 'ally' : null;
        }
    }

    private function _RegisterPlayerData(pname:String, data:Object, team:Number)
    {
        if (!Config.config)
            return;
        if (!data)
            return;
        if (!m_dict.hasOwnProperty(pname))
            m_dict[pname] = { };
        var pdata = m_dict[pname];

        //Logger.addObject(data);

        // Static macros

        // player name
        var fullPlayerName:String = data.label;
        var idx:Number = fullPlayerName.indexOf("[");
        if (idx < 0 && data.clanAbbrev != null && data.clanAbbrev != "")
            fullPlayerName += "[" + data.clanAbbrev + "]";
        _RegisterMinimalMacrosData(pname, data.uid, fullPlayerName, team);

        if (!pdata.hasOwnProperty("player"))
        {
            // {{player}}
            pdata["player"] = data.himself == true ? "pl" : null;
        }

        // vehicle
        if (!pdata.hasOwnProperty("veh-id") || (pdata["veh-id"] == 0 && data.vid != 0))
        {
            var vdata:VehicleData = VehicleInfo.get(data.vid);
            //Logger.addObject(vdata);
            if (vdata != null)
            {
                if (!m_globals["maxhp"] || m_globals["maxhp"] < vdata.hpTop)
                    m_globals["maxhp"] = vdata.hpTop;
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
                // {{vtype-l}} - Medium Tank
                pdata["vtype-l"] = Locale.get(vdata.vtype);
                // {{c:vtype}}
                pdata["c:vtype"] = GraphicsUtil.GetVTypeColorValue(data.vid);
                // {{battletier-min}}
                pdata["battletier-min"] = vdata.tierLo;
                // {{battletier-max}}
                pdata["battletier-max"] = vdata.tierHi;
                // {{nation}}
                pdata["nation"] = vdata.nation;
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
            // {{marksOnGun}}
            pdata["marksOnGun"] = function(o):String { return isNaN(o.marksOnGun) || pdata["level"] < 5 ? null : Utils.getMarksOnGunText(o.marksOnGun); }

            var vdata:VehicleData = VehicleInfo.get(pdata["veh-id"]);
            var isArty:Boolean = (vdata != null && vdata.vclass == "SPG");
            // {{spotted}}
            pdata["spotted"] = function(o):String { return Utils.getSpottedText(o.dead ? "dead" : o.spotted == null ? "neverSeen" : o.spotted, isArty); }
            // {{c:spotted}}
            pdata["c:spotted"] = function(o):String { return GraphicsUtil.GetSpottedColorValue(o.dead ? "dead" : o.spotted == null ? "neverSeen" : o.spotted, isArty); }
            // {{a:spotted}}
            pdata["a:spotted"] = function(o):Number { return GraphicsUtil.GetSpottedAlphaValue(o.dead ? "dead" : o.spotted == null ? "neverSeen" : o.spotted, isArty); }
            // {{selected}}
            pdata["selected"] = function(o):String { return o.selected == true ? 'sel' : null; }

            // {{position}}
            pdata["position"] = function(o):String { return o.position <= 0 ? NaN : o.position; }

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
                //Logger.addObject(o);
                //Logger.addObject(data);
                if (isNaN(o.delta))
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
                            o.teamKiller ? ((team == Defines.TEAM_ALLY ? "ally" : "enemy") + "tk") : o.entityName,
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

    private function _RegisterStatMacros(pname:String, stat:StatData)
    {
        //Logger.addObject(stat);

        if (!stat)
            return;
        if (!m_dict.hasOwnProperty(pname))
            m_dict[pname] = { };
        var pdata = m_dict[pname];

        // Register contacts data
        //Logger.addObject(stat, 2);
        delete m_macros_cache[pname];
        delete pdata["name"];
        m_contacts[String(stat._id)] = stat.xvm_contact_data;
        _RegisterMinimalMacrosData(pname, stat._id, stat.name + (stat.clan == null || stat.clan == "" ? "" : "[" + stat.clan + "]"), stat.team);

        // {{region}}
        pdata["region"] = Config.config.region;

        // {{squad-num}}
        pdata["squad-num"] = stat.squadnum > 0 ? stat.squadnum : null;
        // {{xvm-user}}
        pdata["xvm-user"] = Utils.getXvmUserText(stat.status);
        // {{language}}
        pdata["language"] = stat.lang;
        // {{clanrank}}
        pdata["clanrank"] = isNaN(stat.clanInfoRank) ? null : stat.clanInfoRank == 0 ? "persist" : String(stat.clanInfoRank);
        // {{topclan}}
        pdata["topclan"] = Utils.getTopClanText(stat.clanInfoRank);

        // {{avglvl}}
        pdata["avglvl"] = stat.lvl;
        // {{xte}}
        pdata["xte"] = isNaN(stat.v.xte) || stat.v.xte <= 0 ? null : stat.v.xte == 100 ? "XX" : (stat.v.xte < 10 ? "0" : "") + stat.v.xte;
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
        pdata["eff"] = isNaN(stat.e) ? null : Math.round(stat.e);
        // {{wn6}}
        pdata["wn6"] = isNaN(stat.wn6) ? null : Math.round(stat.wn6);
        // {{wn8}}
        pdata["wn8"] = isNaN(stat.wn8) ? null : Math.round(stat.wn8);
        // {{wn}}
        pdata["wn"] = pdata["wn8"];
        // {{wgr}}
        pdata["wgr"] = isNaN(stat.wgr) ? null : Math.round(stat.wgr);
        // {{r}}
        pdata["r"] = getRating(pdata, "", "");
        // {{xr}}
        pdata["xr"] = getRating(pdata, "", "", "xvm");

        // {{winrate}}
        pdata["winrate"] = stat.winrate;
        // {{rating}} (obsolete)
        pdata["rating"] = pdata["winrate"];
        // {{battles}}
        pdata["battles"] = stat.b;
        // {{wins}}
        pdata["wins"] = stat.b;
        // {{kb}}
        pdata["kb"] = stat.b / 1000;

        // {{t-winrate}}
        pdata["t-winrate"] = stat.v.winrate;
        // {{t-rating}} (obsolete)
        pdata["t-rating"] = pdata["t-winrate"];
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
        // {{c:xte}}
        pdata["c:xte"] =   isNaN(stat.v.xte) || stat.v.xte <= 0 ? null : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.v.xte, "#", false);
        pdata["c:xte#d"] = isNaN(stat.v.xte) || stat.v.xte <= 0 ? null : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.v.xte, "#", true);
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
        // {{c:r}}
        pdata["c:r"] = getRating(pdata, "c:", "");
        pdata["c:r#d"] = getRating(pdata, "c:", "#d");
        // {{c:xr}}
        pdata["c:xr"] = getRating(pdata, "c:", "", "xvm");
        pdata["c:xr#d"] = getRating(pdata, "c:", "#d", "xvm");

        // {{c:winrate}}
        pdata["c:winrate"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.winrate, "#", false);
        pdata["c:winrate#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.winrate, "#", true);
        // {{c:rating}} (obsolete)
        pdata["c:rating"] =   pdata["c:winrate"];
        pdata["c:rating#d"] = pdata["c:winrate#d"];
        // {{c:kb}}
        pdata["c:kb"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, stat.b / 1000, "#", false);
        pdata["c:kb#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, stat.b / 1000, "#", true);
        // {{c:avglvl}}
        pdata["c:avglvl"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_AVGLVL, stat.lvl, "#", false);
        pdata["c:avglvl#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_AVGLVL, stat.lvl, "#", true);
        // {{c:t-winrate}}
        pdata["c:t-winrate"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.v.winrate, "#", false);
        pdata["c:t-winrate#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.v.winrate, "#", true);
        // {{c:t-rating}} (obsolete)
        pdata["c:t-rating"] =   pdata["c:t-winrate"];
        pdata["c:t-rating#d"] = pdata["c:t-winrate#d"];
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
        // {{a:xte}}
        pdata["a:xte"] = isNaN(stat.v.xte) || stat.v.xte <= 0 ? NaN : GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.v.xte);
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
        // {{a:r}}
        pdata["a:r"] = getRating(pdata, "a:", "");
        // {{a:xr}}
        pdata["a:xr"] = getRating(pdata, "a:", "", "xvm");

        // {{a:winrate}}
        pdata["a:winrate"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WINRATE, stat.winrate);
        // {{a:rating}} (obsolete)
        pdata["a:rating"] = pdata["a:winrate"];
        // {{a:kb}}
        pdata["a:kb"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_KB, stat.b / 1000);
        // {{a:avglvl}}
        pdata["a:avglvl"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_AVGLVL, stat.lvl);
        // {{a:t-winrate}}
        pdata["a:t-winrate"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WINRATE, stat.v.winrate);
        // {{a:t-rating}} (obsolete)
        pdata["a:t-rating"] = pdata["a:t-winrate"];
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

    private function _RegisterMinimapMacros(player:Player, vehicleClassSymbol:String)
    {
        if (!player)
            return;
        var pname:String = player.userName;
        if (!m_dict.hasOwnProperty(pname))
            m_dict[pname] = { };
        var pdata = m_dict[pname];

        // {{vehicle-class}} - returns special symbol depending on class
        pdata["vehicle-class"] = vehicleClassSymbol;
    }

    private function _RegisterMarkerData(pname:String, data:Object)
    {
        //Logger.addObject(data);

        if (!data)
            return;
        if (!m_dict.hasOwnProperty(pname))
            m_dict[pname] = { };
        var pdata = m_dict[pname];

        // {{turret}}
        pdata["turret"] = data.turret || "";
    }

    // PRIVATE

    private function getCustomPlayerName(pname:String, uid:Number):String
    {
        //Logger.add(pname + " " + uid);
        switch (Config.config.region)
        {
            case "RU":
                if (pname == "www_modxvm_com")
                    return "www.modxvm.com";
                if (pname == "M_r_A")
                    return "Флаттершай - лучшая пони!";
                if (pname == "sirmax2" || pname == "0x01" || pname == "_SirMax_")
                    return "«сэр Макс» (XVM)";
                if (pname == "Mixailos")
                    return "Михаил";
                if (pname == "STL1te")
                    return "О, СТЛайт!";
				if (pname == "XIebniDizele4ky" || pname == "Xlebni_Dizele4ky" || pname == "XlebniDizeIe4ku" || pname == "XlebniDize1e4ku" || pname == "XlebniDizele4ku_2013")
                    return "Alex Artobanana";
                break;

            case "CT":
                if (pname == "www_modxvm_com")
                    return "www.modxvm.com";
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

        if (m_contacts != null && !isNaN(uid) && uid > 0)
        {
            var cdata:Object = m_contacts[String(uid)];
            if (cdata != null)
            {
                if (cdata.nick != null && cdata.nick != "")
                    pname = cdata.nick;
            }
        }

        return pname;
    }

    private static var RATING_MATRIX:Object =
    {
        xvm_wgr: "xwgr",
        xvm_wn6: "xwn6",
        xvm_wn8: "xwn8",
        xvm_eff: "xeff",
        xvm_xte: "xte",
        basic_wgr: "wgr",
        basic_wn6: "wn6",
        basic_wn8: "wn8",
        basic_eff: "eff",
        basic_xte: "xte"
    }

    private static var RATING_DEFAULTS_MATRIX:Object =
    {
        xvm_wgr: "--",
        xvm_wn6: "--",
        xvm_wn8: "--",
        xvm_eff: "--",
        xvm_xte: "--",
        basic_wgr: "-----",
        basic_wn6: "----",
        basic_wn8: "----",
        basic_eff: "----",
        basic_xte: "--"
    }

    /**
     * Returns rating according settings in the personal cabinet
     */
    private static function getRating(pdata:Object, prefix:String, suffix:String, scale:String)
    {
        var sc:String = (scale == null) ? Config.networkServicesSettings.scale : scale;
        var n:String = sc + "_" + Config.networkServicesSettings.rating;
        if (!RATING_MATRIX.hasOwnProperty(n))
            n = (scale != null ? scale : "basic") + "_wgr";
        var value = pdata[prefix + RATING_MATRIX[n] + suffix];
        if (prefix != "" || value == null)
            return value;
        value = Strings.padLeft(String(value), getRatingDefaultValue().length);
        return value;
    }

    /**
     * Returns default value for rating according settings in the personal cabinet
     */
    private static function getRatingDefaultValue():String
    {
        var n:String = Config.networkServicesSettings.scale + "_" + Config.networkServicesSettings.rating;
        if (!RATING_DEFAULTS_MATRIX.hasOwnProperty(n))
            n = "basic_wgr";
        return RATING_DEFAULTS_MATRIX[n];
    }
}
