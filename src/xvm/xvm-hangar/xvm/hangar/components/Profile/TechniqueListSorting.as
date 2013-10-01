package xvm.hangar.components.Profile
{
    //import flash.events.*;
    //import scaleform.clik.data.DataProvider;
    //import scaleform.clik.events.*;
    //import scaleform.clik.interfaces.*;
    import net.wg.gui.components.advanced.*;
    //import net.wg.gui.lobby.profile.pages.summary.*;
    //import net.wg.gui.lobby.profile.pages.technique.*;
    import com.xvm.*;
    //import com.xvm.events.*;
    //import com.xvm.l10n.Locale;

    // Add summary item to the first line of technique list
    public final class TechniqueListSorting
    {
        private static const B_NATION:String = "nation";
        private static const B_TYPE:String = "type";
        private static const B_LEVEL:String = "level";
        private static const B_VEHICLE_NAME:String = "vName";
        private static const B_TOTAL_BATTLES:String = "totalBattles";
        private static const B_TOTAL_WINS:String = "totalWins";
        private static const B_AVG_EXP:String = "avgExperience";
        private static const B_MASTERY:String = "mastery";

        private static const NATION_INDEX:String = "nationIndex";
        private static const TYPE_INDEX:String = "typeIndex";
        private static const LEVEL:String = "level";
        private static const SHORT_USER_NAME:String = "shortUserName";
        private static const BATTLES_COUNT:String = "battlesCount";
        private static const WINS_EFFICIENCY:String = "winsEfficiency";
        private static const AVG_EXPERIENCE:String = "avgExperience";
        private static const MARK_OF_MASTERY:String = "markOfMastery";

        //private static var sortFunctions:Object = null;

        private static var SORT_OPTIONS:Object = [
            [ { name: B_NATION, field: NATION_INDEX, options: Array.NUMERIC } ],
            [ { name: B_TYPE, field: TYPE_INDEX, options: Array.CASEINSENSITIVE } ],
            [ { name: B_LEVEL, field: LEVEL, options: Array.NUMERIC } ],
            [ { name: B_VEHICLE_NAME, field: SHORT_USER_NAME, options: Array.CASEINSENSITIVE } ],
            [ { name: B_TOTAL_BATTLES, field: BATTLES_COUNT, options: Array.NUMERIC } ],
            [ { name: B_TOTAL_WINS, field: WINS_EFFICIENCY, options: Array.NUMERIC } ],
            [ { name: B_AVG_EXP, field: AVG_EXPERIENCE, options: Array.NUMERIC } ],
            [ { name: B_MASTERY, field: MARK_OF_MASTERY, options: Array.NUMERIC } ]
        ];

        public static function sort(data:Array, btn:SortingButton):void
        {
            if (btn.sortDirection == SortingButton.WITHOUT_SORT)
                return;
            var opt:Object = SORT_OPTIONS[btn.id];
            var options:Number = opt.options;
            if (btn.sortDirection != SortingButton.ASCENDING_SORT)
                options |= Array.DESCENDING;
            data.sortOn(opt.field, options);

            // Original handler have calls stopImmediatePropagation() on the event, so duplicate it here,
            // because we need to add our code after that.
            /*if (btn.sortDirection != SortingButton.WITHOUT_SORT)
            {
                if (sortFunctions == null)
                {
                    sortFunctions = {};
                    sortFunctions[NATION] = list.sortByNation;
                    sortFunctions[LEVEL] = list.sortByLevel;
                    sortFunctions[TYPE] = list.sortByType;
                    sortFunctions[VEHICLE_NAME] = list.sortByVehicleName;
                    sortFunctions[TOTAL_BATTLES] = list.sortByBattlesCount;
                    sortFunctions[TOTAL_WINS] = list.sortByWins;
                    sortFunctions[AVG_EXP] = list.sortByAvgExp;
                    sortFunctions[MASTERY] = list.sortByMarkOfMastery;
                }
                var func:Function = sortFunctions[btn.id];
                func.apply(page.listComponent, [btn.sortDirection == SortingButton.ASCENDING_SORT]);
                list.validateNow();
            }*/
        }
    }
}
