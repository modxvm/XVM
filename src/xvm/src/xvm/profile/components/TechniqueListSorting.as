package xvm.profile.components
{
    import com.xvm.*;
    import net.wg.gui.components.advanced.*;

    // Add summary item to the first line of technique list
    public final class TechniqueListSorting
    {
        private static const F_NATION:String = "nation";
        private static const F_TYPE:String = "type";
        private static const F_LEVEL:String = "level";
        private static const F_VEHICLE_NAME:String = "vName";
        private static const F_TOTAL_BATTLES:String = "totalBattles";
        private static const F_TOTAL_WINS:String = "totalWins";
        private static const F_AVG_EXP:String = "avgExperience";
        private static const F_MASTERY:String = "mastery";

        private static const NATION_INDEX:String = "nationIndex";
        private static const TYPE_INDEX:String = "typeIndex";
        private static const LEVEL:String = "level";
        private static const SHORT_USER_NAME:String = "shortUserName";
        private static const BATTLES_COUNT:String = "battlesCount";
        private static const WINS_EFFICIENCY:String = "winsEfficiency";
        private static const AVG_EXPERIENCE:String = "avgExperience";
        private static const MARK_OF_MASTERY:String = "markOfMastery";

        //private static var sortFunctions:Object = null;

        private static var SORT_FIELDS:Object = {
            "nation":           { field: NATION_INDEX, options: Array.NUMERIC },
            "type":             { field: TYPE_INDEX, options: Array.CASEINSENSITIVE },
            "level":            { field: LEVEL, options: Array.NUMERIC | Array.DESCENDING },
            "vName":            { field: SHORT_USER_NAME, options: Array.CASEINSENSITIVE },
            "totalBattles":     { field: BATTLES_COUNT, options: Array.NUMERIC | Array.DESCENDING },
            "totalWins":        { field: WINS_EFFICIENCY, options: Array.NUMERIC | Array.DESCENDING },
            "avgExperience":    { field: AVG_EXPERIENCE, options: Array.NUMERIC | Array.DESCENDING },
            "mastery":          { field: MARK_OF_MASTERY, options: Array.NUMERIC | Array.DESCENDING }
        };

        private static var SORT_OPTIONS:Object = {
            "nation":           [ F_NATION, F_LEVEL, F_TYPE, F_VEHICLE_NAME ],              // 1 - nation
            "type":             [ F_TYPE, F_LEVEL, F_NATION, F_VEHICLE_NAME ],              // 2 - type
            "level":            [ F_LEVEL, F_NATION, F_TYPE, F_VEHICLE_NAME ],              // 3 - level
            "vName":            [ F_VEHICLE_NAME ],                                         // 4 - vName
            "totalBattles":     [ F_TOTAL_BATTLES ],                                        // 5 - totalBattles
            "totalWins":        [ F_TOTAL_WINS ],                                           // 6 - totalWins
            "avgExperience":    [ F_AVG_EXP ],                                              // 7 - evgExperience
            "mastery":          [ F_MASTERY, F_LEVEL, F_NATION, F_TYPE, F_VEHICLE_NAME ]    // 8 - mastery
        };

        public static function sort(data:Array, btn:SortingButton):void
        {
            if (btn.sortDirection == SortingButton.WITHOUT_SORT)
                return;

            var opt:Array = SORT_OPTIONS[btn.id];
            var fields:Array = [];
            var options:Array = [];
            for (var i:int = 0; i < opt.length; ++i)
            {
                var sortFields:Object = SORT_FIELDS[opt[i]];
                fields.push(sortFields.field);
                var o:uint = sortFields.options;
                if (btn.sortDirection != SortingButton.ASCENDING_SORT)
                {
                    if ((o & Array.DESCENDING) == 0)
                        o |= Array.DESCENDING;
                    else
                        o &= ~Array.DESCENDING;
                }
                options.push(o);
            }

            data.sortOn(fields, options);
        }
    }
}
