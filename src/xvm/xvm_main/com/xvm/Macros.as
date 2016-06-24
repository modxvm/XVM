/**
 * XVM Macro substitutions
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.types.stat.*;
    import com.xvm.vo.*;
    import flash.utils.*;
    import org.idmedia.as3commons.util.*;

    public class Macros
    {
        // PUBLIC STATIC

        public static function Format(pname:String, format:*, options:IVOMacrosOptions = null):*
        {
            return _instance._Format(pname, format, options);
        }

        public static function FormatByPlayerId(playerId:Number, format:*, options:IVOMacrosOptions = null):*
        {
            return _instance._Format(_instance.m_playerId_to_pname[playerId], format, options);
        }

        public static function FormatNumber(pname:String, format:*, options:IVOMacrosOptions, nullValue:Number = NaN, emptyValue:Number = NaN, isColorValue:Boolean = false):Number
        {
            var value:* = format;
            if (value == null)
                return nullValue;
            if (isNaN(value))
            {
                //Logger.add(value + " => " + Macros.Format(pname, value, options));
                var v:* = Macros.Format(pname, value, options);
                if (v == "XX")
                    v = 100;
                if (isColorValue)
                    v = v.split("#").join("0x");
                value = v;
            }
            if (isNaN(value))
                return emptyValue;
            return Number(value);
        }

        public static function GlobalNumber(value:*, defaultValue:Number = NaN, options:IVOMacrosOptions = null):Number
        {
            return _instance._GlobalNumber(value, defaultValue, options);
        }

        public static function GlobalBoolean(value:*, defaultValue:Boolean = false, options:IVOMacrosOptions = null):Boolean
        {
            return _instance._GlobalBoolean(value, defaultValue, options);
        }

        public static function GlobalString(value:*, defaultValue:String = null, options:IVOMacrosOptions = null):String
        {
            return _instance._GlobalString(value, defaultValue, options);
        }

        public static function IsCached(pname:String, format:*):Boolean
        {
            return _instance._IsCached(pname, format);
        }

        public static function getGlobalValue(key:String):*
        {
            return _instance.m_globals[key];
        }

        // common

        public static function RegisterXvmServicesMacrosData():void
        {
            _instance._RegisterXvmServicesMacrosData();
        }

        public static function RegisterGlobalMacrosData():void
        {
            _instance._RegisterGlobalMacrosData();
        }

        public static function RegisterStatisticsMacros(pname:String, stat:StatData):void
        {
            _instance._RegisterStatisticsMacros(pname, stat);
        }

        // battle

        public static function RegisterBattleGlobalMacrosData(callback:Function):void
        {
            callback(_instance.m_globals);
        }

        public static function RegisterMinimalMacrosData(accountDBID:Number, playerFullName:String, vehCD:Number, isPlayerTeam:Boolean):void
        {
            _instance._RegisterMinimalMacrosData(accountDBID, playerFullName, vehCD, isPlayerTeam);
        }

        public static function RegisterPlayersData(callback:Function):void
        {
            callback(_instance.m_dict);
        }

        /*public static function RegisterGlobalMacrosDataDelayed(onEventName:String):void
        {
            _instance._RegisterGlobalMacrosDataDelayed(onEventName);
        }*/

        /*public static function RegisterZoomIndicatorData(zoom:Number):void
        {
            _instance._RegisterZoomIndicatorData(zoom);
        }*/

        /*public static function RegisterMarkerData(pname:String, data:Object):void
        {
            _instance._RegisterMarkerData(pname, data);
        }*/

        // lobby

        public static function RegisterVehiclesMacros(callback:Function):void
        {
            callback(_instance.m_globals);
        }

        public static function RegisterClockMacros(callback:Function):void
        {
            callback(_instance.m_globals);
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
        private var m_playerId_to_pname:Object = { };
        private var m_globals:Object = { };
        private var m_contacts:Object = { };

        private var curent_xtdb:Number = 0;

        private var isStaticMacro:Boolean;

        /**
         * Format string with macros substitutions
         *   {{name[:norm][%[flag][width][.prec]type][~suf][(=|!=|<|<=|>|>=)match][?rep][|def]}}
         * @param pname player name without extra tags (clan, region, etc)
         * @param format string template
         * @param options data for dynamic values
         * @return Formatted string
         */
        private function _Format(pname:String, format:*, options:IVOMacrosOptions):*
        {
            //Logger.add("format:" + format + " player:" + pname);

            if (format === undefined || XfwUtils.isPrimitiveTypeAndNotString(format))
                return format;

            format = String(format);
            if (format == "")
                return format;

            try
            {
                // Check cached value
                var player_cache:Object;
                var cached_value:*;
                if (pname != null && pname != "" && options != null)
                {
                    player_cache = m_macros_cache[pname];
                    if (player_cache == null)
                    {
                        m_macros_cache[pname] = { };
                        player_cache = m_macros_cache[pname];
                    }
                    cached_value = player_cache[format];
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

                isStaticMacro = true;
                var res:String;
                var len:int = formatArr.length;
                if (len <= 1)
                {
                    res = format;
                }
                else
                {
                    res = formatArr[0];

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
                            res += _FormatPart(part.slice(0, idx), pname, options) + part.slice(idx + 2);
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
                }

                res = Utils.fixImgTag(res);

                if (isStaticMacro)
                {
                    if (pname != null && pname != "")
                    {
                        if (options != null)
                        {
                            //Logger.add("add to cache: " + format + " => " + res);
                            player_cache[format] = res;
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

        private function _FormatPart(macro:String, pname:String, options:IVOMacrosOptions):String
        {
            // Process tag
            var pdata:* = pname == null ? m_globals : m_dict[pname];
            if (pdata == null)
                return "";

            var res:String = "";

            var parts:Array = _GetMacroParts(macro, pdata);

            var macroName:String = parts[PART_NAME];
            var norm:String = parts[PART_NORM];
            var def:String = parts[PART_DEF];

            var vehCD:Number = pdata["veh-id"];

            var value:*;

            var dotPos:int = macroName.indexOf(".");
            if (dotPos == 0)
            {
                value = _SubstituteConfigPart(macroName.slice(1));
            }
            else
            {
                if (dotPos > 0)
                {
                    if (options == null)
                        options = new VOMacrosOptions();
                    options.setSubname(macroName.slice(dotPos + 1));
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
                if (macroName == "l10n")
                {
                    res += prepareValue(NaN, macroName, norm, def, vehCD);
                }
                else if (macroName == "py")
                {
                    res += prepareValue(NaN, macroName, norm, def, vehCD);
                }
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
                res += prepareValue(NaN, macroName, norm, def, vehCD);
            }
            else
            {
                // is static macro
                var type:String = typeof value;
                if (type == "function" && options == null)
                    isStaticMacro = false;
                else if (vehCD == 0)
                {
                    switch (macroName)
                    {
                        case "maxhp":
                        case "veh-id":
                        case "vehicle":
                        case "vehiclename":
                        case "vehicle-short":
                        case "vtype-key":
                        case "vtype":
                        case "vtype-l":
                        case "c:vtype":
                        case "battletier-min":
                        case "battletier-max":
                        case "nation":
                        case "level":
                        case "rlevel":
                            isStaticMacro = false;
                            break;
                    }
                }

                res += _FormatMacro(macro, parts, value, vehCD, options);
            }

            if (isStaticMacro)
            {
                switch (macroName)
                {
                    case "squad":
                    case "squad-num":
                    case "zoom":
                        isStaticMacro = false;
                        break;
                }
            }

            return res;
        }

        private var _macro_parts_cache:Object = {};
        private function _GetMacroParts(macro:String, pdata:Object):Array
        {
            var parts:Array = _macro_parts_cache[macro];
            if (parts)
                return parts;

            //Logger.add("_GetMacroParts: " + macro);
            //Logger.addObject(pdata);

            parts = [null,null,null,null,null,null,null,null];

            // split parts: name[:norm][%[flag][width][.prec]type][~suf][(=|!=|<|<=|>|>=)match][?rep][|def]
            var macroArr:Array = macro.split("");
            var len:int = macroArr.length;
            var part:String = "";
            var section:int = 0;
            var nextSection:int = section;
            for (var i:int = 0; i < len; ++i)
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
                parts[PART_DEF] = _getRatingDefaultValue();
            else if (parts[PART_NAME] == "xr" && parts[PART_DEF] == "")
                parts[PART_DEF] = _getRatingDefaultValue("xvm");

            //Logger.add("[AS3][MACROS][_GetMacroParts]: " + parts.join(", "));
            _macro_parts_cache[macro] = parts;
            return parts;
        }

        private function _SubstituteConfigPart(path:String):String
        {
            var res:* = XfwUtils.getObjectValueByPath(Config.config, path);
            if (res == null)
                return res;
            if (typeof(res) == "object")
                return JSONx.stringify(res, "", true);
            return String(res);
        }

        private var _format_macro_fmt_suf_cache:Object = {};
        private function _FormatMacro(macro:String, parts:Array, value:*, vehCD:Number, options:IVOMacrosOptions):String
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
                return prepareValue(NaN, name, norm, def, vehCD);

            var res:String = value;
            if (type == "function")
            {
                if (options == null)
                    return "{{" + macro + "}}";
                value = value(options);
                if (value == null)
                    return prepareValue(NaN, name, norm, def, vehCD);
                type = typeof value;
                if (type == "number" && isNaN(value))
                    return prepareValue(NaN, name, norm, def, vehCD);
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
                    return prepareValue(NaN, name, norm, def, vehCD);
            }

            if (rep != null)
                return rep;

            if (norm != null)
                res = prepareValue(value, name, norm, def, vehCD);

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
        private function prepareValue(value:*, name:String, norm:String, def:String, vehCD:Number):String
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
                    var key:String = name + "," + norm + "," + value + "," + vehCD;
                    res = _prepare_value_cache[key];
                    if (res)
                        return res;
                    if (isNaN(value))
                    {
                        var vdata:VOVehicleData = VehicleInfo.get(vehCD);
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
                case "xtdb":
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
                    if (res == null)
                        res = def;
                    break;
                case "py":
                    res = Xfw.cmd(XvmCommandsInternal.PYTHON_MACRO, norm);
                    isStaticMacro = res[1];
                    res = res[0];
                    if (res == null)
                        res = def;
                    break;
            }

            return res;
        }

        private function _GlobalNumber(value:*, defaultValue:Number, options:IVOMacrosOptions):Number
        {
            if (value == null)
                return defaultValue;
            if (!isNaN(value))
                return value;
            //Logger.addObject(value + " => " + _Format(null, value, new MacrosOptions()));
            var res:Number = Number(_Format(null, value, options || new VOMacrosOptions()));
            if (isFinite(res))
                return res;
            return defaultValue;
        }

        private function _GlobalBoolean(value:*, defaultValue:Boolean, options:IVOMacrosOptions):Boolean
        {
            if (value == null)
                return defaultValue;
            if (typeof value == "boolean")
                return value;
            //Logger.addObject(value + " => " + _Format(null, value, new MacrosOptions()));
            var res:String = String(_Format(null, value, options || new VOMacrosOptions())).toLowerCase();
            if (res == 'true')
                return true;
            if (res == 'false')
                return false;
            return defaultValue;
        }

        private function _GlobalString(value:*, defaultValue:String, options:IVOMacrosOptions):String
        {
            if (value == null)
                return defaultValue;
            //Logger.addObject(value + " => " + _Format(null, value, new MacrosOptions()));
            var res:String = _Format(null, String(value), options || new VOMacrosOptions());
            return res != null ? res : defaultValue;
        }

        /**
         * Is macros value cached
         * @param pname player name without extra tags (clan, region, etc)
         * @param format string template
         * @param options data for dynamic values
         * @return true if macros value is cached else false
         */
        private function _IsCached(pname:String, format:*):Boolean
        {
            if (format === undefined || XfwUtils.isPrimitiveTypeAndNotString(format))
                return true;

            format = String(format);
            if (format == "" || format.indexOf("{{") == -1)
                return true;

            if (pname != null && pname != "")
            {
                var player_cache:Object = m_macros_cache[pname];
                if (player_cache == null)
                    return false;
                return player_cache[format] !== undefined;
            }
            else
            {
                return m_macros_cache_global[format] !== undefined;
            }
        }

        // Macros registration

        private function _RegisterXvmServicesMacrosData():void
        {
            // {{xvm-stat}}
            m_globals["xvm-stat"] = Config.networkServicesSettings.statBattle == true ? 'stat' : null;
            // {{r_size}}
            m_globals["r_size"] = _getRatingDefaultValue().length;
        }

        private function _RegisterGlobalMacrosData():void
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

            // {{cellsize}}
            m_globals["cellsize"] = Math.round(Xfw.cmd(XvmCommandsInternal.GET_MAP_SIZE) / 10);

            var vdata:VOVehicleData = VehicleInfo.get(Xfw.cmd(XvmCommandsInternal.GET_MY_VEHCD));

            // {{my-veh-id}}
            m_globals["my-veh-id"] = vdata.vehCD;
            // {{my-vehicle}} - Chaffee
            m_globals["my-vehicle"] = vdata.localizedName;
            // {{my-vehiclename}} - usa-M24_Chaffee
            m_globals["my-vehiclename"] = VehicleInfo.getVIconName(vdata.key);
            // {{my-vehicle-short}} - Chaff
            m_globals["my-vehicle-short"] = vdata.shortName || vdata.localizedName;
            // {{my-vtype-key}} - MT
            m_globals["my-vtype-key"] = vdata.vtype;
            // {{my-vtype}}
            m_globals["my-vtype"] = VehicleInfo.getVTypeText(vdata.vtype);
            // {{my-vtype-l}} - Medium Tank
            m_globals["my-vtype-l"] = Locale.get(vdata.vtype);
            // {{c:my-vtype}}
            m_globals["c:my-vtype"] = MacrosUtils.getVTypeColorValue(vdata.vehCD);
            // {{my-battletier-min}}
            m_globals["my-battletier-min"] = vdata.tierLo;
            // {{my-battletier-max}}
            m_globals["my-battletier-max"] = vdata.tierHi;
            // {{my-nation}}
            m_globals["my-nation"] = vdata.nation;
            // {{my-level}}
            m_globals["my-level"] = vdata.level;
            // {{my-rlevel}}
            m_globals["my-rlevel"] = Defines.ROMAN_LEVEL[vdata.level - 1];
        }

        /**
         * Register minimal macros values for player
         * @param playerId player id
         * @param playerFullName full player name with extra tags (clan, region, etc)
         * @param vehCD vehicle compactDescr
         * @param isPlayerTeam is player team
         */
        private function _RegisterMinimalMacrosData(accountDBID:Number, playerFullName:String, vehCD:Number, isPlayerTeam:Boolean):void
        {
            if (playerFullName == null || playerFullName == "")
                throw new Error("empty name");

            var pname:String = WGUtils.GetPlayerName(playerFullName);

            if (!m_dict.hasOwnProperty(pname))
                m_dict[pname] = new Object();

            var pdata:Object = m_dict[pname];
            if (pdata.hasOwnProperty("name"))
                return; // already registered

            m_playerId_to_pname[accountDBID] = pname;

            var name:String = getCustomPlayerName(pname, accountDBID);
            var clanIdx:int = name.indexOf("[");
            if (clanIdx > 0)
            {
                playerFullName = name;
                name = StringUtils.trim(name.slice(0, clanIdx));
            }
            var clanWithoutBrackets:String = WGUtils.GetClanNameWithoutBrackets(playerFullName);
            var clanWithBrackets:String = WGUtils.GetClanNameWithBrackets(playerFullName);

            // {{nick}}
            pdata["nick"] = name + (clanWithBrackets || "");
            // {{name}}
            pdata["name"] = name;
            // {{clan}}
            pdata["clan"] = clanWithBrackets;
            // {{clannb}}
            pdata["clannb"] = clanWithoutBrackets;
            // {{ally}}
            pdata["ally"] = isPlayerTeam ? 'ally' : null;

            // Next macro unique for vehicle
            var vdata:VOVehicleData = VehicleInfo.get(vehCD);
            if (!m_globals["maxhp"] || m_globals["maxhp"] < vdata.hpTop)
                m_globals["maxhp"] = vdata.hpTop;
            // {{veh-id}}
            pdata["veh-id"] = vehCD;
            // {{vehicle}} - Chaffee
            pdata["vehicle"] = vdata.localizedName;
            // {{vehiclename}} - usa-M24_Chaffee
            pdata["vehiclename"] = VehicleInfo.getVIconName(vdata.key);
            // {{vehicle-short}} - Chaff
            pdata["vehicle-short"] = vdata.shortName || vdata.localizedName;
            // {{vtype-key}} - MT
            pdata["vtype-key"] = vdata.vtype;
            // {{vtype}}
            pdata["vtype"] = VehicleInfo.getVTypeText(vdata.vtype);
            // {{vtype-l}} - Medium Tank
            pdata["vtype-l"] = Locale.get(vdata.vtype);
            // {{c:vtype}}
            pdata["c:vtype"] = MacrosUtils.getVClassColorValue(vdata);
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
            // {{hp-max}}
            pdata["hp-max"] = vdata.hpTop;

            // Dynamic macros

            // {{ready}}
            pdata["ready"] = function(o:IVOMacrosOptions):String { return o.isReady ? 'ready' : null; }
            // {{alive}}
            pdata["alive"] = function(o:IVOMacrosOptions):String { return o.isAlive ? 'alive' : null; }
            // {{selected}}
            pdata["selected"] = function(o:IVOMacrosOptions):String { return o.isSelected ? 'sel' : null; }
            // {{player}}
            pdata["player"] = function(o:IVOMacrosOptions):String { return o.isCurrentPlayer ? 'pl' : null; }
            // {{tk}}
            pdata["tk"] = function(o:IVOMacrosOptions):String { return o.isTeamKiller ? 'tk' : null; }
            // {{squad}}
            pdata["squad"] = function(o:IVOMacrosOptions):String { return o.isSquadPersonal ? 'sq' : null; }
            // {{squad-num}}
            pdata["squad-num"] = function(o:IVOMacrosOptions):Number { return o.squadIndex <= 0 ? NaN : o.squadIndex; }
            // {{position}}
            pdata["position"] = function(o:IVOMacrosOptions):Number { return o.position <= 0 ? NaN : o.position; }
        }

        /**
         * Register stat macros values
         * @param pname player name without extra tags (clan, region, etc)
         */
        private function _RegisterStatisticsMacros(pname:String, stat:StatData):void
        {
            if (stat == null)
                return;

            var pdata:Object = m_dict[pname];

            // Register contacts data
            delete m_macros_cache[pname];
            delete pdata["name"];
            m_contacts[String(stat._id)] = stat.xvm_contact_data;
            RegisterMinimalMacrosData(stat._id, stat.name + (stat.clan == null || stat.clan == "" ? "" : "[" + stat.clan + "]"), stat.v.id, stat.team == XfwConst.TEAM_ALLY);

            if (Config.networkServicesSettings.servicesActive != true)
                return;

            // {{xvm-user}}
            pdata["xvm-user"] = Utils.getXvmUserText(stat.status);
            // {{flag}}
            pdata["flag"] = stat.flag;
            // {{clanrank}}
            pdata["clanrank"] = isNaN(stat.rank) ? null : stat.rank == 0 ? "persist" : String(stat.rank);
            // {{topclan}}
            pdata["topclan"] = Utils.getTopClanText(stat.rank);
            // {{region}}
            pdata["region"] = Config.config.region;
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
            pdata["r"] = _getRating(pdata, "", "", null);
            // {{xr}}
            pdata["xr"] = _getRating(pdata, "", "", "xvm");

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
            // {{xtdb}}
            pdata["xtdb"] = isNaN(stat.v.xtdb) || stat.v.xtdb <= 0 ? null : stat.v.xtdb == 100 ? "XX" : (stat.v.xtdb < 10 ? "0" : "") + stat.v.xtdb;
            // {{tdv}}
            pdata["tdv"] = stat.v.dv;
            // {{tfb}}
            pdata["tfb"] = stat.v.fb;
            // {{tsb}}
            pdata["tsb"] = stat.v.sb;

            // Dynamic colors
            // {{c:xte}}
            pdata["c:xte"] = isNaN(stat.v.xte) || stat.v.xte <= 0 ? null : MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.v.xte, "#");
            // {{c:xeff}}
            pdata["c:xeff"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xeff, "#");
            // {{c:xwn6}}
            pdata["c:xwn6"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn6, "#");
            // {{c:xwn8}}
            pdata["c:xwn8"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn8, "#");
            // {{c:xwn}}
            pdata["c:xwn"] = pdata["c:xwn8"]
            // {{c:xwgr}}
            pdata["c:xwgr"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwgr, "#");
            // {{c:eff}}
            pdata["c:eff"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, stat.e, "#");
            // {{c:wn6}}
            pdata["c:wn6"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WN6, stat.wn6, "#");
            // {{c:wn8}}
            pdata["c:wn8"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, stat.wn8, "#");
            // {{c:wn}}
            pdata["c:wn"] = pdata["c:wn8"];
            // {{c:wgr}}
            pdata["c:wgr"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WGR, stat.wgr, "#");
            // {{c:r}}
            pdata["c:r"] = _getRating(pdata, "c:", "", null);
            // {{c:xr}}
            pdata["c:xr"] = _getRating(pdata, "c:", "", "xvm");

            // {{c:winrate}}
            pdata["c:winrate"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.winrate, "#");
            // {{c:rating}} (obsolete)
            pdata["c:rating"] = pdata["c:winrate"]
            // {{c:kb}}
            pdata["c:kb"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_KB, stat.b / 1000.0, "#");
            // {{c:avglvl}}
            pdata["c:avglvl"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_AVGLVL, stat.lvl, "#");
            // {{c:t-winrate}}
            pdata["c:t-winrate"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.v.winrate, "#");
            // {{c:t-rating}} (obsolete)
            pdata["c:t-rating"] = pdata["c:t-winrate"];
            // {{c:t-battles}}
            pdata["c:t-battles"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, stat.v.b, "#");
            // {{c:tdb}}
            pdata["c:tdb"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, stat.v.db, "#");
            // {{c:xtdb}}
            pdata["c:xtdb"] = isNaN(stat.v.xtdb) || stat.v.xtdb <= 0 ? null : MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.v.xtdb, "#");
            // {{c:tdv}}
            pdata["c:tdv"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, stat.v.dv, "#");
            // {{c:tfb}}
            pdata["c:tfb"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, stat.v.fb, "#");
            // {{c:tsb}}
            pdata["c:tsb"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, stat.v.sb, "#");

            // Alpha
            // {{a:xte}}
            pdata["a:xte"] = isNaN(stat.v.xte) || stat.v.xte <= 0 ? NaN : MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.v.xte);
            // {{a:xeff}}
            pdata["a:xeff"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xeff);
            // {{a:xwn6}}
            pdata["a:xwn6"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn6);
            // {{a:xwn8}}
            pdata["a:xwn8"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn8);
            // {{a:xwn}}
            pdata["a:xwn"] = pdata["a:xwn8"];
            // {{a:xwgr}}
            pdata["a:xwgr"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwgr);
            // {{a:eff}}
            pdata["a:eff"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_EFF, stat.e);
            // {{a:wn6}}
            pdata["a:wn6"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN6, stat.wn6);
            // {{a:wn8}}
            pdata["a:wn8"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN8, stat.wn8);
            // {{a:wn}}
            pdata["a:wn"] = pdata["a:wn8"];
            // {{a:wgr}}
            pdata["a:wgr"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WGR, stat.wgr);
            // {{a:r}}
            pdata["a:r"] = _getRating(pdata, "a:", "", null);
            // {{a:xr}}
            pdata["a:xr"] = _getRating(pdata, "a:", "", "xvm");

            // {{a:winrate}}
            pdata["a:winrate"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WINRATE, stat.winrate);
            // {{a:rating}} (obsolete)
            pdata["a:rating"] = pdata["a:winrate"];
            // {{a:kb}}
            pdata["a:kb"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_KB, stat.b / 1000);
            // {{a:avglvl}}
            pdata["a:avglvl"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_AVGLVL, stat.lvl);
            // {{a:t-winrate}}
            pdata["a:t-winrate"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WINRATE, stat.v.winrate);
            // {{a:t-rating}} (obsolete)
            pdata["a:t-rating"] = pdata["a:t-winrate"];
            // {{a:t-battles}}
            pdata["a:t-battles"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TBATTLES, stat.v.b);
            // {{a:tdb}}
            pdata["a:tdb"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TDB, stat.v.db);
            // {{a:xtdb}}
            pdata["a:xtdb"] = isNaN(stat.v.xtdb) || stat.v.xtdb <= 0 ? NaN : MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.v.xtdb);
            // {{a:tdv}}
            pdata["a:tdv"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TDV, stat.v.dv);
            // {{a:tfb}}
            pdata["a:tfb"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TFB, stat.v.fb);
            // {{a:tsb}}
            pdata["a:tsb"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TSB, stat.v.sb);
        }

        /**
         * Change nicks for XVM developers.
         * @param pname player name
         * @return personal name
         */
        private function getCustomPlayerName(pname:String, uid:Number):String
        {
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
                    if (pname == "seriych")
                        return "Всем Счастья :)";
                    if (pname == "XIebniDizele4ky" || pname == "Xlebni_Dizele4ky" || pname == "XlebniDizeIe4ku" || pname == "XlebniDize1e4ku" || pname == "XlebniDizele4ku_2013")
                        return "Alex Artobanana";
                    break;

                case "CT":
                    if (pname == "www_modxvm_com_RU")
                        return "www.modxvm.com";
                    if (pname == "M_r_A_RU" || pname == "M_r_A_EU")
                        return "Fluttershy is best pony!";
                    if (pname == "sirmax2_RU" || pname == "sirmax2_EU" || pname == "sirmax_NA" || pname == "0x01_RU" || pname == "0x01_EU")
                        return "«sir Max» (XVM)";
                    if (pname == "seriych_RU")
                        return "Be Happy :)";
                    break;

                case "EU":
                    if (pname == "M_r_A")
                        return "Fluttershy is best pony!";
                    if (pname == "sirmax2" || pname == "0x01" || pname == "_SirMax_")
                        return "«sir Max» (XVM)";
                    if (pname == "seriych")
                        return "Be Happy :)";
                    break;

                case "US":
                    if (pname == "sirmax" || pname == "0x01" || pname == "_SirMax_")
                        return "«sir Max» (XVM)";
                    break;

                case "ST":
                    if (pname == "xvm_1")
                        return "«xvm»";
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
        private static function _getRating(pdata:Object, prefix:String, suffix:String, scale:String):*
        {
            var name:String = _getRatingName(scale);
            var value:* = pdata[prefix + RATING_MATRIX[name].name + suffix];
            if (prefix != "" || value == null)
                return value;
            value = StringUtils.leftPad(String(value), _getRatingDefaultValue(scale).length, " ");
            return value;
        }

        /**
         * Returns default value for rating according settings in the personal cabinet
         */
        private static function _getRatingDefaultValue(scale:String = null):String
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
