/**
 * XVM Localization module
 * @author Maxim Schedriviy <max(at)modxvm.com>
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 * @author Pavel Máca
 */
package com.xvm
{
    import com.xfw.*;
    import flash.events.*;

    public class Locale extends EventDispatcher
    {
        /////////////////////////////////////////////////////////////////
        // PUBLIC STATIC

        private static var _instance:Locale = null;
        public static function get Instance():Locale
        {
            if (_instance == null)
                _instance = new Locale();
            return _instance;
        }

        public static function LoadLocaleFile():void
        {
            Instance.setupLanguage(JSONxLoader.Load(Defines.XVM_L10N_DIR_NAME + Config.language + ".xc"));
        }

        public static function get(format:String):String
        {
            //Logger.add("Locale[get]: string: " + format + " | string: " + s_lang[format] + " | fallback string: " + s_lang_fallback[format]);
            if (s_lang && s_lang[format] != null)
                format = s_lang[format];
            else if (s_lang_fallback[format] != null)
                format = s_lang_fallback[format];

            /** each item in array begin with macro */
            var formatParts:Vector.<String> = Vector.<String>(format.split("{{" + MACRO_PREFIX + ":"));

            /** begin part until first macro start */
            var res:String = formatParts.shift();
            var len:int = formatParts.length;
            for (var i:int = 0; i < len; ++i)
            {
                /** "macro}} rest of text" */
                var part:String = formatParts[i];

                /** find macro end & make sure it contains at least 1 symbol */
                var macroEnd:Number = part.indexOf("}}", 1);
                if (macroEnd == -1) {
                    /** no end chars => write everythink back */
                    res += "{{" + MACRO_PREFIX + ":" + part;
                    continue;
                }

                var macro:String = part.slice(0, macroEnd);
                var stringParts:Array = macro.split(":");
                macro = stringParts[0];
                stringParts.shift();
                macro = Locale.get(macro);
                if (stringParts.length > 0)
                    macro = XfwUtils.substitute(macro, stringParts);
                res += macro;

                /** write rest of text after macro, without }} */
                res += part.slice(macroEnd + 2, part.length);
            }

            return res;
        }


        /////////////////////////////////////////////////////////////////
        // PRIVATE

        private static const MACRO_PREFIX:String = "l10n";

        /** Hardcoded RU language */
        private static const FALLBACK_RU:Object = {
            // Common
            "Warning": "Предупреждение",
            "Error": "Ошибка",
            "Information": "Информация",
            "OK": "OK",
            "Cancel": "Отмена",
            "Save": "Сохранить",
            "Remove": "Удалить",
            "Yes": "Да",
            "No": "Нет",

            // Ping
            "Initialization": "Инициализация",

            // Win chance
            "Chance error": "Ошибка расчета шансов",
            "Chance to win": "Шансы на победу",
            "Team strength": "Силы команд",
            //"global": "общий",
            //"per-vehicle": "по технике",
            "chanceLive": "Для живых",
            "chanceBattleTier": "Уровень боя",

            /* xvm-as2
            // Hitlog
            "shot": "атака",
            "fire": "пожар",
            "ramming": "таран",
            "world_collision": "падение",
            "death_zone": "death zone",
            "drowning": "drowning",
            "Hits": "Пробитий",
            "Total": "Всего",
            "Last": "Последний",

            // Hp Left
            "hpLeftTitle": "Осталось HP:",

            // Capture
            "enemyBaseCapture": "Захват базы{0} союзниками!",
            "enemyBaseCaptured": "База{0} захвачена союзниками!",
            "allyBaseCapture": "Захват базы{0} врагами!",
            "allyBaseCaptured": "База{0} захвачена врагами!",
            */

            // BattleResults
            "Hit percent": "Процент попаданий",
            "Damage (assisted / own)": "Урон (по разведданным / свой)",
            "BR_xpCrew": "экипажу",

            // TeamRenderers
            "Friend": "Друг",
            "Ignored": "Игнор",
            "unknown": "неизвестно",
            "Fights": "Боёв",
            "Wins": "Побед",
            "Data was updated at": "Данные были обновлены",
            "Load statistics": "Загрузить статистику",

            // Profile
            "General stats": "Общая статистика",
            "Summary": "Общие результаты",
            "Avg level": "Средний уровень",
            //"WN6": "WN6",
            //"WN8": "WN8",
            "EFF": "РЭ",
            "WGR": "ЛРИ",
            "updated": "обновлено",
            " to ": " до ",
            "avg": "ср.",
            "top": "топ",
            "draws": "ничьих",
            "Maximum damage": "Максимальный урон",
            "Specific damage (Avg dmg / HP)": "Уд. урон (ср. урон / прочность)",
            "Capture points": "Очки захвата",
            "Defence points": "Очки защиты",
            "Filter": "Фильтр",

            "Extra data (WoT 0.8.8+)": "Доп. данные (WoT 0.8.8+)",
            "Average battle time": "Среднее время жизни в бою",
            "Average battle time per day": "Среднее время игры в день",
            "Battles after 0.8.8": "Боев после 0.8.8",
            "Average experience": "Средний опыт",
            "Average experience without premium": "Средний опыт без премиума",
            "Average distance driven per battle": "В среднем пройдено км за бой",
            "Average woodcuts per battle": "В среднем повалено деревьев за бой",
            "Average damage assisted": "Средний урон с вашей помощью",
            "    by tracking": "    после сбития гусеницы",
            "    by spotting": "    по разведданным",
            "Average HE shells fired (splash)": "Средний урон фугасами (сплэш)",
            "Average HE shells received (splash)": "Средний полученный урон фугасами",
            "Average penetrations per battle": "В среднем пробитий за бой",
            "Average hits received": "В среднем получено попаданий",
            "Average penetrations received": "В среднем получено пробитий",
            "Average ricochets received": "В среднем получено рикошетов",

            // Crew
            "PutOwnCrew": "Родной экипаж",
            "PutBestCrew": "Лучший экипаж",
            "PutClassCrew": "Экипаж того же класса",
            "PutPreviousCrew": "Предыдущий экипаж",
            "DropAllCrew": "Высадить весь экипаж",
            "noSkills": "Нет умений",

            // Vehicle Params
            "gun_reload_time/actual": "Расчетное время перезарядки орудия",
            "view_range/base": "базовый",
            "view_range/actual": "расчетный",
            "view_range/stereoscope": "со стереотрубой",
            "radio_range/base": "базовая",
            "radio_range/actual": "расчетная",
            "shootingRadius": "Дальность стрельбы",
            "pitchLimits": "Углы ВН",
            "traverseLimits": "Углы ГН",
            "terrainResistance": "Сопротивление грунтов",
            "gravity": "Гравитация",
            "shellSpeed": "Скорость снаряда",
            "camoCoeff": "Коэффициенты маскировки",
            "(m/sec)": "(м/сек)",
            "(sec)": "(сек)",
            "(m)": "(м)",

            // Squad
            "Squad battle tiers": "Уровень боев взвода",
            "Vehicle": "Танк",
            "Battle tiers": "Уровень боёв",
            "Type": "Тип",
            "Nation": "Нация",
            "ussr": "СССР",
            "germany": "Германия",
            "usa": "США",
            "france": "Франция",
            "uk": "Великобритания",
            "china": "Китай",
            "japan": "Япония",
            "HT": "ТТ",
            "MT": "СТ",
            "LT": "ЛТ",
            "TD": "ПТ",
            "SPG": "САУ",

            // VehicleMarkersManager
            "blownUp": "Взрыв БК!",

            // Check version
            "ver/currentVersion": "XVM {0} ({1})", // XVM 5.3.4 (4321)
            "ver/newVersion": "Доступно обновление:<tab/><a href='#XVM_SITE_DL#'><font color='#00FF00'>v{0}</font></a>\n{1}",
            "websock/not_connected": "<font color='#FFFF00'>нет подключения к серверу XVM</font>",

            // token
            "token/services_unavailable": "Сетевые сервисы недоступны.&nbsp;&nbsp;<a href='#XVM_SITE_UNAVAILABLE#'><font size='11'>подробнее</font></a>",
            "token/services_inactive": "Сетевые сервисы неактивны.&nbsp;&nbsp;<a href='#XVM_SITE_INACTIVE#'><font size='11'>подробнее</font></a>",
            "token/blocked": "Статус: <font color='#FF0000'>Заблокирован</font>&nbsp;&nbsp;<a href='#XVM_SITE_BLOCKED#'><font size='11'>подробнее</font></a>",
            "token/active": "Статус:<tab/><font color='#00FF00'>Активен</font>",
            "token/time_left": "Осталось:<tab/><font color='#EEEEEE'>{0}д. {1}ч. {2}м.</font>",
            "token/time_left_warn": "Осталось:<tab/><font color='#EEEE00'>{0}д. {1}ч. {2}м.</font>",
            "token/cnt": "Количество запросов:<tab/><font color='#EEEEEE'>{0}</font>",
            "token/unknown_status": "Неизвестный статус",

            // Lobby header
            "lobby/header/gold_locked_tooltip": "Золото заблокировано",
            "lobby/header/gold_unlocked_tooltip": "Золото разблокировано",
            "lobby/header/freexp_locked_tooltip": "Свободный опыт заблокирован",
            "lobby/header/freexp_unlocked_tooltip": "Свободный опыт разблокирован",

            "lobby/crew/enable_prev_crew": "Автоматический возврат экипажа",
            "lobby/crew/enable_prev_crew_tooltip": "<b><font color='#FDF4CE'>{{l10n:lobby/crew/enable_prev_crew}}</font></b>\nАвтоматически вернуть экипаж, который в предыдущем\nбою был на данной машине",

            // Profile
            "profile/xvm_xte_tooltip": "<b><font color='#FDF4CE' size='16'>xTE</font></b>\nЭффективность по танку\nПодробная информация на <font color='#FDF4CE'>www.modxvm.com/ratings/</font>",
            "profile/xvm_xte_extended_tooltip": "<textformat tabstops='[20, 85, 140]'>{{l10n:profile/xvm_xte_tooltip}}\n\nЭталонные значения:\n\t\tурон\tфраги\n\tТекущие:\t<font color='#FDF4CE' size='14'>{0}</font>\t<font color='#FDF4CE' size='14'>{1}</font>\n\tСредние:\t<font color='#FDF4CE' size='14'>{2}</font>\t<font color='#FDF4CE' size='14'>{3}</font>\n\tТоповые:\t<font color='#FDF4CE' size='14'>{4}</font>\t<font color='#FDF4CE' size='14'>{5}</font>",

            // Carousel
            "NonElite": "Не элитный",
            "Premium": "Премиум",
            "Normal": "Обычный",
            "MultiXP": "Мультиопыт",
            "NoMaster": "Нет мастера",
            "CompleteCrew": "Полный экипаж",

            // Comments
            "Network services unavailable": "Сетевые сервисы недоступны",
            "Comments disabled": "Комментарии отключены",
            "Error loading comments": "Ошибка загрузки комментариев",
            "Error saving comments": "Ошибка сохранения комментариев",
            "Edit data": "Изменить данные",
            "Nick": "Имя",
            "Group": "Группа",
            "Comment": "Комментарий",

            // Vehicle status
            "Destroyed": "Уничтожен",
            "No data": "Нет данных",
            "Not ready": "Не готов",

            // Quests
            "Hide with honors": "Скрыть с отличием",
            "Hide unavailable": "Скрыть недоступные",

            // Config loading
            "XVM config reloaded": "Конфиг XVM перезагружен",
            "Config file xvm.xc was not found, using the built-in config": "Файл конфигурации xvm.xc не найден, используем встроенную конфигурацию",
            "Error loading XVM config": "Ошибка загрузки конфига XVM"
        };

        /** Hardcoded EN language */
        private static const FALLBACK_EN:Object = {
            // Win chance
            "chanceLive": "For alive",
            "chanceBattleTier": "Battle tier",

            /* xvm-as2
            // Hitlog
            "world_collision": "falling",
            "death_zone": "death zone",
            "drowning": "drowning",

            // Hp Left
            "hpLeftTitle": "Hitpoints left:",

            // Capture
            "enemyBaseCapture": "Base{0} capture by allies!",
            "enemyBaseCaptured": "Base{0} captured by allies!",
            "allyBaseCapture": "Base{0} capture by enemies!",
            "allyBaseCaptured": "Base{0} captured by enemies!",
            */

            // BattleResults
            "BR_xpCrew": "crew",

            // Crew
            "PutOwnCrew": "Put own crew",
            "PutBestCrew": "Put best crew",
            "PutClassCrew": "Put same class crew",
            "PutPreviousCrew": "Put previous crew",
            "DropAllCrew": "Drop all crew",
            "noSkills": "No skills",

            // Vehicle Params
            "gun_reload_time/actual": "Actual gun reload time",
            "view_range/base": "base",
            "view_range/actual": "actual",
            "view_range/stereoscope": "with stereoscope",
            "radio_range/base": "base",
            "radio_range/actual": "actual",
            "shootingRadius": "Shooting radius",
            "pitchLimits": "Elevation arc",
            "traverseLimits": "Gun traverse arc",
            "terrainResistance": "Terrain resistance",
            "gravity": "Gravity",
            "shellSpeed": "Shell speed",
            "camoCoeff": "Camo coefficients",
            "(m/sec)": "(m/sec)",
            "(sec)": "(sec)",
            "(m)": "(m)",

            // Squad
            "ussr": "USSR",
            "germany": "Germany",
            "usa": "USA",
            "france": "France",
            "uk": "UK",
            "china": "China",
            "japan": "Japan",

            // VehicleMarkersManager
            "blownUp": "Blown-up!",

            // Check version
            "ver/currentVersion": "XVM {0} ({1})", // XVM 5.3.4 (4321)
            "ver/newVersion": "Update available:<tab/><a href='#XVM_SITE_DL#'><font color='#00FF00'>v{0}</font></a>\n{1}",
            "websock/not_connected": "<font color='#FFFF00'>no connection to XVM server</font>",

            // token
            "token/services_unavailable": "Network services unavailable.&nbsp;&nbsp;<a href='#XVM_SITE_UNAVAILABLE#'><font size='11'>more info</font></a>",
            "token/services_inactive": "Network services inactive.&nbsp;&nbsp;<a href='#XVM_SITE_INACTIVE#'><font size='11'>more info</font></a>",
            "token/blocked": "Status: <font color='#FF0000'>Blocked</font>&nbsp;&nbsp;<a href='#XVM_SITE_BLOCKED'><font size='11'>more info</font></a>",
            "token/active": "Status:<tab/><font color='#00FF00'>Active</font>",
            "token/time_left": "Time left:<tab/><font color='#EEEEEE'>{0}d. {1}h. {2}m.</font>",
            "token/time_left_warn": "Time left:<tab/><font color='#EEEE00'>{0}d. {1}h. {2}m.</font>",
            "token/cnt": "Requests count:<tab/><font color='#EEEEEE'>{0}</font>",
            "token/unknown_status": "Unknown status",

            // Lobby header
            "lobby/header/gold_locked_tooltip": "Gold is locked",
            "lobby/header/gold_unlocked_tooltip": "Gold is unlocked",
            "lobby/header/freexp_locked_tooltip": "Free XP is locked",
            "lobby/header/freexp_unlocked_tooltip": "Free XP is unlocked",

            "lobby/crew/enable_prev_crew": "Automatically return crew",
            "lobby/crew/enable_prev_crew_tooltip": "<b><font color='#FDF4CE'>{{l10n:lobby/crew/enable_prev_crew}}</font></b>\nAutomatically return the crew that fought\nin this vehicle in the previous battle",

            // Profile
            "profile/xvm_xte_tooltip": "<b><font color='#FDF4CE' size='16'>xTE</font></b>\nPer-vehicle efficiency\nMore info at <font color='#FDF4CE'>www.modxvm.com/ratings/</font>",
            "profile/xvm_xte_extended_tooltip": "<textformat tabstops='[20, 85, 140]'>{{l10n:profile/xvm_xte_tooltip}}\n\nReference values:\n\t\tdamage\tfrags\n\tCurrent:\t<font color='#FDF4CE' size='14'>{0}</font>\t<font color='#FDF4CE' size='14'>{1}</font>\n\tAverage:\t<font color='#FDF4CE' size='14'>{2}</font>\t<font color='#FDF4CE' size='14'>{3}</font>\n\tTop:\t<font color='#FDF4CE' size='14'>{4}</font>\t<font color='#FDF4CE' size='14'>{5}</font>",

            // Carousel
            "NonElite": "Non elite",
            "Premium": "Premium",
            "Normal": "Normal",
            "MultiXP": "Multi XP",
            "NoMaster": "No master",
            "CompleteCrew": "Complete crew"
        };

        public static var s_lang:Object;
        private static var s_lang_fallback:Object;

        //private var _initialized:Boolean = false;
        //private var _language:String;
        //private var _loaded:Boolean = false;
        //private var timer:Number;

        function Locale()
        {
            s_lang = null;
            // This strings will be used if [langcode].xc not found
            s_lang_fallback = (Config.gameRegion == "RU") ? FALLBACK_RU : FALLBACK_EN;
        }

        private function setupLanguage(res:Object):void
        {
            var e:Error = res as Error;
            if (e != null)
            {
                if (res.type == "NO_FILE")
                {
                    Logger.add("Locale: Can not find language file. " + e.message);
                }
                else
                {
                    var text:String = "[" + res.type + "] " + res.message + ": ";
                    text += ConfigUtils.parseErrorEvent(e);
                    Logger.add(text);
                }
            }
            else
            {
                s_lang = res.locale;
                if (s_lang == null)
                    Logger.add("Locale: \"locale\" section is not found in the file");
            }
        }
    }
}
