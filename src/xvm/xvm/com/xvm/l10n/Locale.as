/**
 * XVM Sandbox Detector
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 * @author Michael Pavlyshko
 * @author Pavel Máca
 */
package com.xvm.l10n
{
    import com.xvm.events.ObjectEvent;
    import flash.events.DataEvent;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import com.xvm.Config;
    import com.xvm.Defines;
    import com.xvm.Logger;
    import com.xvm.io.JSONxLoader;
    import com.xvm.misc.ConfigUtils;
    import flash.events.SampleDataEvent;

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
            JSONxLoader.LoadAndParse(Defines.XVM_ROOT + "l10n/" + Config.language + ".xc", Instance, Instance.languageFileCallback);
        }

        public static function get(format:String):String
        {
            //Logger.add("Locale[get]: string: " + text + " | string: " + s_lang.locale[text] + " | fallback string: " + s_lang_fallback[text] + " | language: " + _language );
            if (s_lang.locale && s_lang.locale.hasOwnProperty(format))
                format = s_lang.locale[format];
            else if (s_lang_fallback.hasOwnProperty(format))
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
                res += Locale.get(macro);

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
            "XVM_translator": "XVM Team",

            // Ping
            "Initialization": "Инициализация",

            // BattleLoading
            "New version available": "Доступна новая версия",

            // Win chance
            "Chance error": "Ошибка расчета шансов",
            "Chance to win": "Шанс на победу",
            "global": "общий",
            "per-vehicle": "по технике",

            // Hitlog
            "attack": "атака",
            "fire": "пожар",
            "ramming": "таран",
            "world_collision": "падение",
            "Hits": "Пробитий",
            "Total": "Всего",
            "Last": "Последний",

            // Hp Left
            "hpLeftTitle": "Осталось HP:",

            // Capture
            "enemyBaseCapture": "Захват базы союзниками!",
            "enemyBaseCaptured": "База захвачена союзниками!",
            "allyBaseCapture": "Захват базы врагами!",
            "allyBaseCaptured": "База захвачена врагами!",

            // FinalStatistics
            "Hit percent": "Процент попаданий",
            "Damage upon detecting": "Урон по вашим разведданным",
            "Damage dealt": "Нанесенный урон",

            // TeamRenderers
            "TeamRenderersHeaderTip":
                "Рейтинг xwn (или xeff).\n" +
                "Чтобы увидеть более подробную информацию, наведите курсор мыши на значение рейтинга интересующего игрока.",
            "Friend": "Друг",
            "Ignored": "Игнор",
            "Load statistics": "Загрузить статистику",
            "enabled": "включено",
            "disabled": "выключено",

            // UserInfo
            "UserInfoEHint":
                "Эффективность по танку.\n" +
                "Значение указано на момент последнего обновления статистики: %DATE%\n" +
                "Актуальное значение на текущий момент - в детальной информации по технике.\n" +
                "Правильность значений в колонке зависит от качества полученных исходных данных.",
            "Data was updated at": "Данные были обновлены",
            " to ": " до ",
            "EFF": "РЭ",
            "updated": "обновлено",
            "unknown": "неизвестно",
            "Avg level": "Ср. уровень",
            "Spotted": "Засвет",
            "Defence": "Защита",
            "Capture": "Захват",
            "player (average / top)": "игрок (средний / топ)",

            // UserInfo - filters
            "Filter": "Фильтр",
            "Spec dmg": "Уд. дамаг",
            "All tanks": "Все танки",
            "Show all tanks in the game": "Показать все танки в игре",
            "Player tanks": "Танки игрока",
            "Show all tanks played": "Показать все танки, на которых играл",
            "In hangar": "В ангаре",
            "Show only tanks in own hangar": "Показать только танки в своем ангаре",

            // UserInfo - buttons
            "Level": "Уровень",
            "Type": "Тип",
            "Nation": "Нация",
            "Name": "Имя",
            "Fights": "Боёв",
            "Wins": "Побед",

            // Crew
            "PutOwnCrew": "Родной экипаж",
            "PutBestCrew": "Лучший экипаж",
            "PutClassCrew": "Экипаж того же класса",

            // Squad
            "Vehicle": "Танк",
            "Battle tiers": "Уровень боёв",
            "ussr": "СССР",
            "germany": "Германия",
            "usa": "США",
            "france": "Франция",
            "uk": "Великобритания",
            "china": "Китай",
            "HT": "ТТ",
            "MT": "СТ",
            "LT": "ЛТ",
            "TD": "ПТ",
            "SPG": "САУ",

            // VehicleMarkersManager
            "blownUp": "Взрыв БК!"
        };

        /** Hardcoded EN language */
        private static const FALLBACK_EN:Object = {
            "XVM_translator": "XVM Team",

            // Hitlog
            "world_collision": "falling",

            // Hp Left
            "hpLeftTitle": "Hitpoints left:",

            // Capture
            "enemyBaseCapture": "Base capture by allies!",
            "enemyBaseCaptured": "Base captured by allies!",
            "allyBaseCapture": "Base capture by enemies!",
            "allyBaseCaptured": "Base captured by enemies!",

            // UserInfo
            "UserInfoEHint":
                "Per-vehicle efficiency.\n" +
                "The values shown are as of the last statistics update: %DATE%\n" +
                "See actual current values in the detailed vehicle info.\n" +
                "Accuracy of the column values depends on the quality of the feed data.",

            // TeamRenderers
            "TeamRenderersHeaderTip":
                "Xwn (or xeff) rating.\n" +
                "To see detailed information, move mouse cursor to the player's name.",

            // Crew
            "PutOwnCrew": "Put own crew",
            "PutBestCrew": "Put best crew",
            "PutClassCrew": "Put same class crew",

            // Squad
            "ussr": "USSR",
            "germany": "Germany",
            "usa": "USA",
            "france": "France",
            "uk": "UK",
            "china": "China",

            // VehicleMarkersManager
            "blownUp": "Blown-up!"
        };

        private static var s_lang:Object = { };
        private static var s_lang_fallback:Object;

        //private var _initialized:Boolean = false;
        //private var _language:String;
        //private var _loaded:Boolean = false;
        //private var timer:Number;

        function Locale()
        {
            // This strings will be used if .xc not found
            s_lang_fallback = (Config.gameRegion == "RU") ? FALLBACK_RU : FALLBACK_EN;
        }

        private function languageFileCallback(event:Object):void
        {
            var result:Object = { };
            try
            {
                if (event.error == null)
                {
                    s_lang = event.data;
                    Logger.add("Locale: Loaded '" + Config.language + "' language by " + get("XVM_translator"));
                }
                else
                {
                    if (event.error.type == "NO_FILE")
                        Logger.add("Locale: Can not find language file. Filename: " + event.filename);
                    else
                    {
                        var ex:* = event.error;
                        var text:String = "Error loading language file '" + event.filename + "': ";
                        text += ConfigUtils.parseErrorEvent(event);
                        result.error = text;
                        Logger.add(text);
                    }
                }
            }
            finally
            {
                dispatchEvent(new ObjectEvent(Defines.E_LOCALE_LOADED, result));
            }
        }
    }
}
