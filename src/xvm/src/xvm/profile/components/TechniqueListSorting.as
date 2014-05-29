package xvm.profile.components
{
    import com.xvm.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.lobby.profile.pages.technique.*;

    // Add summary item to the first line of technique list
    public final class TechniqueListSorting
    {
        private static const F_NATION_INDEX:String = TechniqueList.NATION_INDEX;
        private static const F_TYPE_INDEX:String = TechniqueList.TYPE_INDEX;
        private static const F_LEVEL:String = TechniqueList.LEVEL;
        private static const F_SHORT_USER_NAME:String = TechniqueList.SHORT_USER_NAME;
        private static const F_BATTLES_COUNT:String = TechniqueList.BATTLES_COUNT;
        private static const F_WINS_EFFICIENCY:String = TechniqueList.WINS_EFFICIENCY;
        private static const F_AVG_EXPERIENCE:String = TechniqueList.AVG_EXPERIENCE;
        private static const F_MARK_OF_MASTERY:String = TechniqueList.MARK_OF_MASTERY;

        private static var SORT_FIELDS:Object = {
            "nationIndex":    { field: TechniqueList.NATION_INDEX, options: Array.NUMERIC },
            "typeIndex":      { field: TechniqueList.TYPE_INDEX, options: Array.CASEINSENSITIVE },
            "level":          { field: TechniqueList.LEVEL, options: Array.NUMERIC | Array.DESCENDING },
            "shortUserName":  { field: TechniqueList.SHORT_USER_NAME, options: Array.CASEINSENSITIVE },
            "battlesCount":   { field: TechniqueList.BATTLES_COUNT, options: Array.NUMERIC | Array.DESCENDING },
            "winsEfficiency": { field: TechniqueList.WINS_EFFICIENCY, options: Array.NUMERIC | Array.DESCENDING },
            "avgExperience":  { field: TechniqueList.AVG_EXPERIENCE, options: Array.NUMERIC | Array.DESCENDING },
            "markOfMastery":  { field: TechniqueList.MARK_OF_MASTERY, options: Array.NUMERIC | Array.DESCENDING }
        };

        private static var SORT_OPTIONS:Object = {
            "nationIndex":    [ F_NATION_INDEX, F_LEVEL, F_TYPE_INDEX, F_SHORT_USER_NAME ],                   // 1 - nationIndex
            "typeIndex":      [ F_TYPE_INDEX, F_LEVEL, F_NATION_INDEX, F_SHORT_USER_NAME ],                   // 2 - typeIndex
            "level":          [ F_LEVEL, F_NATION_INDEX, F_TYPE_INDEX, F_SHORT_USER_NAME ],                   // 3 - level
            "shortUserName":  [ F_SHORT_USER_NAME ],                                                          // 4 - shortUserName
            "battlesCount":   [ F_BATTLES_COUNT ],                                                            // 5 - battlesCount
            "winsEfficiency": [ F_WINS_EFFICIENCY ],                                                          // 6 - winsEfficiency
            "avgExperience":  [ F_AVG_EXPERIENCE ],                                                           // 7 - avgExperience
            "markOfMastery":  [ F_MARK_OF_MASTERY, F_LEVEL, F_NATION_INDEX, F_TYPE_INDEX, F_SHORT_USER_NAME ] // 8 - markOfMastery
        };

        public static function sort(data:Array, btn:SortingButton):void
        {
            if (btn.sortDirection == SortingInfo.WITHOUT_SORT)
                return;

            var opt:Array = SORT_OPTIONS[btn.id];
            if (opt == null)
            {
                Logger.add((new Error("ERROR: unknown button id: " + btn.id)).getStackTrace());
                return;
            }

            var fields:Array = [];
            var options:Array = [];
            for (var i:int = 0; i < opt.length; ++i)
            {
                var sortFields:Object = SORT_FIELDS[opt[i]];
                fields.push(sortFields.field);
                var o:uint = sortFields.options;
                if (btn.sortDirection != SortingInfo.ASCENDING_SORT)
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
