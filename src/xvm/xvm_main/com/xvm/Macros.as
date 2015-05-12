/**
 * XVM Macro substitutions
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.types.*;
    import com.xvm.types.stat.*;
    import com.xvm.types.veh.*;
    import com.xvm.utils.*;
    import org.idmedia.as3commons.util.*;

    public class Macros
    {
        // PUBLIC STATIC

        public static function Format(pname:String, format:String, options:MacrosFormatOptions = null):String
        {
            return _instance._Format(pname, format, options);
        }

        public static function FormatGlobalNumberValue(value:*):Number
        {
            return _instance._FormatGlobalNumberValue(value);
        }

        public static function FormatGlobalBooleanValue(value:*):Boolean
        {
            return _instance._FormatGlobalBooleanValue(value);
        }

        public static function FormatGlobalStringValue(value:*):String
        {
            return _instance._FormatGlobalStringValue(value);
        }

        public static function IsCached(pname:String, format:String, alive:Boolean = false):Boolean
        {
            return _instance._IsCached(pname, format, alive);
        }

        public static function getGlobalValue(key:String):*
        {
            return _instance.m_globals[key];
        }

        public static function RegisterGlobalMacrosData():void
        {
            _instance._RegisterGlobalMacrosData();
        }

        public static function RegisterMinimalMacrosData(playerId:Number, fullPlayerName:String, vid:int, team:Number):void
        {
            _instance._RegisterMinimalMacrosData(playerId, fullPlayerName, vid, team);
        }

        public static function RegisterStatMacrosData(pname:String):void
        {
            _instance._RegisterStatMacrosData(pname);
        }

        public static function RegisterVehiclesMacros():void
        {
            _instance._RegisterVehiclesMacros();
        }

        public static function RegisterClockMacros():void
        {
            _instance._RegisterClockMacros();
        }

        // PRIVATE

        private static const PART_NAME:int = 0;
        private static const PART_NORM:int = 1;
        private static const PART_FMT:int = 2;
        private static const PART_SUF:int = 3;
        private static const PART_MATCH_OP:int = 4;
        private static const PART_MATCH:int = 5;
        private static const PART_REP:int = 6;
        private static const PART_DEF:int = 7;

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
        private function _Format(pname:String, format:String, options:MacrosFormatOptions):String
        {
            //Logger.add("format:" + format + " player:" + pname);
            if (format == null || format == "")
                return "";

            try
            {
                // Check cached value
                var player_cache:Object;
                var dead_value:String;
                var cached_value:*;
                if (pname != null && pname != "" && options != null)
                {
                    player_cache = m_macros_cache[pname];
                    if (player_cache == null)
                    {
                        m_macros_cache[pname] = { alive: { }, dead: { }};
                        player_cache = m_macros_cache[pname];
                    }
                    dead_value = options.alive == true ? "alive" : "dead";
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
                var len:int = formatArr.length;
                isStaticMacro = true;
                if (len > 1)
                {
                    for (var i:int = 1; i < len; ++i)
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
                    var iMacroPos:int = res.indexOf("{{");
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
                Logger.err(ex);
            }

            return "";
        }

        private function FormatPart(macro:String, pname:String, options:MacrosFormatOptions):String
        {
            // Process tag
            var pdata:* = pname == null ? m_globals : m_dict[pname];
            if (pdata == null)
                return "";

            var res:String = "";

            var parts:Array = GetMacroParts(macro, pdata);

            var macroName:String = parts[PART_NAME];
            var norm:String = parts[PART_NORM];
            var def:String = parts[PART_DEF];

            var vehId:Number = pdata["veh-id"];

            var value:*;

            var dotPos:int = macroName.indexOf(".");
            if (dotPos == 0)
            {
                value = SubstituteConfigPart(macroName.slice(1));
            }
            else
            {
                if (dotPos > 0)
                {
                    if (options == null)
                        options = new MacrosFormatOptions();
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
                        if (section < 1 && (part != "c" && part != "a"))
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
            else if (parts[PART_NAME] == "xr" && parts[PART_DEF] == "")
                parts[PART_DEF] = getRatingDefaultValue("xvm");

            //Logger.add("[AS3][MACROS][GetMacroParts]: " + parts.join(", "));
            _macro_parts_cache[macro] = parts;
            return parts;
        }

        private function SubstituteConfigPart(path:String):String
        {
            var res:* = XfwUtils.getObjectValueByPath(Config.config, path);
            if (res == null)
                return res;
            if (typeof(res) == "object")
                return JSONx.stringify(res, "", true);
            return String(res);
        }

        private var _format_macro_fmt_suf_cache:Object = {};
        private function FormatMacro(macro:String, parts:Array, value:*, vehId:Number, options:Object):String
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

            if (norm != null)
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
        private function prepareValue(value:*, name:String, norm:String, def:String, vehId:Number):String
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
                case "r":
                case "xr":
                case "xte":
                case "xwgr":
                case "xwn":
                case "xwn6":
                case "xeff":
                    if (name == "r" && Config.networkServicesSettings.scale != "xvm")
                        break;
                    if (value == 'XX')
                        value = 100;
                    else
                    {
                        value = parseInt(value);
                        if (isNaN(value))
                            value = 0;
                    }
                    res = Math.round(parseInt(norm) * value / 100).toString();
                    break;
                case "l10n":
                    res = Locale.get(norm);
                    break;
            }

            return res;
        }

        private function _FormatGlobalNumberValue(value:*):Number
        {
            if (!isNaN(value))
                return value;
            return parseFloat(_Format(null, value, new MacrosFormatOptions()));
        }

        private function _FormatGlobalBooleanValue(value:*):Boolean
        {
            if (typeof value == "boolean")
                return value;
            return String(_Format(null, value, new MacrosFormatOptions())).toLowerCase() == 'true';
        }

        private function _FormatGlobalStringValue(value:*):String
        {
            return _Format(null, String(value), new MacrosFormatOptions());
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

        private function _RegisterGlobalMacrosData():void
        {
            if (m_globals["xvm-stat"] === undefined)
            {
                // {{xvm-stat}}
                m_globals["xvm-stat"] = Config.networkServicesSettings.statBattle == true ? 'stat' : null;
                // {{r_size}}
                m_globals["r_size"] = getRatingDefaultValue().length;
            }

            if (m_globals["battletier"] === undefined)
            {
                var battleTier:Number = Xfw.cmd(XvmCommandsInternal.GET_BATTLE_LEVEL) || NaN;
                var battleType:Number = Xfw.cmd(XvmCommandsInternal.GET_BATTLE_TYPE) || Defines.BATTLE_TYPE_REGULAR;

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
            }
        }

        /**
         * Register minimal macros values for player
         * @param playerId player id
         * @param fullPlayerName full player name with extra tags (clan, region, etc)
         * @param vid vehicle id
         */
        private function _RegisterMinimalMacrosData(playerId:Number, fullPlayerName:String, vid:int, team:Number):void
        {
            RegisterGlobalMacrosData();

            if (fullPlayerName == null || fullPlayerName == "")
                throw new Error("empty name");

            var pname:String = WGUtils.GetPlayerName(fullPlayerName);

            // check if already registered
            if (m_dict.hasOwnProperty(pname))
            {
                if (m_dict[pname]["vid"] == vid)
                    return;
            }
            else
            {
                m_dict[pname] = new Object();
            }

            var pdata:Object = m_dict[pname];

            var name:String = getCustomPlayerName(pname, playerId);
            var clanIdx:int = name.indexOf("[");
            if (clanIdx > 0)
            {
                fullPlayerName = name;
                name = StringUtils.trim(name.slice(0, clanIdx));
            }
            var clanWithoutBrackets:String = WGUtils.GetClanNameWithoutBrackets(fullPlayerName);
            var clanWithBrackets:String = WGUtils.GetClanNameWithBrackets(fullPlayerName);

            // {{nick}}
            pdata["nick"] = name + (clanWithBrackets || "");
            // {{name}}
            pdata["name"] = name;
            // {{clan}}
            pdata["clan"] = clanWithBrackets;
            // {{clannb}}
            pdata["clannb"] = clanWithoutBrackets;
            // {{ally}}
            pdata["ally"] = team == XfwConst.TEAM_ALLY ? 'ally' : null;

            // Next macro unique for vehicle
            var vdata:VehicleData = VehicleInfo.get(vid);
            // Internal use
            pdata["vid"] = vid;
            // {{vehicle}} - T-34-85
            pdata["vehicle"] = vdata.localizedName;
            // {{vehiclename}} - ussr-T-34-85
            pdata["vehiclename"] = VehicleInfo.getVIconName(vdata.key);
            // {{nation}}
            pdata["nation"] = vdata.nation;
            // {{level}}
            pdata["level"] = vdata.level;
            // {{rlevel}}
            pdata["rlevel"] = Defines.ROMAN_LEVEL[vdata.level - 1];
            // {{vtype}} - MT
            pdata["vtype"] = VehicleInfo.getVTypeText(vdata.vtype);
            // {{vtype-l}} - Medium Tank
            pdata["vtype-l"] = Locale.get(vdata.vtype);
            // {{c:vtype}}
            pdata["c:vtype"] = MacrosUtils.GetVClassColorValue(vdata);
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
                // {{selected}}
                pdata["selected"] = function(o:MacrosFormatOptions):String { return o.selected ? 'sel' : null; }
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
                // {{position}}
                pdata["position"] = function(o:MacrosFormatOptions):Number { return o.position <= 0 ? NaN : o.position; }
            }
        }

        /**
         * Register stat macros values for player
         * @param pname player name without extra tags (clan, region, etc)
         */
        private function _RegisterStatMacrosData(pname:String):void
        {
            var stat:StatData = Stat.getData(pname);
            if (stat == null)
                return;

            // Register contacts data
            delete m_macros_cache[pname];
            if (m_dict.hasOwnProperty(pname) && m_dict[pname].hasOwnProperty("vid"))
                delete m_dict[pname]["vid"];
            m_contacts[String(stat._id)] = stat.xvm_contact_data;
            RegisterMinimalMacrosData(stat._id, stat.name + (stat.clan == null || stat.clan == "" ? "" : "[" + stat.clan + "]"), stat.v.id, stat.team);

            var pdata:Object = m_dict[pname];

            if (Config.networkServicesSettings.servicesActive != true)
                return;

            // {{xvm-user}}
            pdata["xvm-user"] = Utils.getXvmUserText(stat.status);
            // {{flag}}
            pdata["flag"] = stat.flag;
            // {{clanrank}}
            pdata["clanrank"] = isNaN(stat.clanInfoRank) ? null : stat.clanInfoRank == 0 ? "persist" : String(stat.clanInfoRank);
            // {{topclan}}
            pdata["topclan"] = Utils.getTopClanText(stat.clanInfoRank);
            // {{region}}
            pdata["region"] = Config.gameRegion;
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
            pdata["r"] = getRating(pdata, "", "", null);
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
            pdata["c:xte"] = function(o:MacrosFormatOptions):String { return isNaN(stat.v.xte) || stat.v.xte <= 0 ? null : MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.v.xte, "#"); }
            // {{c:xeff}}
            pdata["c:xeff"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xeff, "#"); }
            // {{c:xwn6}}
            pdata["c:xwn6"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn6, "#"); }
            // {{c:xwn8}}
            pdata["c:xwn8"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn8, "#"); }
            // {{c:xwn}}
            pdata["c:xwn"] = pdata["c:xwn8"]
            // {{c:xwgr}}
            pdata["c:xwgr"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwgr, "#"); }
            // {{c:eff}}
            pdata["c:eff"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, stat.e, "#"); }
            // {{c:wn6}}
            pdata["c:wn6"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN6, stat.wn6, "#"); }
            // {{c:wn8}}
            pdata["c:wn8"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, stat.wn8, "#"); }
            // {{c:wn}}
            pdata["c:wn"] = pdata["c:wn8"];
            // {{c:wgr}}
            pdata["c:wgr"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WGR, stat.wgr, "#"); }
            // {{c:r}}
            pdata["c:r"] = getRating(pdata, "c:", "", null);
            // {{c:xr}}
            pdata["c:xr"] = getRating(pdata, "c:", "", "xvm");

            // {{c:winrate}}
            pdata["c:winrate"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.winrate, "#"); }
            // {{c:rating}} (obsolete)
            pdata["c:rating"] = pdata["c:winrate"]
            // {{c:kb}}
            pdata["c:kb"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, stat.b / 1000.0, "#"); }
            // {{c:avglvl}}
            pdata["c:avglvl"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_AVGLVL, stat.lvl, "#"); }
            // {{c:t-winrate}}
            pdata["c:t-winrate"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.v.winrate, "#"); }
            // {{c:t-rating}} (obsolete)
            pdata["c:t-rating"] = pdata["c:t-winrate"];
            // {{c:t-battles}}
            pdata["c:t-battles"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, stat.v.b, "#"); }
            // {{c:tdb}}
            pdata["c:tdb"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, stat.v.db, "#"); }
            // {{c:tdv}}
            pdata["c:tdv"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, stat.v.dv, "#"); }
            // {{c:tfb}}
            pdata["c:tfb"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, stat.v.fb, "#"); }
            // {{c:tsb}}
            pdata["c:tsb"] = function(o:MacrosFormatOptions):String { return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, stat.v.sb, "#"); }

            // Alpha
            // {{a:xte}}
            pdata["a:xte"] = isNaN(stat.v.xte) || stat.v.xte <= 0 ? NaN : MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.v.xte);
            // {{a:xeff}}
            pdata["a:xeff"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xeff);
            // {{a:xwn6}}
            pdata["a:xwn6"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn6);
            // {{a:xwn8}}
            pdata["a:xwn8"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn8);
            // {{a:xwn}}
            pdata["a:xwn"] = pdata["a:xwn8"];
            // {{a:xwgr}}
            pdata["a:xwgr"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwgr);
            // {{a:eff}}
            pdata["a:eff"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_EFF, stat.e);
            // {{a:wn6}}
            pdata["a:wn6"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN6, stat.wn6);
            // {{a:wn8}}
            pdata["a:wn8"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN8, stat.wn8);
            // {{a:wn}}
            pdata["a:wn"] = pdata["a:wn8"];
            // {{a:wgr}}
            pdata["a:wgr"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WGR, stat.wgr);
            // {{a:r}}
            pdata["a:r"] = getRating(pdata, "a:", "", null);
            // {{a:xr}}
            pdata["a:xr"] = getRating(pdata, "a:", "", "xvm");

            // {{a:winrate}}
            pdata["a:winrate"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WINRATE, stat.winrate);
            // {{a:rating}} (obsolete)
            pdata["a:rating"] = pdata["a:winrate"];
            // {{a:kb}}
            pdata["a:kb"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_KB, stat.b / 1000);
            // {{a:avglvl}}
            pdata["a:avglvl"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_AVGLVL, stat.lvl);
            // {{a:t-winrate}}
            pdata["a:t-winrate"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WINRATE, stat.v.winrate);
            // {{a:t-rating}} (obsolete)
            pdata["a:t-rating"] = pdata["a:t-winrate"];
            // {{a:t-battles}}
            pdata["a:t-battles"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TBATTLES, stat.v.b);
            // {{a:tdb}}
            pdata["a:tdb"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TDB, stat.v.db);
            // {{a:tdv}}
            pdata["a:tdv"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TDV, stat.v.dv);
            // {{a:tfb}}
            pdata["a:tfb"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TFB, stat.v.fb);
            // {{a:tsb}}
            pdata["a:tsb"] = MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TSB, stat.v.sb);
        }

        private function _RegisterVehiclesMacros():void
        {
            if (!m_globals.hasOwnProperty("v"))
            {
                m_globals["v"] = function(o:MacrosFormatOptions):* {
                    if (o == null || o.__subname == null || o.vdata == null)
                        return null;
                    return o.vdata[o.__subname];
                }
            }
        }

        private function _RegisterClockMacros():void
        {
            if (!m_globals.hasOwnProperty("_clock"))
            {
                m_globals["_clock"] = function(o:MacrosFormatOptions):* {
                    if (o == null || o.__subname == null)
                        return null;
                    var date:Date = App.utils.dateTime.now();
                    var H:Number = date.hours % 12;
                    if (H == 0)
                        H = 12;
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
                        case "H": return H;
                        case "AM": return date.hours < 12 ? "AM" : null;
                        default: return "";
                    }
                }
            }
        }

        /**
         * Change nicks for XVM developers.
         * @param pname player name
         * @return personal name
         */
        private function getCustomPlayerName(pname:String, uid:Number):String
        {
            switch (Config.gameRegion)
            {
                case "RU":
                    if (pname == "www_modxvm_com")
                        return "www.modxvm.com";
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
                    if (pname == "www_modxvm_com_RU")
                        return "www.modxvm.com";
                    if (pname == "M_r_A_RU" || pname == "M_r_A_EU")
                        return "Fluttershy is best pony!";
                    if (pname == "sirmax2_RU" || pname == "sirmax2_EU" || pname == "sirmax_NA" || pname == "0x01_RU" || pname == "0x01_EU")
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

        // rating

        private static var RATING_MATRIX:Object =
        {
            xvm_wgr:   { name: "xwgr", def: "--" },
            xvm_wn6:   { name: "xwn6", def: "--" },
            xvm_wn8:   { name: "xwn8", def: "--" },
            xvm_eff:   { name: "xeff", def: "--" },
            xvm_xte:   { name: "xte",  def: "--" },
            basic_wgr: { name: "wgr",  def: "-----" },
            basic_wn6: { name: "wn6",  def: "----" },
            basic_wn8: { name: "wn8",  def: "----" },
            basic_eff: { name: "eff",  def: "----" },
            basic_xte: { name: "xte",  def: "--" }
        }

        /**
         * Returns rating according settings in the personal cabinet
         */
        private static function getRating(pdata:Object, prefix:String, suffix:String, scale:String):*
        {
            var name:String = _getRatingName(scale);
            var value:* = pdata[prefix + RATING_MATRIX[name].name + suffix];
            if (prefix != "" || value == null)
                return value;
            value = StringUtils.leftPad(String(value), getRatingDefaultValue(scale).length, " ");
            return value;
        }

        /**
         * Returns default value for rating according settings in the personal cabinet
         */
        private static function getRatingDefaultValue(scale:String = null):String
        {
            var name:String = _getRatingName(scale);
            return RATING_MATRIX[name].def;
        }

        private static function _getRatingName(scale:String):String
        {
            var sc:String = (scale == null) ? Config.networkServicesSettings.scale : scale;
            var name:String = sc + "_" + Config.networkServicesSettings.rating;
            if (!RATING_MATRIX.hasOwnProperty(name))
                name = (scale != null ? scale : "basic") + "_wgr";
            return name;
        }
    }
}
