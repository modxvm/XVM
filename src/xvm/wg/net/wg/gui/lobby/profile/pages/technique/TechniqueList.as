package net.wg.gui.lobby.profile.pages.technique 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    
    public class TechniqueList extends net.wg.gui.components.controls.SortableScrollingList
    {
        public function TechniqueList()
        {
            super();
            return;
        }

        public function sortByAvgExp(arg1:Boolean):void
        {
            if (dataProvider) 
            {
                sortMask = Array.NUMERIC;
                setSortMask(arg1);
                this.invalidateSorting(AVG_EXPERIENCE);
            }
            return;
        }

        public function sortByMarkOfMastery(arg1:Boolean):void
        {
            if (dataProvider) 
            {
                sortMask = Array.NUMERIC;
                setSortMask(arg1);
                this.invalidateSorting(MARK_OF_MASTERY);
            }
            return;
        }

        protected override function drawLayout():void
        {
            var loc8:*=null;
            var loc1:*=_renderers.length;
            var loc2:*=rowHeight;
            var loc3:*=availableWidth - padding.horizontal;
            var loc4:*=margin + padding.left;
            var loc5:*=margin + padding.top;
            var loc6:*=isInvalid(scaleform.clik.constants.InvalidationType.DATA);
            var loc7:*=0;
            while (loc7 < loc1) 
            {
                (loc8 = getRendererAt(loc7)).x = Math.round(loc4);
                loc8.y = Math.round(loc5 + loc7 * loc2);
                loc8.width = loc3;
                if (!loc6) 
                {
                    loc8.validateNow();
                }
                ++loc7;
            }
            drawScrollBar();
            return;
        }

        public override function dispose():void
        {
            this.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.indexChangedHandler);
            super.dispose();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.indexChangedHandler, false, 0, true);
            return;
        }

        protected override function handleItemClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            super.handleItemClick(arg1);
            this.isSortingTheLastActivity = false;
            return;
        }

        internal function indexChangedHandler(arg1:scaleform.clik.events.ListEvent):void
        {
            if (!this.isSortingTheLastActivity) 
            {
                dispatchEvent(new flash.events.Event(SELECTED_DATA_CHANGED));
            }
            return;
        }

        public override function set dataProvider(arg1:scaleform.clik.interfaces.IDataProvider):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            this.isSortingTheLastActivity = false;
            this.isDataProviderReceived = true;
            this.invalidateSorting(sortPropName);
            super.dataProvider = arg1;
            if (!this.isValidationChecked) 
            {
                if (arg1 && arg1.length > 0) 
                {
                    this.isValidationChecked = true;
                    loc1 = new Vector.<String>();
                    loc1.push(NATION_INDEX);
                    loc1.push(TYPE_INDEX);
                    loc1.push(SHORT_USER_NAME);
                    loc1.push(BATTLES_COUNT);
                    loc1.push(WINS_EFFICIENCY);
                    loc1.push(AVG_EXPERIENCE);
                    loc1.push(MARK_OF_MASTERY);
                    loc1.push(LEVEL);
                    loc2 = arg1[0];
                    var loc4:*=0;
                    var loc5:*=loc1;
                    for each (loc3 in loc5) 
                    {
                        App.utils.asserter.assert(loc2.hasOwnProperty(loc3), "There is no property \'" + loc3 + "\' in the " + flash.utils.getQualifiedClassName(loc2) + " to apply sort operation! " + flash.utils.getQualifiedClassName(this));
                    }
                }
            }
            return;
        }

        protected override function sortWithMask(arg1:String, arg2:uint):void
        {
            var loc3:*=null;
            super.sortWithMask(arg1, arg2);
            var loc1:*=-1;
            var loc2:*;
            if ((loc2 = dataProvider.length) > 0) 
            {
                loc1 = 0;
            }
            var loc4:*=0;
            while (loc4 < loc2) 
            {
                loc3 = dataProvider[loc4];
                if (this.oldSelectedItemId == loc3.id) 
                {
                    loc1 = loc4;
                    break;
                }
                ++loc4;
            }
            _newSelectedIndex = loc1;
            invalidateSelectedIndex();
            return;
        }

        public override function set selectedIndex(arg1:int):void
        {
            this.updateOldSelected();
            super.selectedIndex = arg1;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            this.isSortingTheLastActivity = false;
            if (this.isDataProviderReceived) 
            {
                this.isDataProviderReceived = false;
                dispatchEvent(new flash.events.Event(SELECTED_DATA_CHANGED));
            }
            return;
        }

        public function get selectedItem():Object
        {
            if (dataProvider && dataProvider.length > 0) 
            {
                return dataProvider[selectedIndex];
            }
            return null;
        }

        internal function invalidateSorting(arg1:String):void
        {
            this.updateOldSelected();
            sortPropName = arg1;
            this.isSortingTheLastActivity = true;
            invalidate(SORTING_INVALID);
            return;
        }

        internal function updateOldSelected():void
        {
            var loc2:*=null;
            var loc1:*=getRendererAt(selectedIndex);
            if (loc1) 
            {
                loc2 = net.wg.gui.lobby.profile.pages.technique.TechniqueListVehicleVO(_dataProvider[selectedIndex]);
                this.oldSelectedItemId = loc2.id;
            }
            return;
        }

        public function sortByNation(arg1:Boolean):void
        {
            if (dataProvider) 
            {
                sortMask = Array.NUMERIC;
                setSortMask(arg1);
                this.invalidateSorting(NATION_INDEX);
            }
            return;
        }

        public function sortByType(arg1:Boolean):void
        {
            if (dataProvider) 
            {
                sortMask = Array.CASEINSENSITIVE;
                setSortMask(arg1);
                this.invalidateSorting(TYPE_INDEX);
            }
            return;
        }

        public function sortByLevel(arg1:Boolean):void
        {
            if (dataProvider) 
            {
                sortMask = Array.NUMERIC;
                setSortMask(arg1);
                this.invalidateSorting(LEVEL);
            }
            return;
        }

        public function sortByVehicleName(arg1:Boolean):void
        {
            if (dataProvider) 
            {
                sortMask = Array.CASEINSENSITIVE;
                if (!arg1) 
                {
                    sortMask = sortMask | Array.DESCENDING;
                }
                this.invalidateSorting(SHORT_USER_NAME);
            }
            return;
        }

        public function sortByBattlesCount(arg1:Boolean):void
        {
            if (dataProvider) 
            {
                sortMask = Array.NUMERIC;
                setSortMask(arg1);
                this.invalidateSorting(BATTLES_COUNT);
            }
            return;
        }

        public function sortByWins(arg1:Boolean):void
        {
            if (dataProvider) 
            {
                sortMask = Array.NUMERIC;
                setSortMask(arg1);
                this.invalidateSorting(WINS_EFFICIENCY);
            }
            return;
        }

        internal static const NATION_INDEX:String="nationIndex";

        internal static const TYPE_INDEX:String="typeIndex";

        internal static const SHORT_USER_NAME:String="shortUserName";

        internal static const BATTLES_COUNT:String="battlesCount";

        internal static const WINS_EFFICIENCY:String="winsEfficiency";

        internal static const AVG_EXPERIENCE:String="avgExperience";

        internal static const MARK_OF_MASTERY:String="markOfMastery";

        internal static const LEVEL:String="level";

        public static const SELECTED_DATA_CHANGED:String="selDataChanged";

        internal var isValidationChecked:Boolean;

        internal var oldSelectedItemId:int=-1;

        internal var isSortingTheLastActivity:Boolean;

        internal var isDataProviderReceived:Boolean;
    }
}
