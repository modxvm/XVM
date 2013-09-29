package net.wg.gui.components.advanced 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import scaleform.clik.constants.*;
    
    public class SortingButton extends net.wg.gui.components.advanced.ScalableIconButton
    {
        public function SortingButton()
        {
            super();
            return;
        }

        public function get sortDirection():String
        {
            return this._sortDirection;
        }

        public function set sortDirection(arg1:String):void
        {
            var value:String;

            var loc1:*;
            value = arg1;
            if (!(value == ASCENDING_SORT) && !(value == DESCENDING_SORT) && !(value == WITHOUT_SORT)) 
            {
                try 
                {
                    DebugUtils.LOG_WARNING("Flash :: Unknown sorting button state: ", value);
                }
                catch (e:Error)
                {
                    trace("Flash :: Unknown sorting button state:", value);
                }
                value = WITHOUT_SORT;
            }
            if (this._sortDirection != value) 
            {
                this._sortDirection = value;
                dispatchEvent(new flash.events.Event(SORT_DIRECTION_CHANGED, true));
                invalidate(SORT_DIRECTION_INVALID);
            }
            return;
        }

        public override function set data(arg1:Object):void
        {
            var loc1:*=null;
            super.data = arg1;
            if (arg1 is net.wg.gui.components.advanced.SortingButtonInfo) 
            {
                loc1 = net.wg.gui.components.advanced.SortingButtonInfo(arg1);
                if (!isNaN(loc1.buttonWidth)) 
                {
                    width = loc1.buttonWidth;
                }
                if (!isNaN(loc1.buttonHeight)) 
                {
                    height = loc1.buttonHeight;
                }
                if (loc1.defaultSortDirection) 
                {
                    this.defaultSortDirection = loc1.defaultSortDirection;
                }
                if (loc1.toolTip) 
                {
                    tooltip = loc1.toolTip;
                }
                enabled = loc1.enabled;
                this._id = loc1.iconId;
                this.ascendingIconSource = loc1.ascendingIconSource;
                this.descendingIconSource = loc1.descendingIconSource;
                iconSource = loc1.iconSource;
            }
            return;
        }

        public function get ascendingIconSource():String
        {
            return this._ascendingIconSource;
        }

        public function set ascendingIconSource(arg1:String):void
        {
            this._ascendingIconSource = arg1;
            invalidate(ASCENDING_ICON_INVALID);
            return;
        }

        public function get descendingIconSource():String
        {
            return this._descendingIconSource;
        }

        public function set descendingIconSource(arg1:String):void
        {
            this._descendingIconSource = arg1;
            invalidate(DESCENDING_ICON_INVALID);
            return;
        }

        protected override function updateAfterStateChange():void
        {
            super.updateAfterStateChange();
            this.bg.width = _width;
            this.bg.height = _height;
            if (this.upperBg) 
            {
                this.upperBg.width = _width - 2;
                this.upperBg.height = _height;
            }
            return;
        }

        public function get id():String
        {
            return this._id;
        }

        public function set id(arg1:String):void
        {
            this._id = arg1;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.tabEnabled = false;
            this.mcAscendingIcon.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.sortingIconLoadingCompleteHandler);
            this.visible = false;
            return;
        }

        protected function sortingIconLoadingCompleteHandler(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            this.mcAscendingIcon.y = _height - this.mcAscendingIcon.height;
            this.isSortIconLoadingCompete = true;
            invalidate();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(ASCENDING_ICON_INVALID)) 
            {
                this.mcAscendingIcon.source = this._ascendingIconSource;
            }
            if (isInvalid(DESCENDING_ICON_INVALID)) 
            {
                this.mcDescendingIcon.source = this._descendingIconSource;
            }
            if (this.isSortIconLoadingCompete) 
            {
                this.isSortIconLoadingCompete = false;
                this.visible = true;
                invalidate(SORT_DIRECTION_INVALID, scaleform.clik.constants.InvalidationType.SIZE);
                invalidate();
            }
            if (isInvalid(SORT_DIRECTION_INVALID)) 
            {
                this.applySortDirection();
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                this.bg.width = _width;
                this.bg.height = _height;
                if (this.upperBg) 
                {
                    this.upperBg.width = _width - 2;
                    this.upperBg.height = _height;
                }
            }
            return;
        }

        protected function applySortDirection():void
        {
            if (this._sortDirection != ASCENDING_SORT) 
            {
                if (this._sortDirection != DESCENDING_SORT) 
                {
                    if (this.mcAscendingIcon) 
                    {
                        this.mcAscendingIcon.visible = false;
                    }
                    if (this.mcDescendingIcon) 
                    {
                        this.mcDescendingIcon.visible = false;
                    }
                }
                else 
                {
                    if (this.mcAscendingIcon) 
                    {
                        this.mcAscendingIcon.visible = false;
                    }
                    if (this.mcDescendingIcon) 
                    {
                        this.mcDescendingIcon.visible = true;
                    }
                }
            }
            else 
            {
                if (this.mcAscendingIcon) 
                {
                    this.mcAscendingIcon.visible = true;
                }
                if (this.mcDescendingIcon) 
                {
                    this.mcDescendingIcon.visible = false;
                }
            }
            return;
        }

        internal static const ASCENDING_ICON_INVALID:String="ascIcon";

        internal static const DESCENDING_ICON_INVALID:String="descIcon";

        internal static const SORT_DIRECTION_INVALID:String="checkSortDirection";

        public static const ASCENDING_SORT:String="ascending";

        public static const DESCENDING_SORT:String="descending";

        public static const WITHOUT_SORT:String="none";

        public static const SORT_DIRECTION_CHANGED:String="sortDirectionChanged";

        public static const ASCENDING_ICON_CONSTRAINT_NAME:String="mcAscendingIcon";

        public static const DESCENDING_ICON_CONSTRAINT_NAME:String="mcDescendingIcon";

        public var defaultSortDirection:String="none";

        public var bg:flash.display.MovieClip;

        public var upperBg:flash.display.MovieClip;

        public var mcAscendingIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var mcDescendingIcon:net.wg.gui.components.controls.UILoaderAlt;

        internal var _ascendingIconSource:String;

        internal var _descendingIconSource:String;

        internal var _sortDirection:String;

        protected var isSortIconLoadingCompete:Boolean;

        internal var _id:String;
    }
}
