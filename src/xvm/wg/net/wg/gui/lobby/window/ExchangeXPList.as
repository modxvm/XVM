package net.wg.gui.lobby.window 
{
    import net.wg.gui.components.controls.*;
    
    public class ExchangeXPList extends net.wg.gui.components.controls.SortableScrollingList
    {
        public function ExchangeXPList()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        public function sortSelection(arg1:Boolean):void
        {
            if (dataProvider) 
            {
                sortMask = Array.NUMERIC;
                setSortMask(arg1);
                sortPropName = "isSelectCandidate";
                invalidate(SORTING_INVALID);
            }
            return;
        }

        public function sortByVehicleName(arg1:Boolean):void
        {
            if (dataProvider) 
            {
                sortMask = Array.CASEINSENSITIVE;
                if (!arg1) 
                    sortMask = sortMask | Array.DESCENDING;
                sortPropName = "vehicleName";
                invalidate(SORTING_INVALID);
            }
            return;
        }

        public function sortByExperience(arg1:Boolean):void
        {
            if (dataProvider) 
            {
                sortMask = Array.NUMERIC;
                setSortMask(arg1);
                sortPropName = "xp";
                invalidate(SORTING_INVALID);
            }
            return;
        }

        public function applySelection(arg1:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=0;
            while (loc2 < dataProvider.length) 
            {
                loc1 = dataProvider[loc2];
                loc1.isSelectCandidate = arg1;
                ++loc2;
            }
            invalidateData();
            return;
        }
    }
}
