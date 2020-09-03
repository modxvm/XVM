/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.battle.vo.*;
    import com.xvm.types.stat.*;
    import com.xvm.vo.*;

    public class Macros
    {
        // PUBLIC STATIC

        /**
         * Format any type value with macros substitutions, in the player context
         *   {{name[:norm][%[flag][width][.prec]type][~suf][(=|!=|<|<=|>|>=)match][?rep][|def]}}
         * @param format template
         * @param options macros options data
         * @return Formatted string
         */
        public static function Format(format:*, options:IVOMacrosOptions):*
        {
            //Xvm.swfProfilerBegin("Macros.Format");
            //try
            //{
            return instance._Format(format, options, new MacrosResult());
            //}
            //finally
            //{
            //    Xvm.swfProfilerEnd("Macros.Format");
            //}
        }

        /**
         * Format any type value with macros substitutions to string, in the player context
         * @param format template
         * @param options macros options data
         * @param defaultValue default value
         * @return Formatted string
         */
        public static function FormatString(format:*, options:IVOMacrosOptions, defaultValue:String = ""):String
        {
            //Xvm.swfProfilerBegin("Macros.FormatString");
            //try
            //{
            if (format == null)
                return defaultValue;
            var res:String = instance._Format(format, options, new MacrosResult());
            //Logger.addObject(format + " => " + res);
            return res != null ? res : defaultValue;
            //}
            //finally
            //{
            //    Xvm.swfProfilerEnd("Macros.FormatString");
            //}
            //return "";
        }

        /**
         * Format any type value with macros substitutions to string, out of the player context
         * @param format template
         * @param defaultValue default value
         * @return Formatted string
         */
        public static function FormatStringGlobal(format:*, defaultValue:String = ""):String
        {
            //Xvm.swfProfilerBegin("Macros.FormatStringGlobal");
            //try
            //{
            return FormatString(format, null, defaultValue);
            //}
            //finally
            //{
            //    Xvm.swfProfilerEnd("Macros.FormatStringGlobal");
            //}
            //return "";
        }

        /**
         * Format any type value value with macros substitutions to number, in the player context
         * @param format template
         * @param options macros options data
         * @param defaultValue default value
         * @param isColorValue color value expected
         * @return Formatted number value
         */
        public static function FormatNumber(format:*, options:IVOMacrosOptions, defaultValue:Number = NaN):Number
        {
            //Xvm.swfProfilerBegin("Macros.FormatNumber");
            //try
            //{
            if (format == null)
                return defaultValue;
            if (!isNaN(format))
                return format;
            var v:* = instance._Format(format, options, new MacrosResult());
            //Logger.add(format + " => " + v);
            if (v == null)
                return defaultValue;
            if (!isNaN(v))
                return v;
            if (v is String)
            {
                // fix XVM Scale value
                if (v == "XX")
                    return 100;
                // fix color value
                if (v.charAt(0) == "#")
                    v = "0x" + v.slice(1);
                if (!isNaN(v))
                    return v;
            }
            return defaultValue;
            //}
            //finally
            //{
            //    Xvm.swfProfilerEnd("Macros.FormatNumber");
            //}
            //return NaN;
        }

        /**
         * Format any type value value with macros substitutions to number, out of the player context
         * @param format template
         * @param options macros options data
         * @param defaultValue default value
         * @param isColorValue color value expected
         * @return Formatted number value
         */
        public static function FormatNumberGlobal(format:*, defaultValue:Number = NaN):Number
        {
            //Xvm.swfProfilerBegin("Macros.FormatNumberGlobal");
            //try
            //{
            return FormatNumber(format, null, defaultValue);
            //}
            //finally
            //{
            //    Xvm.swfProfilerEnd("Macros.FormatNumberGlobal");
            //}
            //return NaN;
        }

        /**
         * Format value with macros substitutions to boolean value in the player context
         * @param format template
         * @param options macros options data
         * @param defaultValue default value
         * @return Formatted boolean value
         */
        public static function FormatBoolean(format:*, options:IVOMacrosOptions, defaultValue:Boolean = false):Boolean
        {
            //Xvm.swfProfilerBegin("Macros.FormatBoolean");
            //try
            //{
            if (format == null)
                return defaultValue;
            if (typeof format == "boolean")
                return format;
            var v:* = instance._Format(format, options, new MacrosResult());
            if (v == null)
                return defaultValue;
            if (typeof v == "boolean")
                return v;
            if (v is String)
            {
                v = v.toLowerCase();
                if (v == 'true')
                    return true;
                if (v == 'false')
                    return false;
            }
            return defaultValue;
            //}
            //finally
            //{
            //    Xvm.swfProfilerEnd("Macros.FormatBoolean");
            //}
            //return false;
        }

        /**
         * Format value with macros substitutions to boolean value out of the player context
         * @param format template
         * @param defaultValue default value
         * @return Formatted boolean value
         */
        public static function FormatBooleanGlobal(format:*, defaultValue:Boolean = false):Boolean
        {
            //Xvm.swfProfilerBegin("Macros.FormatBooleanGlobal");
            //try
            //{
            return FormatBoolean(format, null, defaultValue);
            //}
            //finally
            //{
            //    Xvm.swfProfilerEnd("Macros.FormatBooleanGlobal");
            //}
            //return false;
        }

        /**
         * Is macros value cached
         * @param format template
         * @param options macros options data
         * @return true if macros value is cached else false
         */
        public static function IsCached(format:*, options:IVOMacrosOptions = null):Boolean
        {
            //Xvm.swfProfilerBegin("Macros.IsCached");
            //try
            //{
            return instance._IsCached(format, options);
            //}
            //finally
            //{
            //    Xvm.swfProfilerEnd("Macros.IsCached");
            //}
            //return false;
        }

        public static function get Globals():Object
        {
            return instance.m_globals;
        }

        public static function get Players():Object
        {
            return instance.m_players;
        }

        // common

        public static function clear():void
        {
            instance._clear();
        }

        public static function RegisterXvmServicesMacrosData():void
        {
            instance._RegisterXvmServicesMacrosData();
        }

        /**
         * Register stat macros values
         * @param pname player name without extra tags (clan, region, etc)
         */
        public static function RegisterStatisticsMacros(pname:String, stat:StatData):void
        {
            instance._RegisterStatisticsMacros(pname, stat);
        }

        // battle

        /**
         * Register macros values for player
         * @param vehicleID vehicle id
         * @param playerName player name without extra tags (clan, region, etc)
         * @param clanAbbrev clan abbreviation without brackets
         * @param isAlly is player team
         */
        public static function RegisterPlayerMacrosData(vehicleID:Number, accountDBID:Number, playerName:String, playerFakeName:String, clanAbbrev:String, isAlly:Boolean, rankBadgeId:String):void
        {
            instance._RegisterPlayerMacrosData(vehicleID, accountDBID, playerName, playerFakeName, clanAbbrev, isAlly, rankBadgeId);
        }

        /**
         * Register macros values for vehicle
         * @param vehicleID vehicle id
         * @param vehCD vehicle compactDescr
         */
        public static function RegisterVehicleMacrosData(playerName:String, playerFakeName:String, vehCD:Number):void
        {
            instance._RegisterVehicleMacrosData(playerName, playerFakeName, vehCD);
        }

        // INSTANCE

        private static var _instance:Macros = null;

        public static function get instance():Macros
        {
            if (!_instance)
            {
                _instance = new Macros();
            }
            return _instance;
        }

        // PRIVATE

        private const PART_NAME:int     = 0;
        private const PART_NORM:int     = 1;
        private const PART_FMT:int      = 2;
        private const PART_SUF:int      = 3;
        private const PART_MATCH_OP:int = 4;
        private const PART_MATCH:int    = 5;
        private const PART_REP:int      = 6;
        private const PART_DEF:int      = 7;

        private const CACHE_MASK_ALIVE:int =        1 << 0;
        private const CACHE_MASK_READY:int =        1 << 1;
        private const CACHE_MASK_SELECTED:int =     1 << 2;
        private const CACHE_MASK_PLAYER:int =       1 << 3;
        private const CACHE_MASK_TEAMKILLER:int =   1 << 4;
        private const CACHE_MASK_SQUAD:int =        1 << 5;
        private const CACHE_MASK_PERSONAL_SQ:int =  1 << 6;
        private const CACHE_MASK_POSITION:int =     1 << 7;
        private const CACHE_MASK_MARKSONGUN:int =   1 << 8;
        private const CACHE_MASK_X_ENABLED:int =    1 << 9;
        private const CACHE_MASK_X_SPOTTED:int =    1 << 10;
        private const CACHE_MASK_X_FIRE:int =       1 << 11;
        private const CACHE_MASK_X_OVERTURNED:int = 1 << 12;
        private const CACHE_MASK_X_DROWNING:int =   1 << 13;
        private const CACHE_MASK_IS_FRIEND:int =    1 << 14;
        private const CACHE_MASK_IS_IGNORED:int =   1 << 15;
        private const CACHE_MASK_IS_MUTED:int =     1 << 16;
        private const CACHE_MASK_IS_CHATBAN:int =   1 << 17;

        // special case for dynamic macros converted to static
        private const HYBRID_MACROS:Vector.<String> = new <String>[
            "alive", "ready", "selected", "player", "tk", "squad", "squad-num", "position", "marksOnGun",
            "x-enabled", "x-sense-on", "x-spotted", "x-fire", "x-overturned", "x-drowning", "name", "nick",
            "clan", "clannb", "anonym",
            // vehicle macros (can be changed during the battle in some game modes)
            "veh-id", "vehicle", "vehiclename", "vehicle-short", "vtype-key", "vtype", "vtype-l", "c:vtype",
            "battletier-min", "battletier-max", "nation", "level", "rlevel", "premium", "special",
            // global macros
            "sys-color-key", "c:system", "my-alive"
            ];

        private const STAT_MACROS:Vector.<String> = new <String>[
            "xvm-user", "flag", "clanrank", "topclan", "region", "comment", "bp-stage", "avglvl", "xte", "xeff",
            "xwtr", "xwn8", "xwgr", "eff", "wtr", "wn8", "wgr", "r", "xr", "xwr", "winrate", "rating", "battles",
            "wins", "kb", "t-winrate", "t-rating", "t-battles", "t-wins", "t-kb", "t-hb", "tdb", "xtdb", "tdv",
            "vwtr", "xvwtr", "c:xvwtr", "a:xvwtr",
            "tfb", "tsb", "c:xte", "c:xeff", "c:xwtr", "c:xwn8", "c:xwgr", "c:eff", "c:wtr", "c:wn8",
            "c:wgr", "c:r", "c:xr", "c:xwr", "c:winrate", "c:rating", "c:kb", "c:avglvl", "c:t-winrate",
            "c:t-rating", "c:t-battles", "c:tdb", "c:xtdb", "c:tdv", "c:tfb", "c:tsb", "a:xte", "a:xeff",
            "a:xwtr", "a:xwn8", "a:xwgr", "a:eff", "a:wtr", "a:wn8", "a:wgr", "a:r", "a:xr", "a:xwr",
            "a:winrate", "a:rating", "a:kb", "a:avglvl", "a:t-winrate", "a:t-rating", "a:t-battles", "a:tdb",
            "a:xtdb", "a:tdv", "a:tfb", "a:tsb"];

        private var m_globals:Object;
        private var m_players:Object; // { PLAYERNAME1: { macro1: func || value, macro2:... }, PLAYERNAME2: {...} }
        private var m_macros_cache_globals:Object;
        private var m_macros_cache_players:Object;
        private var m_macros_cache_players_hybrid:Object;
        private var m_macro_parts_cache:Object;
        private var m_format_macro_fmt_suf_cache:Object;
        private var m_prepare_value_cache:Object;

        // .ctor() should be private
        function Macros()
        {
            super();
            _clear();
        }

        private const nullFunc:Function = function():* { return null; }

        private function _clear():void
        {
            m_globals = { };
            m_players = { };
            m_macros_cache_globals = { };
            m_macros_cache_players = { };
            m_macros_cache_players_hybrid = { };
            m_macro_parts_cache = { };
            m_format_macro_fmt_suf_cache = { };
            m_prepare_value_cache = { };
            for each (var macros:String in STAT_MACROS)
            {
                m_globals[macros] = nullFunc;
            }
        }

        private function _getPlayerCache(options:IVOMacrosOptions):Object
        {
            var idx:int = 0;
            if (options.isAlive)
                idx |= CACHE_MASK_ALIVE;
            if (options.isReady)
                idx |= CACHE_MASK_READY;
            if (options.isSelected)
                idx |= CACHE_MASK_SELECTED;
            if (options.isCurrentPlayer)
                idx |= CACHE_MASK_PLAYER;
            if (options.isTeamKiller)
                idx |= CACHE_MASK_TEAMKILLER;
            if (options.squadIndex)
                idx |= CACHE_MASK_SQUAD;
            if (options.isSquadPersonal)
                idx |= CACHE_MASK_PERSONAL_SQ;
            if (isNaN(options.position))
                idx |= CACHE_MASK_POSITION;
            if (isNaN(options.marksOnGun))
                idx |= CACHE_MASK_MARKSONGUN;
            if (options.isFriend)
                idx |= CACHE_MASK_IS_FRIEND;
            if (options.isIgnored)
                idx |= CACHE_MASK_IS_IGNORED;
            if (options.isMuted)
                idx |= CACHE_MASK_IS_MUTED;
            if (options.isChatBan)
                idx |= CACHE_MASK_IS_CHATBAN;
            var ps:VOPlayerState = options as VOPlayerState;
            if (ps != null)
            {
                if (ps.xmqpData.x_enabled)
                    idx |= CACHE_MASK_X_ENABLED;
                if (ps.xmqpData.x_spotted)
                    idx |= CACHE_MASK_X_SPOTTED;
                if (ps.xmqpData.x_fire)
                    idx |= CACHE_MASK_X_FIRE;
                if (ps.xmqpData.x_overturned)
                    idx |= CACHE_MASK_X_OVERTURNED;
                if (ps.xmqpData.x_drowning)
                    idx |= CACHE_MASK_X_DROWNING;
            }

            var player_cache_array:Array = m_macros_cache_players[options.playerFakeName];
            if (player_cache_array == null)
            {
                m_macros_cache_players[options.playerFakeName] = [ ]; // Sparse array
                player_cache_array = m_macros_cache_players[options.playerFakeName];
            }
            var player_cache:Object = player_cache_array[idx];
            if (player_cache == null)
            {
                player_cache_array[idx] = { };
                player_cache = player_cache_array[idx];
            }
            return player_cache;
        }

        private function _Format(format:*, options:IVOMacrosOptions, __out:MacrosResult):*
        {
            //Logger.add("format:" + format + " player:" + (options ? options.playerName : null));

            if (format === undefined || XfwUtils.isPrimitiveTypeAndNotString(format) || !isNaN(format))
                return format;

            var format_str:String = String(format);
            if (!format_str)
                return "";

            var playerFakeName:String = options ? options.playerFakeName : null;

            // Check cached value
            var player_cache:Object;
            var cached_value:*;
            if (playerFakeName)
            {
                player_cache = _getPlayerCache(options);
                cached_value = player_cache[format_str];
            }
            else
            {
                cached_value = m_macros_cache_globals[format_str];
            }
            if (cached_value !== undefined)
            {
                return cached_value;
            }

            // Split tags
            var parts:Vector.<String> = Vector.<String>(format_str.split("{{"));
            var len:int = parts.length;
            var res:String = parts[0];
            if (len > 1)
            {
                for (var i:int = 1; i < len; ++i)
                {
                    var part:String = parts[i];
                    var idx:int = part.indexOf("}}");
                    if (idx == -1)
                    {
                        res += "{{" + part;
                    }
                    else
                    {
                        var _FormatPart_out:MacrosResult = new MacrosResult();
                        res += _FormatPart(part.slice(0, idx), options, _FormatPart_out) + part.slice(idx + 2);
                        __out.isStaticMacro &&= _FormatPart_out.isStaticMacro;
                        __out.isHybridMacro ||= _FormatPart_out.isHybridMacro;
                    }
                }
                if (res != format_str)
                {
                    var iMacroPos:int = res.indexOf("{{");
                    if (iMacroPos >= 0)
                    {
                        if (res.indexOf("}}", iMacroPos) >= 0)
                        {
                            var _Format_out:MacrosResult = new MacrosResult();
                            res = _Format(res, options, _Format_out);
                            __out.isStaticMacro &&= _Format_out.isStaticMacro;
                            __out.isHybridMacro ||= _Format_out.isHybridMacro;
                        }
                    }
                }
            }

            res = Utils.fixImgTag(res);

            if (__out.isStaticMacro)
            {
                if (playerFakeName)
                {
                    player_cache[format_str] = res;
                    if (__out.isHybridMacro)
                    {
                        var hybrid_cache:Object = m_macros_cache_players_hybrid[options.playerFakeName];
                        if (hybrid_cache == null)
                        {
                            m_macros_cache_players_hybrid[options.playerFakeName] = { };
                            hybrid_cache = m_macros_cache_players_hybrid[options.playerFakeName];
                        }
                        hybrid_cache[format_str] = 1;
                    }
                }
                else
                {
                    m_macros_cache_globals[format_str] = res;
                }
            }

            return res;
        }

        private function _FormatPart(macro:String, options:IVOMacrosOptions, __out:MacrosResult):String
        {
            // Process tag
            var playerFakeName:String = options ? options.playerFakeName : null;
            var pdata:* = playerFakeName ? m_players[playerFakeName] || m_globals : m_globals;
            if (pdata == null)
                return "";

            var parts:Vector.<String> = _GetMacroParts(macro, pdata);

            var macroName:String = parts[PART_NAME];

            var value:*;

            var colonPos:int = macroName.indexOf(":");
            var macroNameColon:String = (colonPos > 0) ? macroName.slice(0, colonPos) : null;
            if (colonPos > 0 && macroNameColon != "c" && macroNameColon != "a")
            {
                if (options == null)
                {
                    options = new VOMacrosOptions();
                }
                options.setSubname(macroName.slice(colonPos + 1));
                macroName = macroNameColon;
            }
            else
            {
                var dotPos:int = macroName.indexOf(".");
                if (dotPos == 0)
                {
                    try
                    {
                        value = _SubstituteConfigPart(macroName.slice(1));
                    }
                    catch (ex:Error)
                    {
                        Logger.add("[SubstituteConfigPart] ERROR: " + ex.message + "\nmacro: " + macroName);
                        throw ex;
                    }
                }
                else
                {
                    if (dotPos > 0)
                    {
                        if (options == null)
                        {
                            options = new VOMacrosOptions();
                        }
                        options.setSubname(macroName.slice(dotPos + 1));
                        macroName = macroName.slice(0, dotPos);
                    }
                    value = pdata[macroName];
                    if (value === undefined)
                    {
                        value = m_globals[macroName];
                    }
                }
            }

            //Logger.add("macro:" + macro + " | macroname:" + macroName + " | norm:" + parts[PART_NORM] + " | def:" + parts[PART_DEF] + " | value:" + value);

            if (value === undefined)
            {
                //process l10n macro
                if (macroName == "l10n")
                {
                    //Logger.add(macroName + " : " + options.getSubname() + " => " + (Locale.get(options.getSubname()) || ""));
                    return Locale.get(options.getSubname()) || "";
                }
                // process py macro
                else if (macroName == "py")
                {
                    //Logger.add(parts + " | " + options.getSubname());
                    var py_result:Array = Xfw.cmd(XvmCommandsInternal.PYTHON_MACRO, options.getSubname());
                    if (py_result)
                    {
                        if (py_result.length == 2)
                        {
                            if (!py_result[1])
                            {
                                __out.isStaticMacro = false;
                            }
                            value = py_result[0];
                        }
                    }
                }
                else
                {
                    __out.isStaticMacro = false;
                    value = macroName;
                }
            }

            var vehCD:Number = pdata["veh-id"];

            if (value == null)
            {
                //Logger.add(macroName + " " + parts[PART_NORM] + " " + parts[PART_DEF] + "  " + format);
                return prepareValue(NaN, macroName, parts[PART_NORM], parts[PART_DEF], vehCD);
            }

            // is hybrid or dynamic macro
            if (HYBRID_MACROS.indexOf(macroName) >= 0)
            {
                __out.isHybridMacro = true;
            }
            else
            {
                if (value is Function)
                {
                    __out.isStaticMacro = false;
                }
            }

            return _FormatMacro(parts, value, vehCD, options);
        }

        private function _GetMacroParts(macro:String, pdata:Object):Vector.<String>
        {
            var parts:Vector.<String> = m_macro_parts_cache[macro];
            if (parts)
            {
                return parts;
            }

            //Logger.add("_GetMacroParts: " + macro);
            //Logger.addObject(pdata);

            parts = new Vector.<String>(8, true);

            // split parts: name[:norm][%[flag][width][.prec]type][~suf][(=|!=|<|<=|>|>=)match][?rep][|def]
            var macroArr:Vector.<String> = Vector.<String>(macro.split(""));
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
                        if (section < 1)
                        {
                            switch (part)
                            {
                                case "c":
                                case "a":
                                    break;

                                case "l10n":
                                    parts[PART_NAME] = macro;
                                    m_macro_parts_cache[macro] = parts;
                                    return parts;

                                case "py":
                                    var matches:Array = /py(:[\w\.\s]+(\(.*\))?)/.exec(macro);
                                    ch = matches[1];
                                    i = ch.length + 1;
                                    //Logger.add(macro + " => " + part + ch);
                                    break;

                                default:
                                    nextSection = 1;
                                    break;
                            }
                        }
                        break;
                    case "%":
                        if (section < 2)
                        {
                            nextSection = 2;
                        }
                        break;
                    case "~":
                        if (section < 3)
                        {
                            nextSection = 3;
                        }
                        break;
                    case "!":
                    case "=":
                    case ">":
                    case "<":
                        if (section < 4)
                        {
                            if (i < len - 1)
                            {
                                if (macroArr[i + 1] == "=")
                                {
                                    ++i;
                                    ch += macroArr[i];
                                }
                            }
                            parts[PART_MATCH_OP] = ch;
                            nextSection = 5;
                        }
                        break;
                    case "?":
                        if (section < 6)
                        {
                            nextSection = 6;
                        }
                        break;
                    case "|":
                        if (section < 7)
                        {
                            nextSection = 7;
                        }
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
            {
                parts[PART_DEF] = "";
            }

            if (parts[PART_NAME] == "r" && !parts[PART_DEF])
            {
                parts[PART_DEF] = _getRatingDefaultValue();
            }
            else if (parts[PART_NAME] == "xr" && !parts[PART_DEF])
            {
                parts[PART_DEF] = _getRatingDefaultValue("xvm");
            }

            //Logger.add("[AS3][MACROS][_GetMacroParts]: " + parts.join(", "));
            m_macro_parts_cache[macro] = parts;
            return parts;
        }

        private function _SubstituteConfigPart(path:String):String
        {
            var res:* = XfwUtils.getObjectValueByPath(Config.config, path);
            if (res == null)
            {
                return res;
            }
            if (typeof(res) == "object")
            {
                return JSONx.stringify(res, "", true);
            }
            return String(res);
        }

        private function _FormatMacro(parts:Vector.<String>, value:*, vehCD:Number, options:IVOMacrosOptions):String
        {
            var name:String = parts[PART_NAME];
            var norm:String = parts[PART_NORM];
            var def:String = parts[PART_DEF];

            // substitute
            //Logger.add("type:" + (typeof value) + " value:" + value + "name:" + name + " norm:" + norm + " def:" + def);

            if (typeof value == "number")
            {
                if (isNaN(value))
                {
                    return prepareValue(NaN, name, norm, def, vehCD);
                }
            }

            var res:String = value;
            if (value is Function)
            {
                value = value(options);
                if (value == null)
                {
                    return prepareValue(NaN, name, norm, def, vehCD);
                }
                if (typeof value == "number")
                {
                    if (isNaN(value))
                    {
                        return prepareValue(NaN, name, norm, def, vehCD);
                    }
                }
                res = value;
            }

            var match:String = parts[PART_MATCH];
            if (match != null)
            {
                var match_op:String = parts[PART_MATCH_OP];
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
                {
                    return prepareValue(NaN, name, norm, def, vehCD);
                }
            }

            var rep:String = parts[PART_REP];
            if (rep != null)
            {
                return rep;
            }

            if (norm != null)
            {
                res = prepareValue(value, name, norm, def, vehCD);
            }

            var fmt:String = parts[PART_FMT];
            var suf:String = parts[PART_SUF];
            if (fmt == null)
            {
                if (suf == null)
                {
                    return res;
                }
            }

            var fmt_suf_key:String = fmt + "," + suf + "," + res;
            var fmt_suf_res:String = m_format_macro_fmt_suf_cache[fmt_suf_key];
            if (fmt_suf_res)
            {
                return fmt_suf_res;
            }

            if (fmt != null)
            {
                res = Sprintf.format("%" + fmt, res);
                //Logger.add(value + "|" + res + "|");
            }

            if (suf != null)
            {
                if (value is String)
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
                                res = res.slice(0, res.length - suf.length) + suf;
                        }
                    }
                }
                else
                {
                    res += suf;
                }
            }

            //Logger.add(res);
            m_format_macro_fmt_suf_cache[fmt_suf_key] = res;
            return res;
        }

        private function prepareValue(value:*, name:String, norm:String, def:String, vehCD:Number):String
        {
            if (norm == null)
            {
                return def;
            }

            var res:String = def;
            switch (name)
            {
                case "hp":
                case "hp-max":
                    var key:String = name + "," + norm + "," + value + "," + vehCD;
                    res = m_prepare_value_cache[key];
                    if (res)
                    {
                        return res;
                    }
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
                    m_prepare_value_cache[key] = res;
                    //Logger.add(key + " => " + res);
                    break;
                case "hp-ratio":
                    if (isNaN(value))
                        value = 100;
                    res = Math.round(parseInt(norm) * value / 100).toString();
                    break;
                case "r":
                case "xr":
                case "xte":
                case "xwgr":
                case "xwtr":
                case "xwn8":
                case "xeff":
                case "xtdb":
                case "xvwtr":
                case "xwr":
                    if (name == "r")
                    {
                        if (Config.networkServicesSettings.scale != "xvm")
                        {
                            break;
                        }
                    }
                    if (value == 'XX')
                    {
                        value = 100;
                    }
                    else
                    {
                        value = parseInt(value);
                        if (isNaN(value))
                            value = 0;
                    }
                    res = Math.round(parseInt(norm) * value / 100).toString();
                    break;
            }

            return res;
        }

        private function _IsCached(format:*, options:IVOMacrosOptions):Boolean
        {
            if (format === undefined || XfwUtils.isPrimitiveTypeAndNotString(format) || !isNaN(format))
                return true;

            var format_str:String = String(format);
            if (!format_str)
                return true;

            var playerFakeName:String = options ? options.playerFakeName : null;

            // Check cached value
            if (playerFakeName)
            {
                var hybrid_cache:Object = m_macros_cache_players_hybrid[playerFakeName];
                if (hybrid_cache != null)
                {
                    if (format_str in hybrid_cache)
                    {
                        return false;
                    }
                }
                var player_cache:Object = _getPlayerCache(options);
                return (format_str in player_cache);
            }
            return (format_str in m_macros_cache_globals);
        }

        // Macros registration

        private function _RegisterXvmServicesMacrosData():void
        {
            // {{xvm-stat}}
            m_globals["xvm-stat"] = Config.networkServicesSettings.statBattle == true ? 'stat' : null;
            // {{r_size}}
            m_globals["r_size"] = _getRatingDefaultValue().length;
        }

        private function _RegisterPlayerMacrosData(vehicleID:Number, accountDBID:Number, playerName:String, playerFakeName:String, clanAbbrev:String, isAlly:Boolean, rankBadgeId:String):void
        {
            if (!playerFakeName)
                throw new Error("empty name");

            if (!(playerFakeName in m_players))
            {
                m_players[playerFakeName] = {};
            }

            // register player macros
            var pdata:Object = m_players[playerFakeName];

            //Logger.add("_RegisterPlayerMacrosData: " + playerName);

            // clear static cache
            m_macros_cache_players[playerFakeName] = null;

            var name:String = getCustomPlayerName(playerName, accountDBID);
            var clanWithoutBrackets:String = clanAbbrev;
            var clanWithBrackets:String = clanAbbrev ? ("[" + clanAbbrev + "]") : null;

            // {{nick}}
            pdata["nick"] = name + (clanWithBrackets || "");
            // {{name}}
            pdata["name"] = name;
            // {{clan}}
            pdata["clan"] = clanWithBrackets;
            // {{clannb}}
            pdata["clannb"] = clanWithoutBrackets;
            // {{ally}}
            pdata["ally"] = isAlly ? 'ally' : null;
            // {{clanicon}}
            pdata["clanicon"] = function():String
            {
                // TODO: make static macro
                return Xfw.cmd(XvmCommandsInternal.GET_CLAN_ICON, vehicleID);
            }
            // {{rankBadgeId}}
            pdata["rankBadgeId"] = rankBadgeId;
        }

        private function _RegisterVehicleMacrosData(playerName:String, playerFakeName:String, vehCD:Number):void
        {
            // register vehicle macros
            var pdata:Object = m_players[playerFakeName];
            if (!pdata)
                return;

            if (pdata["veh-id"] == vehCD)
                return;

            // clear static cache
            m_macros_cache_players[playerFakeName] = null;

            var vdata:VOVehicleData = VehicleInfo.get(vehCD);

            //Logger.debug("_RegisterVehicleMacrosData: " + playerName + " " + vdata.localizedName);

            if (vehCD != 0)
            {
                if (!m_globals["maxhp"] || m_globals["maxhp"] < vdata.hpTop)
                    m_globals["maxhp"] = vdata.hpTop;
            }

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
            // {{premium}}
            pdata["premium"] = vdata.premium ? "premium" : null;
            // {{special}}
            pdata["special"] = vdata.special ? "special" : null;
        }

        private function _RegisterStatisticsMacros(pname:String, stat:StatData):void
        {
            if (stat == null)
                return;

            if (Config.networkServicesSettings.servicesActive != true)
                return;

            var pdata:Object = m_players[pname];
            if (!pdata)
            {
                RegisterPlayerMacrosData(stat.vehicleID, stat.player_id, pname, pname, stat.clan, stat.team == XfwConst.TEAM_ALLY, stat.badgeId);
                RegisterVehicleMacrosData(pname, pname, stat.v.id);
                pdata = m_players[pname];
            }

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
            // {{comment}}
            pdata["comment"] = stat.xvm_contact_data ? stat.xvm_contact_data.comment : null;
            if (stat.xvm_contact_data)
            {
                if (stat.xvm_contact_data.nick)
                {
                    // update static macros {{nick}} and {{name}}
                    pdata["nick"] = stat.xvm_contact_data.nick + (pdata["clan"] || "");
                    pdata["name"] = stat.xvm_contact_data.nick;
                    // clear static cache
                    m_macros_cache_players[pname] = null;
                }
            }
            // {{bp-stage}}
            pdata["bp-stage"] = stat.badgeStage;
            // {{avglvl}}
            pdata["avglvl"] = stat.avglvl;
            // {{xte}}
            pdata["xte"] = isNaN(stat.v.xte) || stat.v.xte <= 0 ? null : stat.v.xte == 100 ? "XX" : (stat.v.xte < 10 ? "0" : "") + stat.v.xte;
            // {{xeff}}
            pdata["xeff"] = isNaN(stat.xeff) ? null : stat.xeff == 100 ? "XX" : (stat.xeff < 10 ? "0" : "") + stat.xeff;
            // {{xwtr}}
            pdata["xwtr"] = isNaN(stat.xwtr) ? null : stat.xwtr == 100 ? "XX" : (stat.xwtr < 10 ? "0" : "") + stat.xwtr;
            // {{xwn8}}
            pdata["xwn8"] = isNaN(stat.xwn8) ? null : stat.xwn8 == 100 ? "XX" : (stat.xwn8 < 10 ? "0" : "") + stat.xwn8;
            // {{xwgr}}
            pdata["xwgr"] = isNaN(stat.xwgr) ? null : stat.xwgr == 100 ? "XX" : (stat.xwgr < 10 ? "0" : "") + stat.xwgr;
            // {{xwr}}
            pdata["xwr"] = isNaN(stat.xwr) ? null : stat.xwr == 100 ? "XX" : (stat.xwr < 10 ? "0" : "") + stat.xwr;
            // {{eff}}
            pdata["eff"] = isNaN(stat.eff) ? null : Math.round(stat.eff);
            // {{wtr}}
            pdata["wtr"] = isNaN(stat.wtr) ? null : Math.round(stat.wtr);
            // {{wn8}}
            pdata["wn8"] = isNaN(stat.wn8) ? null : Math.round(stat.wn8);
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
            pdata["battles"] = stat.battles;
            // {{wins}}
            pdata["wins"] = stat.wins;
            // {{kb}}
            pdata["kb"] = stat.battles / 1000;

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
            // {{vwtr}}
            pdata["vwtr"] = isNaN(stat.v.wtr) || stat.v.wtr <= 0 ? null : stat.v.wtr;
            // {{xvwtr}}
            pdata["xvwtr"] = isNaN(stat.v.xwtr) || stat.v.xwtr <= 0 ? null : stat.v.xwtr == 100 ? "XX" : (stat.v.xwtr < 10 ? "0" : "") + stat.v.xwtr;
            // {{tdv}}
            pdata["tdv"] = stat.v.dv;
            // {{tfb}}
            pdata["tfb"] = stat.v.fb;
            // {{tsb}}
            pdata["tsb"] = stat.v.sb;

            // Dynamic colors
            // {{c:xte}}
            pdata["c:xte"] = isNaN(stat.v.xte) || stat.v.xte <= 0 ? null : MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.v.xte, NaN, "#");
            // {{c:xeff}}
            pdata["c:xeff"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xeff, NaN, "#");
            // {{c:xwtr}}
            pdata["c:xwtr"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwtr, NaN, "#");
            // {{c:xwn8}}
            pdata["c:xwn8"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn8, NaN, "#");
            // {{c:xwgr}}
            pdata["c:xwgr"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwgr, NaN, "#");
            // {{c:xwr}}
            pdata["c:xwr"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwr, NaN, "#");
            // {{c:eff}}
            pdata["c:eff"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, stat.eff, stat.xeff, "#");
            // {{c:wtr}}
            pdata["c:wtr"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WTR, stat.wtr, stat.xwtr, "#");
            // {{c:wn8}}
            pdata["c:wn8"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, stat.wn8, stat.xwn8, "#");
            // {{c:wgr}}
            pdata["c:wgr"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WGR, stat.wgr, stat.xwgr, "#");
            // {{c:r}}
            pdata["c:r"] = _getRating(pdata, "c:", "", null);
            // {{c:xr}}
            pdata["c:xr"] = _getRating(pdata, "c:", "", "xvm");

            // {{c:winrate}}
            pdata["c:winrate"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.winrate, stat.xwr, "#");
            // {{c:rating}} (obsolete)
            pdata["c:rating"] = pdata["c:winrate"]
            // {{c:kb}}
            pdata["c:kb"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_KB, stat.battles / 1000.0, NaN, "#");
            // {{c:avglvl}}
            pdata["c:avglvl"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_AVGLVL, stat.avglvl, NaN, "#");
            // {{c:t-winrate}}
            pdata["c:t-winrate"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.v.winrate, NaN, "#");
            // {{c:t-rating}} (obsolete)
            pdata["c:t-rating"] = pdata["c:t-winrate"];
            // {{c:t-battles}}
            pdata["c:t-battles"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, stat.v.b, NaN, "#");
            // {{c:tdb}}
            pdata["c:tdb"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, stat.v.db, NaN, "#");
            // {{c:xtdb}}
            pdata["c:xtdb"] = isNaN(stat.v.xtdb) || stat.v.xtdb <= 0 ? null : MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.v.xtdb, NaN, "#");
            // {{c:xvwtr}}
            pdata["c:xvwtr"] = isNaN(stat.v.xwtr) || stat.v.xwtr <= 0 ? null : MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.v.xwtr, NaN, "#");
            // {{c:tdv}}
            pdata["c:tdv"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, stat.v.dv, NaN, "#");
            // {{c:tfb}}
            pdata["c:tfb"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, stat.v.fb, NaN, "#");
            // {{c:tsb}}
            pdata["c:tsb"] = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, stat.v.sb, NaN, "#");

            // Alpha
            // {{a:xte}}
            pdata["a:xte"] = isNaN(stat.v.xte) || stat.v.xte <= 0 ? NaN : MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.v.xte, NaN);
            // {{a:xeff}}
            pdata["a:xeff"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xeff, NaN);
            // {{a:xwtr}}
            pdata["a:xwtr"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwtr, NaN);
            // {{a:xwn8}}
            pdata["a:xwn8"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn8, NaN);
            // {{a:xwgr}}
            pdata["a:xwgr"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwgr, NaN);
            // {{a:xwr}}
            pdata["a:xwr"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwr, NaN);
            // {{a:eff}}
            pdata["a:eff"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_EFF, stat.eff, stat.xeff);
            // {{a:wtr}}
            pdata["a:wtr"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WTR, stat.wtr, stat.wtr);
            // {{a:wn8}}
            pdata["a:wn8"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN8, stat.wn8, stat.xwn8);
            // {{a:wgr}}
            pdata["a:wgr"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WGR, stat.wgr, stat.xwgr);
            // {{a:r}}
            pdata["a:r"] = _getRating(pdata, "a:", "", null);
            // {{a:xr}}
            pdata["a:xr"] = _getRating(pdata, "a:", "", "xvm");

            // {{a:winrate}}
            pdata["a:winrate"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WINRATE, stat.winrate, stat.xwr);
            // {{a:rating}} (obsolete)
            pdata["a:rating"] = pdata["a:winrate"];
            // {{a:kb}}
            pdata["a:kb"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_KB, stat.battles / 1000, NaN);
            // {{a:avglvl}}
            pdata["a:avglvl"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_AVGLVL, stat.avglvl, NaN);
            // {{a:t-winrate}}
            pdata["a:t-winrate"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WINRATE, stat.v.winrate, NaN);
            // {{a:t-rating}} (obsolete)
            pdata["a:t-rating"] = pdata["a:t-winrate"];
            // {{a:t-battles}}
            pdata["a:t-battles"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TBATTLES, stat.v.b, NaN);
            // {{a:tdb}}
            pdata["a:tdb"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TDB, stat.v.db, NaN);
            // {{a:xtdb}}
            pdata["a:xtdb"] = isNaN(stat.v.xtdb) || stat.v.xtdb <= 0 ? NaN : MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.v.xtdb, NaN);
            // {{a:xvwtr}}
            pdata["a:xvwtr"] = isNaN(stat.v.xwtr) || stat.v.xwtr <= 0 ? NaN : MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.v.xwtr, NaN);
            // {{a:tdv}}
            pdata["a:tdv"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TDV, stat.v.dv, NaN);
            // {{a:tfb}}
            pdata["a:tfb"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TFB, stat.v.fb, NaN);
            // {{a:tsb}}
            pdata["a:tsb"] = MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TSB, stat.v.sb, NaN);
        }

        /**
         * Change nicks for XVM developers.
         * @param playerName player name
         * @return personal name
         */
        private function getCustomPlayerName(playerName:String, accountDBID:Number):String
        {
            switch (Config.config.region)
            {
                case "RU":
                    if (playerName == "www_modxvm_com")
                        return "https://modxvm.com";
                    if (playerName == "M_r_A")
                        return "Флаттершай - лучшая пони!";
                    if (playerName == "sirmax2" || playerName == "0x01" || playerName == "_SirMax_")
                        return "https://modxvm.com";
                    if (playerName == "Mixailos")
                        return "Михаил";
                    if (playerName == "STL1te")
                        return "О, СТЛайт!";
                    if (playerName == "seriych")
                        return "Всем Счастья :)";
                    if (playerName == "XIebniDizele4ky" || playerName == "Xlebni_Dizele4ky" || playerName == "XlebniDizeIe4ku" || playerName == "XlebniDize1e4ku" || playerName == "XlebniDizele4ku_2013")
                        return "Alex Artobanana";
                    break;

                case "CT":
                    if (playerName == "www_modxvm_com_RU")
                        return "https://modxvm.com";
                    if (playerName == "M_r_A_RU" || playerName == "M_r_A_EU")
                        return "Fluttershy is best pony!";
                    if (playerName == "sirmax2_RU" || playerName == "sirmax2_EU" || playerName == "sirmax_NA" || playerName == "0x01_RU" || playerName == "0x01_EU")
                        return "https://modxvm.com";
                    if (playerName == "seriych_RU")
                        return "Be Happy :)";
                    break;

                case "EU":
                    if (playerName == "M_r_A")
                        return "Fluttershy is best pony!";
                    if (playerName == "sirmax2" || playerName == "0x01" || playerName == "_SirMax_")
                        return "https://modxvm.com";
                    if (playerName == "seriych")
                        return "Be Happy :)";
                    break;

                case "US":
                    if (playerName == "sirmax" || playerName == "0x01" || playerName == "_SirMax_")
                        return "https://modxvm.com";
                    break;

                case "ST":
                    if (playerName == "xvm_1")
                        return "«xvm»";
                    break;
            }

            return playerName;
        }

        // rating

        private const RATING_MATRIX:Object =
        {
            xvm_wgr:   { name: "xwgr", def: "--" },
            xvm_wtr:   { name: "xwtr", def: "--" },
            xvm_wn8:   { name: "xwn8", def: "--" },
            xvm_eff:   { name: "xeff", def: "--" },
            xvm_xte:   { name: "xte",  def: "--" },
            basic_wgr: { name: "wgr",  def: "-----" },
            basic_wtr: { name: "wtr",  def: "----" },
            basic_wn8: { name: "wn8",  def: "----" },
            basic_eff: { name: "eff",  def: "----" },
            basic_xte: { name: "xte",  def: "--" }
        }

        /**
         * Returns rating according settings in the personal cabinet
         */
        private function _getRating(pdata:Object, prefix:String, suffix:String, scale:String):*
        {
            var name:String = _getRatingName(scale);
            var value:* = pdata[prefix + RATING_MATRIX[name].name + suffix];
            if (prefix || value == null)
                return value;
            value = XfwUtils.leftPad(String(value), _getRatingDefaultValue(scale).length, " ");
            return value;
        }

        /**
         * Returns default value for rating according settings in the personal cabinet
         */
        private function _getRatingDefaultValue(scale:String = null):String
        {
            var name:String = _getRatingName(scale);
            return RATING_MATRIX[name].def;
        }

        private function _getRatingName(scale:String):String
        {
            var sc:String = (scale == null) ? Config.networkServicesSettings.scale : scale;
            var name:String = sc + "_" + Config.networkServicesSettings.rating;
            if (!(name in RATING_MATRIX))
                name = (scale != null ? scale : "basic") + "_wgr";
            return name;
        }
    }
}

class MacrosResult
{
    public var isStaticMacro:Boolean = true;
    public var isHybridMacro:Boolean = false;
}
