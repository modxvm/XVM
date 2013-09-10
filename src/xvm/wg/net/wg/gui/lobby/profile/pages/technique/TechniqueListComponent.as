package net.wg.gui.lobby.profile.pages.technique 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    
    public class TechniqueListComponent extends scaleform.clik.core.UIComponent
    {
        public function TechniqueListComponent()
        {
            super();
            this.techniqueList.addEventListener(net.wg.gui.lobby.profile.pages.technique.TechniqueList.SELECTED_DATA_CHANGED, this.selectedDataChangeHandler, false, 0, true);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.lowerShadow.mouseEnabled = false;
            this.sortableButtonBar.dataProvider = getHeadersProvider();
            this.sortableButtonBar.addEventListener(net.wg.gui.components.advanced.SortingButton.SORT_DIRECTION_CHANGED, this.sortingChangedHandler, false, 0, true);
            this.sortableButtonBar.selectedIndex = 4;
            this.techniqueList.sortByBattlesCount(true);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.techniqueList.dataProvider = new scaleform.clik.data.DataProvider(this._pendingDataProvider);
            }
            return;
        }

        internal function selectedDataChangeHandler(arg1:flash.events.Event):void
        {
            dispatchEvent(new flash.events.Event(DATA_CHANGED));
            return;
        }

        internal function sortingChangedHandler(arg1:flash.events.Event):void
        {
            var loc2:*=null;
            arg1.stopImmediatePropagation();
            var loc1:*=net.wg.gui.components.advanced.SortingButton(arg1.target);
            if (loc1.sortDirection != net.wg.gui.components.advanced.SortingButton.WITHOUT_SORT) 
            {
                if (!this.sortFunctions) 
                {
                    this.sortFunctions = {};
                    this.sortFunctions[NATION] = this.techniqueList.sortByNation;
                    this.sortFunctions[LEVEL] = this.techniqueList.sortByLevel;
                    this.sortFunctions[TYPE] = this.techniqueList.sortByType;
                    this.sortFunctions[VEHICLE_NAME] = this.techniqueList.sortByVehicleName;
                    this.sortFunctions[TOTAL_BATTLES] = this.techniqueList.sortByBattlesCount;
                    this.sortFunctions[TOTAL_WINS] = this.techniqueList.sortByWins;
                    this.sortFunctions[AVG_EXP] = this.techniqueList.sortByAvgExp;
                    this.sortFunctions[MASTERY] = this.techniqueList.sortByMarkOfMastery;
                }
                loc2 = this.sortFunctions[loc1.id];
                loc2.apply(this, [loc1.sortDirection == net.wg.gui.components.advanced.SortingButton.ASCENDING_SORT]);
            }
            return;
        }

        public function setViewSize(arg1:Number, arg2:Number):void
        {
            this.techniqueList.setSize(this.techniqueList.width, arg2);
            this.techniqueList.validateNow();
            this.bg.height = arg2 - this.bg.y;
            this.scrollBar.setActualSize(this.scrollBar.width, arg2 - this.scrollBar.y);
            this.scrollBar.validateNow();
            this.lowerShadow.y = arg2 - this.lowerShadow.height;
            return;
        }

        public function get selectedItem():net.wg.gui.lobby.profile.pages.technique.TechniqueListVehicleVO
        {
            return net.wg.gui.lobby.profile.pages.technique.TechniqueListVehicleVO(this.techniqueList.selectedItem);
        }

        public function set dataProvider(arg1:Array):void
        {
            this._pendingDataProvider = arg1;
            invalidateData();
            return;
        }

        public override function dispose():void
        {
            this._pendingDataProvider = null;
            this.sortableButtonBar.removeEventListener(net.wg.gui.components.advanced.SortingButton.SORT_DIRECTION_CHANGED, this.sortingChangedHandler);
            if (this.techniqueList) 
            {
                this.techniqueList.removeEventListener(net.wg.gui.lobby.profile.pages.technique.TechniqueList.SELECTED_DATA_CHANGED, this.selectedDataChangeHandler);
                this.techniqueList.dispose();
                this.techniqueList = null;
            }
            if (this.sortableButtonBar) 
            {
                this.sortableButtonBar.dispose();
                this.sortableButtonBar = null;
            }
            if (this.scrollBar) 
            {
                this.scrollBar.dispose();
                this.scrollBar = null;
            }
            this.sortFunctions = null;
            this.lowerShadow = null;
            return;
        }

        internal static function getHeadersProvider():scaleform.clik.data.DataProvider
        {
            var loc13:*=null;
            var loc1:*="../maps/icons/buttons/tab_sort_button/ascProfileSortArrow.png";
            var loc2:*="../maps/icons/buttons/tab_sort_button/descProfileSortArrow.png";
            var loc3:*=40;
            var loc4:*=[];
            var loc5:*;
            (loc5 = new net.wg.gui.lobby.profile.pages.technique.ProfileSortingBtnInfo()).iconId = NATION;
            loc5.iconSource = "../maps/icons/filters/nations/all.png";
            loc5.buttonWidth = 36;
            loc5.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_NATION;
            loc4.push(loc5);
            var loc6:*;
            (loc6 = new net.wg.gui.lobby.profile.pages.technique.ProfileSortingBtnInfo()).iconId = TYPE;
            loc6.iconSource = "../maps/icons/filters/tanks/all.png";
            loc6.buttonWidth = 34;
            loc6.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_TECHNIQUE;
            loc4.push(loc6);
            var loc7:*;
            (loc7 = new net.wg.gui.lobby.profile.pages.technique.ProfileSortingBtnInfo()).iconId = LEVEL;
            loc7.iconSource = "../maps/icons/buttons/tab_sort_button/level.png";
            loc7.buttonWidth = 28;
            loc7.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_LVL;
            loc4.push(loc7);
            var loc8:*;
            (loc8 = new net.wg.gui.lobby.profile.pages.technique.ProfileSortingBtnInfo()).iconId = VEHICLE_NAME;
            loc8.label = PROFILE.SECTION_TECHNIQUE_BUTTONBAR_VEHICLENAME;
            loc8.buttonWidth = 158;
            loc8.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_NAME;
            loc4.push(loc8);
            var loc9:*;
            (loc9 = new net.wg.gui.lobby.profile.pages.technique.ProfileSortingBtnInfo()).iconId = TOTAL_BATTLES;
            loc9.buttonWidth = 74;
            loc9.label = PROFILE.SECTION_SUMMARY_SCORES_TOTALBATTLES;
            loc9.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_BATTLESCOUNT;
            loc4.push(loc9);
            var loc10:*;
            (loc10 = new net.wg.gui.lobby.profile.pages.technique.ProfileSortingBtnInfo()).iconId = TOTAL_WINS;
            loc10.buttonWidth = 74;
            loc10.label = PROFILE.SECTION_TECHNIQUE_BUTTONBAR_TOTALWINS;
            loc10.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_WINS;
            loc4.push(loc10);
            var loc11:*;
            (loc11 = new net.wg.gui.lobby.profile.pages.technique.ProfileSortingBtnInfo()).iconId = AVG_EXP;
            loc11.buttonWidth = 90;
            loc11.label = PROFILE.SECTION_TECHNIQUE_BUTTONBAR_AVGEXPERIENCE;
            loc11.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_AVGEXP;
            loc4.push(loc11);
            var loc12:*;
            (loc12 = new net.wg.gui.lobby.profile.pages.technique.ProfileSortingBtnInfo()).iconId = MASTERY;
            loc12.buttonWidth = 80;
            loc12.showSeparator = false;
            loc12.label = PROFILE.SECTION_TECHNIQUE_BUTTONBAR_CLASSINESS;
            loc12.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_MARKSOFMASTERY;
            loc4.push(loc12);
            var loc14:*=0;
            while (loc14 < loc4.length) 
            {
                (loc13 = loc4[loc14]).ascendingIconSource = loc1;
                loc13.descendingIconSource = loc2;
                loc13.buttonHeight = loc3;
                loc13.enabled = true;
                loc13.defaultSortDirection = net.wg.gui.components.advanced.SortingButton.WITHOUT_SORT;
                ++loc14;
            }
            return new scaleform.clik.data.DataProvider(loc4);
        }

        internal static const NATION:String="nation";

        internal static const LEVEL:String="level";

        internal static const TYPE:String="type";

        internal static const VEHICLE_NAME:String="vName";

        internal static const TOTAL_BATTLES:String="totalBattles";

        internal static const TOTAL_WINS:String="totalWins";

        internal static const AVG_EXP:String="avgExperience";

        internal static const MASTERY:String="mastery";

        public static const DATA_CHANGED:String="dataChanged";

        public var lowerShadow:flash.display.MovieClip;

        public var sortableButtonBar:net.wg.gui.components.advanced.SortableHeaderButtonBar;

        public var techniqueList:net.wg.gui.lobby.profile.pages.technique.TechniqueList;

        public var scrollBar:net.wg.gui.components.controls.ScrollBar;

        public var bg:flash.display.MovieClip;

        internal var sortFunctions:Object;

        internal var _pendingDataProvider:Array;
    }
}
