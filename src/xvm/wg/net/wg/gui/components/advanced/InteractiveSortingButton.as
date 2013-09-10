package net.wg.gui.components.advanced 
{
    public class InteractiveSortingButton extends net.wg.gui.components.advanced.SortingButton
    {
        public function InteractiveSortingButton()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            _toggle = true;
            allowDeselect = false;
            return;
        }

        public override function set toggle(arg1:Boolean):void
        {
            return;
        }

        public override function set sortDirection(arg1:String):void
        {
            if (!(sortDirection == arg1) && selected) 
                this._previousSelectedSorDirection = sortDirection;
            super.sortDirection = arg1;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        protected override function handleRelease(arg1:uint=0):void
        {
            super.handleRelease(arg1);
            return;
        }

        protected override function handleClick(arg1:uint=0):void
        {
            if (selected) 
                if (sortDirection != ASCENDING_SORT) 
                    if (sortDirection == DESCENDING_SORT) 
                        this.sortDirection = ASCENDING_SORT;
                else 
                    this.sortDirection = DESCENDING_SORT;
            else 
                super.handleClick(arg1);
            return;
        }

        public override function set selected(arg1:Boolean):void
        {
            if (selected != arg1) 
                if (arg1 != false) 
                    if (!(this._previousSelectedSorDirection == ASCENDING_SORT) && !(this._previousSelectedSorDirection == DESCENDING_SORT)) 
                        this.sortDirection = defaultSortDirection != WITHOUT_SORT ? defaultSortDirection : ASCENDING_SORT;
                    else 
                        this.sortDirection = defaultSortDirection != WITHOUT_SORT ? defaultSortDirection : this._previousSelectedSorDirection;
                else 
                    this.sortDirection = WITHOUT_SORT;
            super.selected = arg1;
            return;
        }

        internal var _previousSelectedSorDirection:String;
    }
}
