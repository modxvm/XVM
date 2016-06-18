// AS3:DONE /**
// AS3:DONE  * XVM Macro substitutions
// AS3:DONE  * @author Maxim Schedriviy <max(at)modxvm.com>
// AS3:DONE  */
// AS3:DONE import com.xvm.*;
// AS3:DONE import com.xvm.DataTypes.*;
// AS3:DONE
// AS3:DONE class com.xvm.Macros
// AS3:DONE {
// AS3:DONE     // PUBLIC STATIC
// AS3:DONE
// AS3:DONE     public static function Format(pname:String, format:String, options:Object):String
// AS3:DONE     {
// AS3:DONE         return _instance._Format(pname, format, options);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     public static function FormatByPlayerId(playerId:Number, format:String, options:Object):String
// AS3:DONE     {
// AS3:DONE         return _instance._Format(_instance.m_playerId_to_pname[playerId], format, options);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     public static function FormatNumber(pname:String, cfg:Object, fieldName:String, obj:Object, nullValue:Number, emptyValue:Number, isColorValue:Boolean):Number
// AS3:DONE     {
// AS3:DONE         var value = cfg[fieldName];
// AS3:DONE         if (value == null)
// AS3:DONE             return nullValue;
// AS3:DONE         if (isNaN(value))
// AS3:DONE         {
// AS3:DONE             //Logger.add(value + " => " + Macros.Format(m_name, value, null));
// AS3:DONE             var v = Macros.Format(pname, value, obj);
// AS3:DONE             if (v == "XX")
// AS3:DONE                 v = 100;
// AS3:DONE             if (isColorValue)
// AS3:DONE                 v = v.split("#").join("0x");
// AS3:DONE             if (Macros.IsCached(pname, value))
// AS3:DONE                 cfg[fieldName] = v;
// AS3:DONE             value = v;
// AS3:DONE         }
// AS3:DONE         if (isNaN(value))
// AS3:DONE             return emptyValue;
// AS3:DONE         return Number(value);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     public static function FormatGlobalNumberValue(value, defaultValue:Number):Number
// AS3:DONE     {
// AS3:DONE         return _instance._FormatGlobalNumberValue(value, defaultValue);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     public static function FormatGlobalBooleanValue(value, defaultValue:Boolean):Boolean
// AS3:DONE     {
// AS3:DONE         return _instance._FormatGlobalBooleanValue(value, defaultValue);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     public static function FormatGlobalStringValue(value, defaultValue:String):String
// AS3:DONE     {
// AS3:DONE         return _instance._FormatGlobalStringValue(value, defaultValue);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     public static function IsCached(pname:String, format:String, alive:Boolean):Boolean
// AS3:DONE     {
// AS3:DONE         return _instance._IsCached(pname, format, alive);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     public static function getGlobalValue(key:String)
// AS3:DONE     {
// AS3:DONE         return _instance.m_globals[key];
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     public static function RegisterGlobalMacrosData()
// AS3:DONE     {
// AS3:DONE         _instance._RegisterGlobalMacrosData();
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     public static function RegisterGlobalMacrosDataDelayed(onEventName: String)
// AS3:DONE     {
// AS3:DONE         _instance._RegisterGlobalMacrosDataDelayed(onEventName);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     public static function RegisterZoomIndicatorData(zoom:Number)
// AS3:DONE     {
// AS3:DONE         _instance._RegisterZoomIndicatorData(zoom);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     public static function RegisterPlayerData(pname:String, data:Object, team:Number)
// AS3:DONE     {
// AS3:DONE         _instance._RegisterPlayerData(pname, data, team);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     public static function RegisterStatisticsMacros(pname:String, stat:StatData)
// AS3:DONE     {
// AS3:DONE         _instance._RegisterStatisticsMacros(pname, stat);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     public static function RegisterMarkerData(pname:String, data:Object)
// AS3:DONE     {
// AS3:DONE         _instance._RegisterMarkerData(pname, data);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     public static var s_my_frags:Number = 0;
// AS3:DONE
// AS3:DONE     public static function UpdateMyFrags(frags:Number):Boolean
// AS3:DONE     {
// AS3:DONE         if (Macros.s_my_frags == frags)
// AS3:DONE             return false;
// AS3:DONE         Macros.s_my_frags = frags;
// AS3:DONE         return true;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     // PRIVATE
// AS3:DONE
// AS3:DONE     private static var PART_NAME:Number = 0;
// AS3:DONE     private static var PART_NORM:Number = 1;
// AS3:DONE     private static var PART_FMT:Number = 2;
// AS3:DONE     private static var PART_SUF:Number = 3;
// AS3:DONE     private static var PART_MATCH_OP:Number = 4;
// AS3:DONE     private static var PART_MATCH:Number = 5;
// AS3:DONE     private static var PART_REP:Number = 6;
// AS3:DONE     private static var PART_DEF:Number = 7;
// AS3:DONE
// AS3:DONE     private static var _instance:Macros = new Macros();
// AS3:DONE
// AS3:DONE     private var m_macros_cache:Object = { };
// AS3:DONE     private var m_macros_cache_global:Object = { };
// AS3:DONE     private var m_dict:Object = { }; //{ PLAYERNAME1: { macro1: func || value, macro2:... }, PLAYERNAME2: {...} }
// AS3:DONE     private var m_playerId_to_pname:Object = { };
// AS3:DONE     private var m_globals:Object = { };
// AS3:DONE     private var m_contacts:Object = { };
// AS3:DONE
// AS3:DONE     private var curent_xtdb: Number = 0;
// AS3:DONE
// AS3:DONE     private var isStaticMacro:Boolean;
// AS3:DONE
// AS3:DONE     /**
// AS3:DONE      * Format string with macros substitutions
// AS3:DONE      *   {{name[:norm][%[flag][width][.prec]type][~suf][(=|!=|<|<=|>|>=)match][?rep][|def]}}
// AS3:DONE      * @param pname player name without extra tags (clan, region, etc)
// AS3:DONE      * @param format string template
// AS3:DONE      * @param options data for dynamic values
// AS3:DONE      * @return Formatted string
// AS3:DONE      */
// AS3:DONE     private function _Format(pname:String, format:String, options:Object):String
// AS3:DONE     {
// AS3:DONE         //Logger.add("format:" + format + " player:" + pname);
// AS3:DONE         if (format == null || format == "")
// AS3:DONE             return "";
// AS3:DONE
// AS3:DONE         try
// AS3:DONE         {
// AS3:DONE             // Check cached value
// AS3:DONE             var player_cache:Object;
// AS3:DONE             var cached_value;
// AS3:DONE             if (pname != null && pname != "" && options != null)
// AS3:DONE             {
// AS3:DONE                 player_cache = m_macros_cache[pname];
// AS3:DONE                 if (player_cache == null)
// AS3:DONE                 {
// AS3:DONE                     m_macros_cache[pname] = { alive: { }, dead: { }};
// AS3:DONE                     player_cache = m_macros_cache[pname];
// AS3:DONE                 }
// AS3:DONE                 player_cache = player_cache[options.dead == true ? "dead" : "alive"];
// AS3:DONE                 cached_value = player_cache[format];
// AS3:DONE             }
// AS3:DONE             else
// AS3:DONE             {
// AS3:DONE                 cached_value = m_macros_cache_global[format];
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             if (cached_value !== undefined)
// AS3:DONE             {
// AS3:DONE                 //Logger.add("cached: " + cached_value);
// AS3:DONE                 return cached_value;
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             // Split tags
// AS3:DONE             var formatArr:Array = format.split("{{");
// AS3:DONE
// AS3:DONE             isStaticMacro = true;
// AS3:DONE             var res:String;
// AS3:DONE             var len:Number = formatArr.length;
// AS3:DONE             if (len <= 1)
// AS3:DONE             {
// AS3:DONE                 res = format;
// AS3:DONE             }
// AS3:DONE             else
// AS3:DONE             {
// AS3:DONE                 res = formatArr[0];
// AS3:DONE
// AS3:DONE                 for (var i:Number = 1; i < len; ++i)
// AS3:DONE                 {
// AS3:DONE                     var part:String = formatArr[i];
// AS3:DONE                     var idx:Number = part.indexOf("}}");
// AS3:DONE                     if (idx < 0)
// AS3:DONE                     {
// AS3:DONE                         res += "{{" + part;
// AS3:DONE                     }
// AS3:DONE                     else
// AS3:DONE                     {
// AS3:DONE                         res += _FormatPart(part.slice(0, idx), pname, options) + part.slice(idx + 2);
// AS3:DONE                     }
// AS3:DONE                 }
// AS3:DONE
// AS3:DONE                 if (res != format)
// AS3:DONE                 {
// AS3:DONE                     var iMacroPos:Number = res.indexOf("{{");
// AS3:DONE                     if (iMacroPos >= 0 && res.indexOf("}}", iMacroPos) >= 0)
// AS3:DONE                     {
// AS3:DONE                         //Logger.add("recursive: " + pname + " " + res);
// AS3:DONE                         var isStatic:Boolean = isStaticMacro;
// AS3:DONE                         res = _Format(pname, res, options);
// AS3:DONE                         isStaticMacro = isStatic && isStaticMacro;
// AS3:DONE                     }
// AS3:DONE                 }
// AS3:DONE             }
// AS3:DONE
// AS3:DONE
// AS3:DONE             res = Utils.fixImgTag(res);
// AS3:DONE
// AS3:DONE             if (isStaticMacro)
// AS3:DONE             {
// AS3:DONE                 if (pname != null && pname != "")
// AS3:DONE                 {
// AS3:DONE                     if (options != null)
// AS3:DONE                     {
// AS3:DONE                         //Logger.add("add to cache: " + format + " => " + res);
// AS3:DONE                         player_cache[format] = res;
// AS3:DONE                     }
// AS3:DONE                 }
// AS3:DONE                 else
// AS3:DONE                 {
// AS3:DONE                     m_macros_cache_global[format] = res;
// AS3:DONE                 }
// AS3:DONE             }
// AS3:DONE             //else
// AS3:DONE             //    Logger.add(pname + "> " + format);
// AS3:DONE
// AS3:DONE             //Logger.add(pname + "> " + format);
// AS3:DONE             //Logger.add(pname + "= " + res);
// AS3:DONE
// AS3:DONE             return res;
// AS3:DONE         }
// AS3:DONE         catch (ex:Error)
// AS3:DONE         {
// AS3:DONE             Logger.add(ex.message);
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         return "";
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function _FormatPart(macro:String, pname:String, options:Object):String
// AS3:DONE     {
// AS3:DONE         // Process tag
// AS3:DONE         var pdata = pname == null ? m_globals : m_dict[pname];
// AS3:DONE         if (pdata == null)
// AS3:DONE             return "";
// AS3:DONE
// AS3:DONE         var res:String = "";
// AS3:DONE
// AS3:DONE         var parts:Array = _GetMacroParts(macro, pdata);
// AS3:DONE
// AS3:DONE         var macroName:String = parts[PART_NAME];
// AS3:DONE         var norm:String = parts[PART_NORM];
// AS3:DONE         var def:String = parts[PART_DEF];
// AS3:DONE
// AS3:DONE         var vehId:Number = pdata["veh-id"];
// AS3:DONE
// AS3:DONE         var value;
// AS3:DONE
// AS3:DONE         var dotPos:Number = macroName.indexOf(".");
// AS3:DONE         if (dotPos == 0)
// AS3:DONE         {
// AS3:DONE             value = _SubstituteConfigPart(macroName.slice(1));
// AS3:DONE         }
// AS3:DONE         else
// AS3:DONE         {
// AS3:DONE             if (dotPos > 0)
// AS3:DONE             {
// AS3:DONE                 if (options == null)
// AS3:DONE                     options = { };
// AS3:DONE                 options.__subname = macroName.slice(dotPos + 1);
// AS3:DONE                 macroName = macroName.slice(0, dotPos);
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             value = pdata[macroName];
// AS3:DONE
// AS3:DONE             if (value === undefined)
// AS3:DONE                 value = m_globals[macroName];
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         //Logger.add("macro:" + macro + " | macroname:" + macroName + " | norm:" + norm + " | def:" + def + " | value:" + value);
// AS3:DONE
// AS3:DONE         if (value === undefined)
// AS3:DONE         {
// AS3:DONE             //process l10n macro
// AS3:DONE             if (macroName == "l10n")
// AS3:DONE             {
// AS3:DONE                 res += prepareValue(NaN, macroName, norm, def, vehId);
// AS3:DONE             }
// AS3:DONE             else if (macroName == "py")
// AS3:DONE             {
// AS3:DONE                 res += prepareValue(NaN, macroName, norm, def, vehId);
// AS3:DONE             }
// AS3:DONE             else
// AS3:DONE             {
// AS3:DONE                 res += def;
// AS3:DONE                 if (dotPos != 0)
// AS3:DONE                     isStaticMacro = false;
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE         else if (value == null)
// AS3:DONE         {
// AS3:DONE             //Logger.add(macroName + " " + norm + " " + def + "  " + format);
// AS3:DONE             res += prepareValue(NaN, macroName, norm, def, vehId);
// AS3:DONE         }
// AS3:DONE         else
// AS3:DONE         {
// AS3:DONE             // is static macro
// AS3:DONE             var type:String = typeof value;
// AS3:DONE             if (type == "function" && (macroName != "alive" || options == null))
// AS3:DONE                 isStaticMacro = false;
// AS3:DONE             else if (vehId == 0 || !Utils.isArenaGuiTypeWithPlayerPanels())
// AS3:DONE             {
// AS3:DONE                 switch (macroName)
// AS3:DONE                 {
// AS3:DONE                     case "maxhp":
// AS3:DONE                     case "veh-id":
// AS3:DONE                     case "vehicle":
// AS3:DONE                     case "vehiclename":
// AS3:DONE                     case "vehicle-short":
// AS3:DONE                     case "vtype-key":
// AS3:DONE                     case "vtype":
// AS3:DONE                     case "vtype-l":
// AS3:DONE                     case "c:vtype":
// AS3:DONE                     case "battletier-min":
// AS3:DONE                     case "battletier-max":
// AS3:DONE                     case "nation":
// AS3:DONE                     case "level":
// AS3:DONE                     case "rlevel":
// AS3:DONE                         isStaticMacro = false;
// AS3:DONE                         break;
// AS3:DONE                 }
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             res += _FormatMacro(macro, parts, value, vehId, options);
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         if (isStaticMacro)
// AS3:DONE         {
// AS3:DONE             switch (macroName)
// AS3:DONE             {
// AS3:DONE                 case "squad":
// AS3:DONE                 case "squad-num":
// AS3:DONE                 case "zoom":
// AS3:DONE                     isStaticMacro = false;
// AS3:DONE                     break;
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         return res;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private var _macro_parts_cache:Object = {};
// AS3:DONE     private function _GetMacroParts(macro:String, pdata:Object):Array
// AS3:DONE     {
// AS3:DONE         var parts:Array = _macro_parts_cache[macro];
// AS3:DONE         if (parts)
// AS3:DONE             return parts;
// AS3:DONE
// AS3:DONE         //Logger.add("_GetMacroParts: " + macro);
// AS3:DONE         //Logger.addObject(pdata);
// AS3:DONE
// AS3:DONE         parts = [null,null,null,null,null,null,null,null];
// AS3:DONE
// AS3:DONE         // split parts: name[:norm][%[flag][width][.prec]type][~suf][(=|!=|<|<=|>|>=)match][?rep][|def]
// AS3:DONE         var macroArr:Array = macro.split("");
// AS3:DONE         var len:Number = macroArr.length;
// AS3:DONE         var part:String = "";
// AS3:DONE         var section:Number = 0;
// AS3:DONE         var nextSection:Number = section;
// AS3:DONE         for (var i:Number = 0; i < len; ++i)
// AS3:DONE         {
// AS3:DONE             var ch:String = macroArr[i];
// AS3:DONE             switch (ch)
// AS3:DONE             {
// AS3:DONE                 case ":":
// AS3:DONE                     if (section < 1 && (part != "c" && part != "a"))
// AS3:DONE                         nextSection = 1;
// AS3:DONE                     break;
// AS3:DONE                 case "%":
// AS3:DONE                     if (section < 2)
// AS3:DONE                         nextSection = 2;
// AS3:DONE                     break;
// AS3:DONE                 case "~":
// AS3:DONE                     if (section < 3)
// AS3:DONE                         nextSection = 3;
// AS3:DONE                     break;
// AS3:DONE                 case "!":
// AS3:DONE                 case "=":
// AS3:DONE                 case ">":
// AS3:DONE                 case "<":
// AS3:DONE                     if (section < 4)
// AS3:DONE                     {
// AS3:DONE                         if (i < len - 1 && macroArr[i + 1] == "=")
// AS3:DONE                         {
// AS3:DONE                             i++;
// AS3:DONE                             ch += macroArr[i];
// AS3:DONE                         }
// AS3:DONE                         parts[PART_MATCH_OP] = ch;
// AS3:DONE                         nextSection = 5;
// AS3:DONE                     }
// AS3:DONE                     break;
// AS3:DONE                 case "?":
// AS3:DONE                     if (section < 6)
// AS3:DONE                         nextSection = 6;
// AS3:DONE                     break;
// AS3:DONE                 case "|":
// AS3:DONE                     if (section < 7)
// AS3:DONE                         nextSection = 7;
// AS3:DONE                     break;
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             if (nextSection == section)
// AS3:DONE             {
// AS3:DONE                 part += ch;
// AS3:DONE             }
// AS3:DONE             else
// AS3:DONE             {
// AS3:DONE                 parts[section] = part;
// AS3:DONE                 section = nextSection;
// AS3:DONE                 part = "";
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE         parts[section] = part;
// AS3:DONE
// AS3:DONE         if (parts[PART_DEF] == null)
// AS3:DONE             parts[PART_DEF] = "";
// AS3:DONE
// AS3:DONE         if (parts[PART_NAME] == "r" && parts[PART_DEF] == "")
// AS3:DONE             parts[PART_DEF] = getRatingDefaultValue();
// AS3:DONE         else if (parts[PART_NAME] == "xr" && parts[PART_DEF] == "")
// AS3:DONE             parts[PART_DEF] = getRatingDefaultValue("xvm");
// AS3:DONE
// AS3:DONE         //Logger.add("[AS2][MACROS][_GetMacroParts]: " + parts.join(", "));
// AS3:DONE         _macro_parts_cache[macro] = parts;
// AS3:DONE         return parts;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function _SubstituteConfigPart(path:String):String
// AS3:DONE     {
// AS3:DONE         var res = Utils.getObjectValueByPath(Config.config, path);
// AS3:DONE         //Logger.addObject(res, 1, path);
// AS3:DONE         if (res == null)
// AS3:DONE             return res;
// AS3:DONE         if (typeof(res) == "object")
// AS3:DONE             return JSONx.stringify(res, "", true);
// AS3:DONE         return String(res);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private var _format_macro_fmt_suf_cache:Object = {};
// AS3:DONE     private function _FormatMacro(macro:String, parts:Array, value, vehId:Number, options:Object):String
// AS3:DONE     {
// AS3:DONE         var name:String = parts[PART_NAME];
// AS3:DONE         var norm:String = parts[PART_NORM];
// AS3:DONE         var fmt:String = parts[PART_FMT];
// AS3:DONE         var suf:String = parts[PART_SUF];
// AS3:DONE         var match_op:String = parts[PART_MATCH_OP];
// AS3:DONE         var match:String = parts[PART_MATCH];
// AS3:DONE         var rep:String = parts[PART_REP];
// AS3:DONE         var def:String = parts[PART_DEF];
// AS3:DONE
// AS3:DONE         // substitute
// AS3:DONE         //Logger.add("name:" + name + " norm:" + norm + " fmt:" + fmt + " suf:" + suf + " rep:" + rep + " def:" + def);
// AS3:DONE
// AS3:DONE         var type:String = typeof value;
// AS3:DONE         //Logger.add("type:" + type + " value:" + value + " name:" + name + " fmt:" + fmt + " suf:" + suf + " def:" + def + " macro:" + macro);
// AS3:DONE
// AS3:DONE         if (type == "number" && isNaN(value))
// AS3:DONE             return prepareValue(NaN, name, norm, def, vehId);
// AS3:DONE
// AS3:DONE         var res:String = value;
// AS3:DONE         if (type == "function")
// AS3:DONE         {
// AS3:DONE             if (options == null)
// AS3:DONE                 return "{{" + macro + "}}";
// AS3:DONE             value = value(options);
// AS3:DONE             if (value == null)
// AS3:DONE                 return prepareValue(NaN, name, norm, def, vehId);
// AS3:DONE             type = typeof value;
// AS3:DONE             if (type == "number" && isNaN(value))
// AS3:DONE                 return prepareValue(NaN, name, norm, def, vehId);
// AS3:DONE             res = value;
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         if (match != null)
// AS3:DONE         {
// AS3:DONE             var matched:Boolean = false;
// AS3:DONE             switch (match_op)
// AS3:DONE             {
// AS3:DONE                 case "=":
// AS3:DONE                 case "==":
// AS3:DONE                     matched = value == match;
// AS3:DONE                     break;
// AS3:DONE                 case "!=":
// AS3:DONE                     matched = value != match;
// AS3:DONE                     break;
// AS3:DONE                 case "<":
// AS3:DONE                     matched = Number(value) < Number(match);
// AS3:DONE                     break;
// AS3:DONE                 case "<=":
// AS3:DONE                     matched = Number(value) <= Number(match);
// AS3:DONE                     break;
// AS3:DONE                 case ">":
// AS3:DONE                     matched = Number(value) > Number(match);
// AS3:DONE                     break;
// AS3:DONE                 case ">=":
// AS3:DONE                     matched = Number(value) >= Number(match);
// AS3:DONE                     break;
// AS3:DONE             }
// AS3:DONE             if (!matched)
// AS3:DONE                 return prepareValue(NaN, name, norm, def, vehId);
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         if (rep != null)
// AS3:DONE             return rep;
// AS3:DONE
// AS3:DONE         if (norm != null)
// AS3:DONE             res = prepareValue(value, name, norm, def, vehId);
// AS3:DONE
// AS3:DONE         if (fmt == null && suf == null)
// AS3:DONE             return res;
// AS3:DONE
// AS3:DONE         var fmt_suf_key:String = fmt + "," + suf + "," + res;
// AS3:DONE         var fmt_suf_res:String = _format_macro_fmt_suf_cache[fmt_suf_key];
// AS3:DONE         if (fmt_suf_res)
// AS3:DONE             return fmt_suf_res;
// AS3:DONE
// AS3:DONE         if (fmt != null)
// AS3:DONE         {
// AS3:DONE             res = Sprintf.format("%" + fmt, res);
// AS3:DONE             //Logger.add(value + "|" + res + "|");
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         if (suf != null)
// AS3:DONE         {
// AS3:DONE             if (type == "string")
// AS3:DONE             {
// AS3:DONE                 if (res.length - suf.length > 0)
// AS3:DONE                 {
// AS3:DONE                     // search precision
// AS3:DONE                     var fmt_parts:Array = fmt.split(".", 2);
// AS3:DONE                     if (fmt_parts.length == 2)
// AS3:DONE                     {
// AS3:DONE                         fmt_parts = fmt_parts[1].split('');
// AS3:DONE                         var len:Number = fmt_parts.length;
// AS3:DONE                         var precision:Number = 0;
// AS3:DONE                         for (var i:Number = 0; i < len; ++i)
// AS3:DONE                         {
// AS3:DONE                             var ch:String = fmt_parts[i];
// AS3:DONE                             if (ch < '0' || ch > '9')
// AS3:DONE                                 break;
// AS3:DONE                             precision = (precision * 10) + Number(ch);
// AS3:DONE                         }
// AS3:DONE                         if (value.length > precision)
// AS3:DONE                             res = res.substr(0, res.length - suf.length) + suf;
// AS3:DONE                     }
// AS3:DONE                 }
// AS3:DONE             }
// AS3:DONE             else
// AS3:DONE             {
// AS3:DONE                 res += suf;
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         //Logger.add(res);
// AS3:DONE         _format_macro_fmt_suf_cache[fmt_suf_key] = res;
// AS3:DONE         return res;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private var _prepare_value_cache:Object = {};
// AS3:DONE     private function prepareValue(value, name:String, norm:String, def:String, vehId:Number):String
// AS3:DONE     {
// AS3:DONE         if (norm == null)
// AS3:DONE             return def;
// AS3:DONE
// AS3:DONE         var res:String = def;
// AS3:DONE         switch (name)
// AS3:DONE         {
// AS3:DONE             case "hp":
// AS3:DONE             case "hp-max":
// AS3:DONE                 if (Config.config.battle.allowHpInPanelsAndMinimap == false)
// AS3:DONE                     break;
// AS3:DONE                 var key:String = name + "," + norm + "," + value + "," + vehId;
// AS3:DONE                 res = _prepare_value_cache[key];
// AS3:DONE                 if (res)
// AS3:DONE                     return res;
// AS3:DONE                 if (isNaN(value))
// AS3:DONE                 {
// AS3:DONE                     var vdata:VehicleData = VehicleInfo.get(vehId);
// AS3:DONE                     if (vdata == null)
// AS3:DONE                         break;
// AS3:DONE                     value = vdata.hpTop;
// AS3:DONE                 }
// AS3:DONE                 if (!isNaN(value))
// AS3:DONE                 {
// AS3:DONE                     var maxHp:Number = m_globals["maxhp"];
// AS3:DONE                     res = Math.round(parseInt(norm) * value / maxHp).toString();
// AS3:DONE                 }
// AS3:DONE                 _prepare_value_cache[key] = res;
// AS3:DONE                 //Logger.add(key + " => " + res);
// AS3:DONE                 break;
// AS3:DONE             case "hp-ratio":
// AS3:DONE                 if (Config.config.battle.allowHpInPanelsAndMinimap == false)
// AS3:DONE                     break;
// AS3:DONE                 if (isNaN(value))
// AS3:DONE                     value = 100;
// AS3:DONE                 res = Math.round(parseInt(norm) * value / 100).toString();
// AS3:DONE                 break;
// AS3:DONE             case "r":
// AS3:DONE             case "xr":
// AS3:DONE             case "xte":
// AS3:DONE             case "xwgr":
// AS3:DONE             case "xwn":
// AS3:DONE             case "xwn6":
// AS3:DONE             case "xeff":
// AS3:DONE             case "xtdb":
// AS3:DONE                 if (name == "r" && Config.networkServicesSettings.scale != "xvm")
// AS3:DONE                     break;
// AS3:DONE                 if (value == 'XX')
// AS3:DONE                     value = 100;
// AS3:DONE                 else
// AS3:DONE                 {
// AS3:DONE                     value = parseInt(value);
// AS3:DONE                     if (isNaN(value))
// AS3:DONE                         value = 0;
// AS3:DONE                 }
// AS3:DONE                 res = Math.round(parseInt(norm) * value / 100).toString();
// AS3:DONE                 break;
// AS3:DONE             case "l10n":
// AS3:DONE                 res = Locale.get(norm);
// AS3:DONE                 if (res == null)
// AS3:DONE                     res = def;
// AS3:DONE                 break;
// AS3:DONE             case "py":
// AS3:DONE                 res = DAAPI.py_xvm_pythonMacro(norm);
// AS3:DONE                 isStaticMacro = res[1];
// AS3:DONE                 res = res[0];
// AS3:DONE                 if (res == null)
// AS3:DONE                     res = def;
// AS3:DONE                 break;
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         return res;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function _FormatGlobalNumberValue(value, defaultValue:Number):Number
// AS3:DONE     {
// AS3:DONE         if (value == null)
// AS3:DONE             return (defaultValue === undefined) ? NaN : defaultValue;
// AS3:DONE         if (!isNaN(value))
// AS3:DONE             return Number(value);
// AS3:DONE         var res:Number = Number(_Format(null, value, {}));
// AS3:DONE         if (isFinite(res))
// AS3:DONE             return res;
// AS3:DONE         return (defaultValue === undefined) ? NaN : defaultValue;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function _FormatGlobalBooleanValue(value, defaultValue:Boolean):Boolean
// AS3:DONE     {
// AS3:DONE         if (value == null)
// AS3:DONE             return (defaultValue === undefined) ? false : defaultValue;
// AS3:DONE         if (typeof value == "boolean")
// AS3:DONE             return value;
// AS3:DONE         var res:String = String(_Format(null, value, { } )).toLowerCase();
// AS3:DONE         if (res == 'true')
// AS3:DONE             return true;
// AS3:DONE         if (res == 'false')
// AS3:DONE             return false;
// AS3:DONE         return (defaultValue === undefined) ? false : defaultValue;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function _FormatGlobalStringValue(value, defaultValue:String):String
// AS3:DONE     {
// AS3:DONE         if (value == null)
// AS3:DONE             return (defaultValue === undefined) ? null : defaultValue;
// AS3:DONE         var res:String = _Format(null, String(value), { } );
// AS3:DONE         return res != null ? res : (defaultValue === undefined) ? null : defaultValue;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     /**
// AS3:DONE      * Is macros value cached
// AS3:DONE      * @param pname player name without extra tags (clan, region, etc)
// AS3:DONE      * @param format string template
// AS3:DONE      * @param options data for dynamic values
// AS3:DONE      * @return true if macros value is cached else false
// AS3:DONE      */
// AS3:DONE     private function _IsCached(pname:String, format:String, alive:Boolean):Boolean
// AS3:DONE     {
// AS3:DONE         if (format == null || format == "")
// AS3:DONE             return false;
// AS3:DONE
// AS3:DONE         if (pname != null && pname != "")
// AS3:DONE         {
// AS3:DONE             var player_cache:Object = m_macros_cache[pname];
// AS3:DONE             if (player_cache == null)
// AS3:DONE                 return false;
// AS3:DONE             return player_cache[alive ? "alive" : "dead"][format] !== undefined;
// AS3:DONE         }
// AS3:DONE         else
// AS3:DONE         {
// AS3:DONE             return m_macros_cache_global[format] !== undefined;
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     // Macros registration
// AS3:DONE
// AS3:DONE     private function _RegisterGlobalMacrosData()
// AS3:DONE     {
// AS3:DONE         // {{xvm-stat}}
// AS3:DONE         m_globals["xvm-stat"] = Config.networkServicesSettings.statBattle == true ? 'stat' : null;
// AS3:DONE
// AS3:DONE         // {{r_size}}
// AS3:DONE         m_globals["r_size"] = getRatingDefaultValue().length;
// AS3:DONE
// AS3:DONE         var battleLevel:Number;
// AS3:DONE         switch (Config.battleType)
// AS3:DONE         {
// AS3:DONE             case Defines.BATTLE_TYPE_CYBERSPORT:
// AS3:DONE                 battleLevel = 8;
// AS3:DONE                 break;
// AS3:DONE             case Defines.BATTLE_TYPE_REGULAR:
// AS3:DONE                 battleLevel = Config.battleLevel;
// AS3:DONE                 break;
// AS3:DONE             default:
// AS3:DONE                 battleLevel = 10;
// AS3:DONE                 break;
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         // {{battletype}}
// AS3:DONE         m_globals["battletype"] = Utils.getBattleTypeText(Config.battleType);
// AS3:DONE         // {{battletier}}
// AS3:DONE         m_globals["battletier"] = battleLevel;
// AS3:DONE
// AS3:DONE         // {{cellsize}}
// AS3:DONE         m_globals["cellsize"] = Math.round(Config.mapSize / 10);
// AS3:DONE
// AS3:DONE         // {{my-frags}}
// AS3:DONE         m_globals["my-frags"] = function(o:Object) { return isNaN(Macros.s_my_frags) || Macros.s_my_frags == 0 ? NaN : Macros.s_my_frags; }
// AS3:DONE
// AS3:DONE         var vdata:VehicleData = VehicleInfo.get(Config.myVehId);
// AS3:DONE         // {{my-veh-id}}
// AS3:DONE         m_globals["my-veh-id"] = vdata.vid;
// AS3:DONE         // {{my-vehicle}} - Chaffee
// AS3:DONE         m_globals["my-vehicle"] = vdata.localizedName;
// AS3:DONE         // {{my-vehiclename}} - usa-M24_Chaffee
// AS3:DONE         m_globals["my-vehiclename"] = VehicleInfo.getVIconName(vdata.key);
// AS3:DONE         // {{my-vehicle-short}} - Chaff
// AS3:DONE         m_globals["my-vehicle-short"] = vdata.shortName || vdata.localizedName;
// AS3:DONE         // {{my-vtype-key}} - MT
// AS3:DONE         m_globals["my-vtype-key"] = vdata.vtype;
// AS3:DONE         // {{my-vtype}}
// AS3:DONE         m_globals["my-vtype"] = VehicleInfo.getVTypeText(vdata.vtype);
// AS3:DONE         // {{my-vtype-l}} - Medium Tank
// AS3:DONE         m_globals["my-vtype-l"] = Locale.get(vdata.vtype);
// AS3:DONE         // {{c:my-vtype}}
// AS3:DONE         m_globals["c:my-vtype"] = GraphicsUtil.GetVTypeColorValue(vdata.vid);
// AS3:DONE         // {{my-battletier-min}}
// AS3:DONE         m_globals["my-battletier-min"] = vdata.tierLo;
// AS3:DONE         // {{my-battletier-max}}
// AS3:DONE         m_globals["my-battletier-max"] = vdata.tierHi;
// AS3:DONE         // {{my-nation}}
// AS3:DONE         m_globals["my-nation"] = vdata.nation;
// AS3:DONE         // {{my-level}}
// AS3:DONE         m_globals["my-level"] = vdata.level;
// AS3:DONE         // {{my-rlevel}}
// AS3:DONE         m_globals["my-rlevel"] = Defines.ROMAN_LEVEL[vdata.level - 1];
// AS3:DONE
// AS3:DONE
// AS3:DONE         // Capture bar
// AS3:DONE
// AS3:DONE         // {{cap.points}}
// AS3:DONE         // {{cap.tanks}}
// AS3:DONE         // {{cap.time}}
// AS3:DONE         // {{cap.time-sec}}
// AS3:DONE         m_globals["cap"] = function(o:Object)
// AS3:DONE         {
// AS3:DONE             switch (o.__subname)
// AS3:DONE             {
// AS3:DONE                 case "points": return isNaN(o.points) ? NaN : o.points;
// AS3:DONE                 case "tanks": return isNaN(o.vehiclesCount) ? NaN : o.vehiclesCount;
// AS3:DONE                 case "time":  return o.timeLeft;
// AS3:DONE                 case "time-sec": return isNaN(o.timeLeftSec) ? NaN : o.timeLeftSec;
// AS3:DONE             }
// AS3:DONE             return null;
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function _RegisterGlobalMacrosDataDelayed(eventName: String)
// AS3:DONE     {
// AS3:DONE         switch (eventName)
// AS3:DONE         {
// AS3:DONE             case "ON_STAT_LOADED":
// AS3:DONE                 m_globals["chancesStatic"] = Macros.formatWinChancesText(true, false);
// AS3:DONE                 m_globals["chancesLive"] = function(o:Object) { return Macros.formatWinChancesText(false, true); }
// AS3:DONE                 break;
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function _RegisterZoomIndicatorData(zoom:Number)
// AS3:DONE     {
// AS3:DONE         // {{zoom}}
// AS3:DONE         m_globals["zoom"] = zoom;
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     /**
// AS3:DONE      * Register minimal macros values for player
// AS3:DONE      * @param pname plain player name without extra tags (clan, region, etc)
// AS3:DONE      * @param playerId player id
// AS3:DONE      * @param fullPlayerName full player name with extra tags (clan, region, etc)
// AS3:DONE      */
// AS3:DONE     private function _RegisterMinimalMacrosData(pname:String, playerId:Number, fullPlayerName:String, team:Number)
// AS3:DONE     {
// AS3:DONE         if (!Config.config)
// AS3:DONE             return;
// AS3:DONE         if (!m_dict.hasOwnProperty(pname))
// AS3:DONE             m_dict[pname] = { };
// AS3:DONE         var pdata = m_dict[pname];
// AS3:DONE
// AS3:DONE         if (!pdata.hasOwnProperty("name"))
// AS3:DONE         {
// AS3:DONE             m_playerId_to_pname[playerId] = pname;
// AS3:DONE             var name:String = getCustomPlayerName(pname, playerId);
// AS3:DONE             var clanIdx:Number = name.indexOf("[");
// AS3:DONE             if (clanIdx > 0)
// AS3:DONE             {
// AS3:DONE                 fullPlayerName = name;
// AS3:DONE                 name = Strings.trim(name.slice(0, clanIdx));
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             var clanWithoutBrackets:String = Utils.GetClanNameWithoutBrackets(fullPlayerName);
// AS3:DONE             var clanWithBrackets:String = Utils.GetClanNameWithBrackets(fullPlayerName);
// AS3:DONE
// AS3:DONE             // {{nick}}
// AS3:DONE             pdata["nick"] = name + (clanWithBrackets || "");
// AS3:DONE             // {{name}}
// AS3:DONE             pdata["name"] = name;
// AS3:DONE             // {{clan}}
// AS3:DONE             pdata["clan"] = clanWithBrackets;
// AS3:DONE             // {{clannb}}
// AS3:DONE             pdata["clannb"] = clanWithoutBrackets;
// AS3:DONE             // {{ally}}
// AS3:DONE             pdata["ally"] = team == Defines.TEAM_ALLY ? 'ally' : null;
// AS3:DONE
// AS3:DONE             // xmqp events macros
// AS3:DONE
// AS3:DONE             if (Config.networkServicesSettings.xmqp)
// AS3:DONE             {
// AS3:DONE                 // {{x-enabled}}
// AS3:DONE                 pdata["x-enabled"] = function(o) { return o.x_enabled == true ? 'true' : null; }
// AS3:DONE                 // {{x-sense-on}}
// AS3:DONE                 pdata["x-sense-on"] = function(o) { return o.x_sense_on == true ? 'true' : null; }
// AS3:DONE                 // {{x-fire}}
// AS3:DONE                 pdata["x-fire"] = function(o) { return o.x_fire == true ? 'true' : null; }
// AS3:DONE                 // {{x-overturned}}
// AS3:DONE                 pdata["x-overturned"] = function(o) { return o.x_overturned == true ? 'true' : null; }
// AS3:DONE                 // {{x-drowning}}
// AS3:DONE                 pdata["x-drowning"] = function(o) { return o.x_drowning == true ? 'true' : null; }
// AS3:DONE                 // {{x-spotted}}
// AS3:DONE                 pdata["x-spotted"] = function(o) { return o.x_spotted == true ? 'true' : null; }
// AS3:DONE             }
// AS3:DONE             else
// AS3:DONE             {
// AS3:DONE                 pdata["x-enabled"] = null;
// AS3:DONE                 pdata["x-sense-on"] = null;
// AS3:DONE                 pdata["x-fire"] = null;
// AS3:DONE                 pdata["x-overturned"] = null;
// AS3:DONE                 pdata["x-drowning"] = null;
// AS3:DONE                 pdata["x-spotted"] = null;
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     private function _RegisterPlayerData(pname:String, data:Object, team:Number)
// AS3:DONE     {
// AS3:DONE         if (!Config.config)
// AS3:DONE             return;
// AS3:DONE         if (!data)
// AS3:DONE             return;
// AS3:DONE         if (!m_dict.hasOwnProperty(pname))
// AS3:DONE             m_dict[pname] = { };
// AS3:DONE         var pdata = m_dict[pname];
// AS3:DONE
// AS3:DONE         //Logger.addObject(data);
// AS3:DONE
// AS3:DONE         // Static macros
// AS3:DONE
// AS3:DONE         // player name
// AS3:DONE         var fullPlayerName:String = data.label;
// AS3:DONE         var idx:Number = fullPlayerName.indexOf("[");
// AS3:DONE         if (idx < 0 && data.clanAbbrev != null && data.clanAbbrev != "")
// AS3:DONE             fullPlayerName += "[" + data.clanAbbrev + "]";
// AS3:DONE         _RegisterMinimalMacrosData(pname, data.uid, fullPlayerName, team);
// AS3:DONE
// AS3:DONE         if (!pdata.hasOwnProperty("player"))
// AS3:DONE         {
// AS3:DONE             // {{player}}
// AS3:DONE             pdata["player"] = data.himself == true ? "pl" : null;
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         // vehicle
// AS3:DONE         if (!pdata.hasOwnProperty("veh-id") || pdata["veh-id"] != data.vid)
// AS3:DONE         {
// AS3:DONE             var vdata:VehicleData = VehicleInfo.get(data.vid);
// AS3:DONE             if (vdata != null)
// AS3:DONE             {
// AS3:DONE                 if (!m_globals["maxhp"] || m_globals["maxhp"] < vdata.hpTop)
// AS3:DONE                     m_globals["maxhp"] = vdata.hpTop;
// AS3:DONE                 // {{veh-id}}
// AS3:DONE                 pdata["veh-id"] = vdata.vid;
// AS3:DONE                 // {{vehicle}} - Chaffee
// AS3:DONE                 pdata["vehicle"] = vdata.localizedName;
// AS3:DONE                 // {{vehiclename}} - usa-M24_Chaffee
// AS3:DONE                 pdata["vehiclename"] = VehicleInfo.getVIconName(vdata.key);
// AS3:DONE                 // {{vehicle-short}} - Chaff
// AS3:DONE                 pdata["vehicle-short"] = vdata.shortName || vdata.localizedName;
// AS3:DONE                 // {{vtype-key}} - MT
// AS3:DONE                 pdata["vtype-key"] = vdata.vtype;
// AS3:DONE                 // {{vtype}}
// AS3:DONE                 pdata["vtype"] = VehicleInfo.getVTypeText(vdata.vtype);
// AS3:DONE                 // {{vtype-l}} - Medium Tank
// AS3:DONE                 pdata["vtype-l"] = Locale.get(vdata.vtype);
// AS3:DONE                 // {{c:vtype}}
// AS3:DONE                 pdata["c:vtype"] = GraphicsUtil.GetVTypeColorValue(vdata.vid);
// AS3:DONE                 // {{battletier-min}}
// AS3:DONE                 pdata["battletier-min"] = vdata.tierLo;
// AS3:DONE                 // {{battletier-max}}
// AS3:DONE                 pdata["battletier-max"] = vdata.tierHi;
// AS3:DONE                 // {{nation}}
// AS3:DONE                 pdata["nation"] = vdata.nation;
// AS3:DONE                 // {{level}}
// AS3:DONE                 pdata["level"] = vdata.level;
// AS3:DONE                 // {{rlevel}}
// AS3:DONE                 pdata["rlevel"] = Defines.ROMAN_LEVEL[vdata.level - 1];
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         // squad
// AS3:DONE         if (!pdata.hasOwnProperty("squad") && data.hasOwnProperty("squad"))
// AS3:DONE         {
// AS3:DONE             // {{squad}}
// AS3:DONE             pdata["squad"] = function(o) { return o.squad > 10 ? "sq" : null; }
// AS3:DONE         }
// AS3:DONE
// AS3:DONE         // Dynamic macros
// AS3:DONE
// AS3:DONE         if (!pdata.hasOwnProperty("hp"))
// AS3:DONE         {
// AS3:DONE             // {{frags}}
// AS3:DONE             pdata["frags"] = function(o):Number { return isNaN(o.frags) || o.frags == 0 ? NaN : o.frags; }
// AS3:DONE             // {{ready}}
// AS3:DONE             pdata["ready"] = function(o):String { return o.ready == true ? 'ready' : null; }
// AS3:DONE             // {{alive}}
// AS3:DONE             pdata["alive"] = function(o):String { return o.dead == true ? null : 'alive'; }
// AS3:DONE             // {{tk}}
// AS3:DONE             pdata["tk"] = function(o):String { return o.teamKiller == true ? 'tk' : null; }
// AS3:DONE             // {{marksOnGun}}
// AS3:DONE             pdata["marksOnGun"] = function(o):String { return isNaN(o.marksOnGun) || pdata["level"] < 5 ? null : Utils.getMarksOnGunText(o.marksOnGun); }
// AS3:DONE
// AS3:DONE             if (Config.config.battle.allowSpottedStatus)
// AS3:DONE             {
// AS3:DONE                 var vdata:VehicleData = VehicleInfo.get(pdata["veh-id"]);
// AS3:DONE                 var isArty:Boolean = (vdata != null && vdata.vclass == "SPG");
// AS3:DONE                 // {{spotted}}
// AS3:DONE                 pdata["spotted"] = function(o):String { return Utils.getSpottedText(o.dead ? "dead" : o.spotted == null ? "neverSeen" : o.spotted, isArty); }
// AS3:DONE                 // {{c:spotted}}
// AS3:DONE                 pdata["c:spotted"] = function(o):String { return GraphicsUtil.GetSpottedColorValue(o.dead ? "dead" : o.spotted == null ? "neverSeen" : o.spotted, isArty); }
// AS3:DONE                 // {{a:spotted}}
// AS3:DONE                 pdata["a:spotted"] = function(o):Number { return GraphicsUtil.GetSpottedAlphaValue(o.dead ? "dead" : o.spotted == null ? "neverSeen" : o.spotted, isArty); }
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             // {{selected}}
// AS3:DONE             pdata["selected"] = function(o):String { return o.selected == true ? 'sel' : null; }
// AS3:DONE             // {{position}}
// AS3:DONE             pdata["position"] = function(o):String { return o.position <= 0 ? NaN : o.position; }
// AS3:DONE
// AS3:DONE             // hp
// AS3:DONE
// AS3:DONE             // {{hp}}
// AS3:DONE             pdata["hp"] = function(o):Number { return isNaN(o.curHealth) ? NaN : o.curHealth; }
// AS3:DONE             // {{hp-max}}
// AS3:DONE             var getMaxHealth:Function = function(o):Number { return isNaN(o.maxHealth) ? data.maxHealth : o.maxHealth; };
// AS3:DONE             pdata["hp-max"] = getMaxHealth;
// AS3:DONE             // {{hp-ratio}}
// AS3:DONE             pdata["hp-ratio"] = function(o):Number { return isNaN(o.curHealth) ? NaN : Math.round(o.curHealth / getMaxHealth(o) * 100); }
// AS3:DONE             // {{c:hp}}
// AS3:DONE             pdata["c:hp"] = function(o):String { return (isNaN(o.curHealth) && !o.dead) ? null : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, o.curHealth || 0); }
// AS3:DONE             // {{c:hp-ratio}}
// AS3:DONE             pdata["c:hp-ratio"] = function(o):String { return (isNaN(o.curHealth) && !o.dead) ? null : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO,
// AS3:DONE                 isNaN(o.curHealth) ? 0 : o.curHealth / getMaxHealth(o) * 100); }
// AS3:DONE             // {{a:hp}}
// AS3:DONE             pdata["a:hp"] = function(o):Number { return (isNaN(o.curHealth) && !o.dead) ? NaN : GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, o.curHealth || 0); }
// AS3:DONE             // {{a:hp-ratio}}
// AS3:DONE             pdata["a:hp-ratio"] = function(o):Number { return (isNaN(o.curHealth) && !o.dead) ? NaN : GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO,
// AS3:DONE                 isNaN(o.curHealth) ? 0 : o.curHealth / getMaxHealth(o) * 100); }
// AS3:DONE
// AS3:DONE             // dmg
// AS3:DONE
// AS3:DONE             // {{dmg}}
// AS3:DONE             pdata["dmg"] = function(o):Number { return isNaN(o.delta) ? NaN : o.delta; }
// AS3:DONE             // {{dmg-ratio}}
// AS3:DONE             pdata["dmg-ratio"] = function(o):Number { return isNaN(o.delta) ? NaN : Math.round(o.delta / getMaxHealth(o) * 100); }
// AS3:DONE             // {{dmg-kind}}
// AS3:DONE             pdata["dmg-kind"] = function(o):String { return o.damageType == null ? null : Locale.get(o.damageType); }
// AS3:DONE             // {{c:dmg}}
// AS3:DONE             pdata["c:dmg"] = function(o):String
// AS3:DONE             {
// AS3:DONE                 //Logger.addObject(o);
// AS3:DONE                 //Logger.addObject(data);
// AS3:DONE                 if (isNaN(o.delta))
// AS3:DONE                     return null;
// AS3:DONE                 switch (o.damageType)
// AS3:DONE                 {
// AS3:DONE                     case "world_collision":
// AS3:DONE                     case "death_zone":
// AS3:DONE                     case "drowning":
// AS3:DONE                         return GraphicsUtil.GetDmgKindValue(o.damageType);
// AS3:DONE                     default:
// AS3:DONE                         return GraphicsUtil.GetDmgSrcValue(
// AS3:DONE                             Utils.damageFlagToDamageSource(o.damageFlag),
// AS3:DONE                             o.teamKiller ? ((team == Defines.TEAM_ALLY ? "ally" : "enemy") + "tk") : o.entityName,
// AS3:DONE                             o.dead, o.blowedUp);
// AS3:DONE                 }
// AS3:DONE             }
// AS3:DONE             // {{c:dmg-kind}}
// AS3:DONE             pdata["c:dmg-kind"] = function(o):String { return o.damageType == null ? null : GraphicsUtil.GetDmgKindValue(o.damageType); }
// AS3:DONE
// AS3:DONE             // {{sys-color-key}}
// AS3:DONE             pdata["sys-color-key"] = function(o):String
// AS3:DONE             {
// AS3:DONE                 return ColorsManager.getSystemColorKey(o.entityName, o.dead, o.blowedUp);
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             // {{c:system}}
// AS3:DONE             pdata["c:system"] = function(o):String
// AS3:DONE             {
// AS3:DONE                 return "#" + Strings.padLeft(ColorsManager.getSystemColor(o.entityName, o.dead, o.blowedUp).toString(16), 6, "0");
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             // hitlog
// AS3:DONE
// AS3:DONE             // {{dead}}
// AS3:DONE             pdata["dead"] = function(o):String
// AS3:DONE             {
// AS3:DONE                 return o.curHealth < 0
// AS3:DONE                     ? Config.config.hitLog.blowupMarker
// AS3:DONE                     : (o.curHealth == 0 || o.dead) ? Config.config.hitLog.deadMarker : null;
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             // {{n}}
// AS3:DONE             pdata["n"] = function(o):Number { return o.global.hits.length }
// AS3:DONE
// AS3:DONE             // {{dmg-total}}
// AS3:DONE             pdata["dmg-total"] = function(o):Number { return o.global.total }
// AS3:DONE
// AS3:DONE             // {{c:dmg-total}}
// AS3:DONE             pdata["c:dmg-total"] = function(o):String
// AS3:DONE             {
// AS3:DONE                 var v_array_xtdb_len:Number = Config.v_array_xtdb.length;
// AS3:DONE                 if (this.curent_xtdb < (v_array_xtdb_len - 1))
// AS3:DONE                 {
// AS3:DONE                     for (var i:Number = this.curent_xtdb; i < v_array_xtdb_len; ++i)
// AS3:DONE                     {
// AS3:DONE                         if ((o.global.total < Config.v_array_xtdb[i])||(i == (v_array_xtdb_len - 1)))
// AS3:DONE                         {
// AS3:DONE                             this.curent_xtdb = i;
// AS3:DONE                             return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, i, "#", false);
// AS3:DONE                         }
// AS3:DONE                     }
// AS3:DONE                 }
// AS3:DONE                 else
// AS3:DONE                 {
// AS3:DONE                     return GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, (v_array_xtdb_len - 1), "#", false);
// AS3:DONE                 }
// AS3:DONE             }
// AS3:DONE
// AS3:DONE             // {{dmg-avg}}
// AS3:DONE             pdata["dmg-avg"] = function(o):Number { return o.global.hits.length == 0 ? 0 : Math.round(o.global.total / o.global.hits.length); }
// AS3:DONE
// AS3:DONE             // {{n-player}}
// AS3:DONE             pdata["n-player"] = function(o):Number { return o.hits.length };
// AS3:DONE
// AS3:DONE             // {{dmg-player}}
// AS3:DONE             pdata["dmg-player"] = function(o):Number { return o.total };
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     private function _RegisterStatisticsMacros(pname:String, stat:StatData)
// AS3:DONE     {
// AS3:DONE         //Logger.addObject(stat);
// AS3:DONE 
// AS3:DONE         if (!stat)
// AS3:DONE             return;
// AS3:DONE         if (!m_dict.hasOwnProperty(pname))
// AS3:DONE             m_dict[pname] = { };
// AS3:DONE         var pdata = m_dict[pname];
// AS3:DONE 
// AS3:DONE         // Register contacts data
// AS3:DONE         //Logger.addObject(stat, 2);
// AS3:DONE         delete m_macros_cache[pname];
// AS3:DONE         delete pdata["name"];
// AS3:DONE         m_contacts[String(stat._id)] = stat.xvm_contact_data;
// AS3:DONE         _RegisterMinimalMacrosData(pname, stat._id, stat.name + (stat.clan == null || stat.clan == "" ? "" : "[" + stat.clan + "]"), stat.team);
// AS3:DONE 
// AS3:DONE         // {{region}}
// AS3:DONE         pdata["region"] = Config.config.region;
// AS3:DONE 
// AS3:DONE         // {{squad-num}}
// AS3:DONE         pdata["squad-num"] = function(o) { return o.squad > 10 ? o.squad - 10 : o.squad > 0 ? o.squad : null; }
// AS3:DONE         // {{xvm-user}}
// AS3:DONE         pdata["xvm-user"] = Utils.getXvmUserText(stat.status);
// AS3:DONE         // {{flag}}
// AS3:DONE         pdata["flag"] = stat.flag;
// AS3:DONE         // {{clanrank}}
// AS3:DONE         pdata["clanrank"] = isNaN(stat.rank) ? null : stat.rank == 0 ? "persist" : String(stat.rank);
// AS3:DONE         // {{topclan}}
// AS3:DONE         pdata["topclan"] = Utils.getTopClanText(stat.rank);
// AS3:DONE 
// AS3:DONE         // {{avglvl}}
// AS3:DONE         pdata["avglvl"] = stat.lvl;
// AS3:DONE         // {{xte}}
// AS3:DONE         pdata["xte"] = isNaN(stat.v.xte) || stat.v.xte <= 0 ? null : stat.v.xte == 100 ? "XX" : (stat.v.xte < 10 ? "0" : "") + stat.v.xte;
// AS3:DONE         // {{xeff}}
// AS3:DONE         pdata["xeff"] = isNaN(stat.xeff) ? null : stat.xeff == 100 ? "XX" : (stat.xeff < 10 ? "0" : "") + stat.xeff;
// AS3:DONE         // {{xwn6}}
// AS3:DONE         pdata["xwn6"] = isNaN(stat.xwn6) ? null : stat.xwn6 == 100 ? "XX" : (stat.xwn6 < 10 ? "0" : "") + stat.xwn6;
// AS3:DONE         // {{xwn8}}
// AS3:DONE         pdata["xwn8"] = isNaN(stat.xwn8) ? null : stat.xwn8 == 100 ? "XX" : (stat.xwn8 < 10 ? "0" : "") + stat.xwn8;
// AS3:DONE         // {{xwn}}
// AS3:DONE         pdata["xwn"] = pdata["xwn8"];
// AS3:DONE         // {{xwgr}}
// AS3:DONE         pdata["xwgr"] = isNaN(stat.xwgr) ? null : stat.xwgr == 100 ? "XX" : (stat.xwgr < 10 ? "0" : "") + stat.xwgr;
// AS3:DONE         // {{eff}}
// AS3:DONE         pdata["eff"] = isNaN(stat.e) ? null : Math.round(stat.e);
// AS3:DONE         // {{wn6}}
// AS3:DONE         pdata["wn6"] = isNaN(stat.wn6) ? null : Math.round(stat.wn6);
// AS3:DONE         // {{wn8}}
// AS3:DONE         pdata["wn8"] = isNaN(stat.wn8) ? null : Math.round(stat.wn8);
// AS3:DONE         // {{wn}}
// AS3:DONE         pdata["wn"] = pdata["wn8"];
// AS3:DONE         // {{wgr}}
// AS3:DONE         pdata["wgr"] = isNaN(stat.wgr) ? null : Math.round(stat.wgr);
// AS3:DONE         // {{r}}
// AS3:DONE         pdata["r"] = getRating(pdata, "", "");
// AS3:DONE         // {{xr}}
// AS3:DONE         pdata["xr"] = getRating(pdata, "", "", "xvm");
// AS3:DONE 
// AS3:DONE         // {{winrate}}
// AS3:DONE         pdata["winrate"] = stat.winrate;
// AS3:DONE         // {{rating}} (obsolete)
// AS3:DONE         pdata["rating"] = pdata["winrate"];
// AS3:DONE         // {{battles}}
// AS3:DONE         pdata["battles"] = stat.b;
// AS3:DONE         // {{wins}}
// AS3:DONE         pdata["wins"] = stat.b;
// AS3:DONE         // {{kb}}
// AS3:DONE         pdata["kb"] = stat.b / 1000;
// AS3:DONE 
// AS3:DONE         // {{t-winrate}}
// AS3:DONE         pdata["t-winrate"] = stat.v.winrate;
// AS3:DONE         // {{t-rating}} (obsolete)
// AS3:DONE         pdata["t-rating"] = pdata["t-winrate"];
// AS3:DONE         // {{t-battles}}
// AS3:DONE         pdata["t-battles"] = stat.v.b;
// AS3:DONE         // {{t-wins}}
// AS3:DONE         pdata["t-wins"] = stat.v.w;
// AS3:DONE         // {{t-kb}}
// AS3:DONE         pdata["t-kb"] = stat.v.b / 1000;
// AS3:DONE         // {{t-hb}}
// AS3:DONE         pdata["t-hb"] = stat.v.b / 100.0;
// AS3:DONE         // {{tdb}}
// AS3:DONE         pdata["tdb"] = stat.v.db;
// AS3:DONE         // {{xtdb}}
// AS3:DONE         pdata["xtdb"] = isNaN(stat.v.xtdb) || stat.v.xtdb <= 0 ? null : stat.v.xtdb == 100 ? "XX" : (stat.v.xtdb < 10 ? "0" : "") + stat.v.xtdb;
// AS3:DONE         // {{tdv}}
// AS3:DONE         pdata["tdv"] = stat.v.dv;
// AS3:DONE         // {{tfb}}
// AS3:DONE         pdata["tfb"] = stat.v.fb;
// AS3:DONE         // {{tsb}}
// AS3:DONE         pdata["tsb"] = stat.v.sb;
// AS3:DONE 
// AS3:DONE         // Dynamic colors
// AS3:DONE         // {{c:xte}}
// AS3:DONE         pdata["c:xte"] =   isNaN(stat.v.xte) || stat.v.xte <= 0 ? null : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.v.xte, "#", false);
// AS3:DONE         pdata["c:xte#d"] = isNaN(stat.v.xte) || stat.v.xte <= 0 ? null : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.v.xte, "#", true);
// AS3:DONE         // {{c:xeff}}
// AS3:DONE         pdata["c:xeff"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xeff, "#", false);
// AS3:DONE         pdata["c:xeff#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xeff, "#", true);
// AS3:DONE         // {{c:xwn6}}
// AS3:DONE         pdata["c:xwn6"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn6, "#", false);
// AS3:DONE         pdata["c:xwn6#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn6, "#", true);
// AS3:DONE         // {{c:xwn8}}
// AS3:DONE         pdata["c:xwn8"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn8, "#", false);
// AS3:DONE         pdata["c:xwn8#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn8, "#", true);
// AS3:DONE         // {{c:xwn}}
// AS3:DONE         pdata["c:xwn"] = pdata["c:xwn8"];
// AS3:DONE         pdata["c:xwn#d"] = pdata["c:xwn8#d"];
// AS3:DONE         // {{c:xwgr}}
// AS3:DONE         pdata["c:xwgr"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwgr, "#", false);
// AS3:DONE         pdata["c:xwgr#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwgr, "#", true);
// AS3:DONE         // {{c:eff}}
// AS3:DONE         pdata["c:eff"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, stat.e, "#", false);
// AS3:DONE         pdata["c:eff#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, stat.e, "#", true);
// AS3:DONE         // {{c:wn6}}
// AS3:DONE         pdata["c:wn6"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN6, stat.wn6, "#", false);
// AS3:DONE         pdata["c:wn6#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN6, stat.wn6, "#", true);
// AS3:DONE         // {{c:wn8}}
// AS3:DONE         pdata["c:wn8"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, stat.wn8, "#", false);
// AS3:DONE         pdata["c:wn8#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, stat.wn8, "#", true);
// AS3:DONE         // {{c:wn}}
// AS3:DONE         pdata["c:wn"] =   pdata["c:wn8"];
// AS3:DONE         pdata["c:wn#d"] = pdata["c:wn8#d"];
// AS3:DONE         // {{c:wgr}}
// AS3:DONE         pdata["c:wgr"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WGR, stat.wgr, "#", false);
// AS3:DONE         pdata["c:wgr#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WGR, stat.wgr, "#", true);
// AS3:DONE         // {{c:r}}
// AS3:DONE         pdata["c:r"] = getRating(pdata, "c:", "");
// AS3:DONE         pdata["c:r#d"] = getRating(pdata, "c:", "#d");
// AS3:DONE         // {{c:xr}}
// AS3:DONE         pdata["c:xr"] = getRating(pdata, "c:", "", "xvm");
// AS3:DONE         pdata["c:xr#d"] = getRating(pdata, "c:", "#d", "xvm");
// AS3:DONE 
// AS3:DONE         // {{c:winrate}}
// AS3:DONE         pdata["c:winrate"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.winrate, "#", false);
// AS3:DONE         pdata["c:winrate#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.winrate, "#", true);
// AS3:DONE         // {{c:rating}} (obsolete)
// AS3:DONE         pdata["c:rating"] =   pdata["c:winrate"];
// AS3:DONE         pdata["c:rating#d"] = pdata["c:winrate#d"];
// AS3:DONE         // {{c:kb}}
// AS3:DONE         pdata["c:kb"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, stat.b / 1000, "#", false);
// AS3:DONE         pdata["c:kb#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, stat.b / 1000, "#", true);
// AS3:DONE         // {{c:avglvl}}
// AS3:DONE         pdata["c:avglvl"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_AVGLVL, stat.lvl, "#", false);
// AS3:DONE         pdata["c:avglvl#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_AVGLVL, stat.lvl, "#", true);
// AS3:DONE         // {{c:t-winrate}}
// AS3:DONE         pdata["c:t-winrate"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.v.winrate, "#", false);
// AS3:DONE         pdata["c:t-winrate#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.v.winrate, "#", true);
// AS3:DONE         // {{c:t-rating}} (obsolete)
// AS3:DONE         pdata["c:t-rating"] =   pdata["c:t-winrate"];
// AS3:DONE         pdata["c:t-rating#d"] = pdata["c:t-winrate#d"];
// AS3:DONE         // {{c:t-battles}}
// AS3:DONE         pdata["c:t-battles"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, stat.v.b, "#", false);
// AS3:DONE         pdata["c:t-battles#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, stat.v.b, "#", true);
// AS3:DONE         // {{c:tdb}}
// AS3:DONE         pdata["c:tdb"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, stat.v.db, "#", false);
// AS3:DONE         pdata["c:tdb#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, stat.v.db, "#", true);
// AS3:DONE         // {{c:xtdb}}
// AS3:DONE         pdata["c:xtdb"] =   isNaN(stat.v.xtdb) || stat.v.xtdb <= 0 ? null : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.v.xtdb, "#", false);
// AS3:DONE         pdata["c:xtdb#d"] = isNaN(stat.v.xtdb) || stat.v.xtdb <= 0 ? null : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.v.xtdb, "#", true);
// AS3:DONE         // {{c:tdv}}
// AS3:DONE         pdata["c:tdv"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, stat.v.dv, "#", false);
// AS3:DONE         pdata["c:tdv#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, stat.v.dv, "#", true);
// AS3:DONE         // {{c:tfb}}
// AS3:DONE         pdata["c:tfb"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, stat.v.fb, "#", false);
// AS3:DONE         pdata["c:tfb#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, stat.v.fb, "#", true);
// AS3:DONE         // {{c:tsb}}
// AS3:DONE         pdata["c:tsb"] =   GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, stat.v.sb, "#", false);
// AS3:DONE         pdata["c:tsb#d"] = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, stat.v.sb, "#", true);
// AS3:DONE 
// AS3:DONE         // Alpha
// AS3:DONE         // {{a:xte}}
// AS3:DONE         pdata["a:xte"] = isNaN(stat.v.xte) || stat.v.xte <= 0 ? NaN : GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.v.xte);
// AS3:DONE         // {{a:xeff}}
// AS3:DONE         pdata["a:xeff"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xeff);
// AS3:DONE         // {{a:xwn6}}
// AS3:DONE         pdata["a:xwn6"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn6);
// AS3:DONE         // {{a:xwn8}}
// AS3:DONE         pdata["a:xwn8"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn8);
// AS3:DONE         // {{a:xwn}}
// AS3:DONE         pdata["a:xwn"] = pdata["a:xwn8"];
// AS3:DONE         // {{a:xwgr}}
// AS3:DONE         pdata["a:xwgr"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwgr);
// AS3:DONE         // {{a:eff}}
// AS3:DONE         pdata["a:eff"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_EFF, stat.e);
// AS3:DONE         // {{a:wn6}}
// AS3:DONE         pdata["a:wn6"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN6, stat.wn6);
// AS3:DONE         // {{a:wn8}}
// AS3:DONE         pdata["a:wn8"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN8, stat.wn8);
// AS3:DONE         // {{a:wn}}
// AS3:DONE         pdata["a:wn"] = pdata["a:wn8"];
// AS3:DONE         // {{a:wgr}}
// AS3:DONE         pdata["a:wgr"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WGR, stat.wgr);
// AS3:DONE         // {{a:r}}
// AS3:DONE         pdata["a:r"] = getRating(pdata, "a:", "");
// AS3:DONE         // {{a:xr}}
// AS3:DONE         pdata["a:xr"] = getRating(pdata, "a:", "", "xvm");
// AS3:DONE 
// AS3:DONE         // {{a:winrate}}
// AS3:DONE         pdata["a:winrate"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WINRATE, stat.winrate);
// AS3:DONE         // {{a:rating}} (obsolete)
// AS3:DONE         pdata["a:rating"] = pdata["a:winrate"];
// AS3:DONE         // {{a:kb}}
// AS3:DONE         pdata["a:kb"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_KB, stat.b / 1000);
// AS3:DONE         // {{a:avglvl}}
// AS3:DONE         pdata["a:avglvl"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_AVGLVL, stat.lvl);
// AS3:DONE         // {{a:t-winrate}}
// AS3:DONE         pdata["a:t-winrate"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WINRATE, stat.v.winrate);
// AS3:DONE         // {{a:t-rating}} (obsolete)
// AS3:DONE         pdata["a:t-rating"] = pdata["a:t-winrate"];
// AS3:DONE         // {{a:t-battles}}
// AS3:DONE         pdata["a:t-battles"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TBATTLES, stat.v.b);
// AS3:DONE         // {{a:tdb}}
// AS3:DONE         pdata["a:tdb"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TDB, stat.v.db);
// AS3:DONE         // {{a:xtdb}}
// AS3:DONE         pdata["a:xtdb"] = isNaN(stat.v.xtdb) || stat.v.xtdb <= 0 ? NaN : GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.v.xtdb);
// AS3:DONE         // {{a:tdv}}
// AS3:DONE         pdata["a:tdv"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TDV, stat.v.dv);
// AS3:DONE         // {{a:tfb}}
// AS3:DONE         pdata["a:tfb"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TFB, stat.v.fb);
// AS3:DONE         // {{a:tsb}}
// AS3:DONE         pdata["a:tsb"] = GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_TSB, stat.v.sb);
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     private function _RegisterMarkerData(pname:String, data:Object)
// AS3:DONE     {
// AS3:DONE         //Logger.addObject(data);
// AS3:DONE 
// AS3:DONE         if (!data)
// AS3:DONE             return;
// AS3:DONE         if (!m_dict.hasOwnProperty(pname))
// AS3:DONE             m_dict[pname] = { };
// AS3:DONE         var pdata = m_dict[pname];
// AS3:DONE 
// AS3:DONE         // {{turret}}
// AS3:DONE         pdata["turret"] = data.turret || "";
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     // PRIVATE
// AS3:DONE 
// AS3:DONE     private function getCustomPlayerName(pname:String, uid:Number):String
// AS3:DONE     {
// AS3:DONE         //Logger.add(pname + " " + uid);
// AS3:DONE         switch (Config.config.region)
// AS3:DONE         {
// AS3:DONE             case "RU":
// AS3:DONE                 if (pname == "www_modxvm_com")
// AS3:DONE                     return "www.modxvm.com";
// AS3:DONE                 if (pname == "M_r_A")
// AS3:DONE                     return "Флаттершай - лучшая пони!";
// AS3:DONE                 if (pname == "sirmax2" || pname == "0x01" || pname == "_SirMax_")
// AS3:DONE                     return "«сэр Макс» (XVM)";
// AS3:DONE                 if (pname == "Mixailos")
// AS3:DONE                     return "Михаил";
// AS3:DONE                 if (pname == "STL1te")
// AS3:DONE                     return "О, СТЛайт!";
// AS3:DONE                 if (pname == "seriych")
// AS3:DONE                     return "Всем Счастья :)";
// AS3:DONE                 if (pname == "XIebniDizele4ky" || pname == "Xlebni_Dizele4ky" || pname == "XlebniDizeIe4ku" || pname == "XlebniDize1e4ku" || pname == "XlebniDizele4ku_2013")
// AS3:DONE                     return "Alex Artobanana";
// AS3:DONE                 break;
// AS3:DONE 
// AS3:DONE             case "CT":
// AS3:DONE                 if (pname == "www_modxvm_com_RU")
// AS3:DONE                     return "www.modxvm.com";
// AS3:DONE                 if (pname == "M_r_A_RU" || pname == "M_r_A_EU")
// AS3:DONE                     return "Fluttershy is best pony!";
// AS3:DONE                 if (pname == "sirmax2_RU" || pname == "sirmax2_EU" || pname == "sirmax_NA" || pname == "0x01_RU" || pname == "0x01_EU")
// AS3:DONE                     return "«sir Max» (XVM)";
// AS3:DONE                 if (pname == "seriych_RU")
// AS3:DONE                     return "Be Happy :)";
// AS3:DONE                 break;
// AS3:DONE 
// AS3:DONE             case "EU":
// AS3:DONE                 if (pname == "M_r_A")
// AS3:DONE                     return "Fluttershy is best pony!";
// AS3:DONE                 if (pname == "sirmax2" || pname == "0x01" || pname == "_SirMax_")
// AS3:DONE                     return "«sir Max» (XVM)";
// AS3:DONE                 if (pname == "seriych")
// AS3:DONE                     return "Be Happy :)";
// AS3:DONE                 break;
// AS3:DONE 
// AS3:DONE             case "US":
// AS3:DONE                 if (pname == "sirmax" || pname == "0x01" || pname == "_SirMax_")
// AS3:DONE                     return "«sir Max» (XVM)";
// AS3:DONE                 break;
// AS3:DONE         }
// AS3:DONE 
// AS3:DONE         if (m_contacts != null && !isNaN(uid) && uid > 0)
// AS3:DONE         {
// AS3:DONE             var cdata:Object = m_contacts[String(uid)];
// AS3:DONE             if (cdata != null)
// AS3:DONE             {
// AS3:DONE                 if (cdata.nick != null && cdata.nick != "")
// AS3:DONE                     pname = cdata.nick;
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE 
// AS3:DONE         return pname;
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     // rating
// AS3:DONE 
// AS3:DONE     private static var RATING_MATRIX:Object =
// AS3:DONE     {
// AS3:DONE         xvm_wgr:   { name: "xwgr", def: "--" },
// AS3:DONE         xvm_wn6:   { name: "xwn6", def: "--" },
// AS3:DONE         xvm_wn8:   { name: "xwn8", def: "--" },
// AS3:DONE         xvm_eff:   { name: "xeff", def: "--" },
// AS3:DONE         xvm_xte:   { name: "xte",  def: "--" },
// AS3:DONE         basic_wgr: { name: "wgr",  def: "-----" },
// AS3:DONE         basic_wn6: { name: "wn6",  def: "----" },
// AS3:DONE         basic_wn8: { name: "wn8",  def: "----" },
// AS3:DONE         basic_eff: { name: "eff",  def: "----" },
// AS3:DONE         basic_xte: { name: "xte",  def: "--" }
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     /**
// AS3:DONE      * Returns rating according settings in the personal cabinet
// AS3:DONE      */
// AS3:DONE     private static function getRating(pdata:Object, prefix:String, suffix:String, scale:String)
// AS3:DONE     {
// AS3:DONE         var name:String = _getRatingName(scale);
// AS3:DONE         var value = pdata[prefix + RATING_MATRIX[name].name + suffix];
// AS3:DONE         if (prefix != "" || value == null)
// AS3:DONE             return value;
// AS3:DONE         value = Strings.padLeft(String(value), getRatingDefaultValue(scale).length);
// AS3:DONE         return value;
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     /**
// AS3:DONE      * Returns default value for rating according settings in the personal cabinet
// AS3:DONE      */
// AS3:DONE     private static function getRatingDefaultValue(scale:String):String
// AS3:DONE     {
// AS3:DONE         var name:String = _getRatingName(scale);
// AS3:DONE         return RATING_MATRIX[name].def;
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     private static function _getRatingName(scale:String):String
// AS3:DONE     {
// AS3:DONE         var sc:String = (scale == null) ? Config.networkServicesSettings.scale : scale;
// AS3:DONE         var name:String = sc + "_" + Config.networkServicesSettings.rating;
// AS3:DONE         if (!RATING_MATRIX.hasOwnProperty(name))
// AS3:DONE             name = (scale != null ? scale : "basic") + "_wgr";
// AS3:DONE         return name;
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     private static function formatWinChancesText(isShowChance, isShowLiveChance: Boolean): String
// AS3:DONE     {
// AS3:DONE         if (!Config.networkServicesSettings.chance)
// AS3:DONE             return "";
// AS3:DONE         if (!Config.networkServicesSettings.chanceLive && isShowLiveChance)
// AS3:DONE         {
// AS3:DONE             return "";
// AS3:DONE         }
// AS3:DONE         var ChancesText: String = Chance.GetChanceText(true, false, true);
// AS3:DONE         var temp: Array = ChancesText.split('|', 2);
// AS3:DONE         var tempA: Array = temp[0].split(':', 2);
// AS3:DONE         if (isShowChance)
// AS3:DONE         {
// AS3:DONE             return tempA[1];
// AS3:DONE         }
// AS3:DONE         else if (isShowLiveChance)
// AS3:DONE         {
// AS3:DONE             var tempB: Array = temp[1].split(':', 2);
// AS3:DONE             return tempB[1];
// AS3:DONE         }
// AS3:DONE         else
// AS3:DONE         {
// AS3:DONE             return "";
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE }
