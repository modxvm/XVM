package scaleform.clik.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.ui.*;
    import scaleform.clik.utils.*;
    
    public class TileList extends scaleform.clik.controls.CoreList
    {
        public function TileList()
        {
            super();
            return;
        }

        public override function getRendererAt(arg1:uint, arg2:int=0):scaleform.clik.interfaces.IListItemRenderer
        {
            if (_renderers == null) 
            {
                return null;
            }
            var loc1:*=arg1 - arg2 * (this._direction != scaleform.clik.constants.DirectionMode.HORIZONTAL ? this._totalColumns : this._totalRows);
            if (loc1 >= _renderers.length) 
            {
                return null;
            }
            return _renderers[loc1] as scaleform.clik.interfaces.IListItemRenderer;
        }

        public override function scrollToIndex(arg1:uint):void
        {
            if (_totalRenderers == 0) 
            {
                return;
            }
            var loc1:*=this._direction != scaleform.clik.constants.DirectionMode.HORIZONTAL ? this._totalColumns : this._totalRows;
            var loc2:*=this._scrollPosition * loc1;
            if (loc1 == 0) 
            {
                return;
            }
            if (arg1 >= loc2 && arg1 < loc2 + this._totalRows * this._totalColumns) 
            {
                return;
            }
            if (arg1 < loc2) 
            {
                this.scrollPosition = arg1 / loc1 >> 0;
            }
            else 
            {
                this.scrollPosition = Math.floor(arg1 / loc1) - (this._direction != scaleform.clik.constants.DirectionMode.HORIZONTAL ? this._totalRows : this._totalColumns) + 1;
            }
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.handled) 
            {
                return;
            }
            var loc1:*=this.getRendererAt(_selectedIndex, this._scrollPosition);
            if (loc1 != null) 
            {
                loc1.handleInput(arg1);
                if (arg1.handled) 
                {
                    return;
                }
            }
            var loc2:*=arg1.details;
            var loc3:*=loc2.value == scaleform.clik.constants.InputValue.KEY_DOWN || loc2.value == scaleform.clik.constants.InputValue.KEY_HOLD;
            var loc4:*=int.MIN_VALUE;
            var loc5:*=loc2.navEquivalent;
            if (this._direction != scaleform.clik.constants.DirectionMode.HORIZONTAL) 
            {
                loc6 = loc5;
                switch (loc6) 
                {
                    case scaleform.clik.constants.NavigationCode.DOWN:
                    {
                        loc4 = _selectedIndex + this._totalColumns;
                        break;
                    }
                    case scaleform.clik.constants.NavigationCode.UP:
                    {
                        loc4 = _selectedIndex - this._totalColumns;
                        break;
                    }
                    case scaleform.clik.constants.NavigationCode.LEFT:
                    {
                        loc4 = (_selectedIndex - 1);
                        break;
                    }
                    case scaleform.clik.constants.NavigationCode.RIGHT:
                    {
                        loc4 = _selectedIndex + 1;
                        break;
                    }
                }
            }
            else 
            {
                var loc6:*=loc5;
                switch (loc6) 
                {
                    case scaleform.clik.constants.NavigationCode.RIGHT:
                    {
                        loc4 = _selectedIndex + this._totalRows;
                        break;
                    }
                    case scaleform.clik.constants.NavigationCode.LEFT:
                    {
                        loc4 = _selectedIndex - this._totalRows;
                        break;
                    }
                    case scaleform.clik.constants.NavigationCode.UP:
                    {
                        loc4 = (_selectedIndex - 1);
                        break;
                    }
                    case scaleform.clik.constants.NavigationCode.DOWN:
                    {
                        loc4 = _selectedIndex + 1;
                        break;
                    }
                }
            }
            if (loc4 == int.MIN_VALUE) 
            {
                loc6 = loc5;
                switch (loc6) 
                {
                    case scaleform.clik.constants.NavigationCode.HOME:
                    {
                        loc4 = 0;
                        break;
                    }
                    case scaleform.clik.constants.NavigationCode.END:
                    {
                        loc4 = (_dataProvider.length - 1);
                        break;
                    }
                    case scaleform.clik.constants.NavigationCode.PAGE_DOWN:
                    {
                        loc4 = Math.min((_dataProvider.length - 1), _selectedIndex + this._totalColumns * this._totalRows);
                        break;
                    }
                    case scaleform.clik.constants.NavigationCode.PAGE_UP:
                    {
                        loc4 = Math.max(0, _selectedIndex - this._totalColumns * this._totalRows);
                        break;
                    }
                }
            }
            if (loc4 != int.MIN_VALUE) 
            {
                if (!loc3) 
                {
                    arg1.handled = true;
                    return;
                }
                if (loc4 >= 0 && loc4 < dataProvider.length) 
                {
                    this.selectedIndex = Math.max(0, Math.min((_dataProvider.length - 1), loc4));
                    arg1.handled = true;
                }
                else if (this.wrapping != scaleform.clik.constants.WrappingMode.STICK) 
                {
                    if (this.wrapping == scaleform.clik.constants.WrappingMode.WRAP) 
                    {
                        this.selectedIndex = loc4 < 0 ? (_dataProvider.length - 1) : selectedIndex < (_dataProvider.length - 1) ? (_dataProvider.length - 1) : 0;
                        arg1.handled = true;
                    }
                }
                else 
                {
                    loc4 = Math.max(0, Math.min((_dataProvider.length - 1), loc4));
                    if (selectedIndex != loc4) 
                    {
                        this.selectedIndex = loc4;
                    }
                    arg1.handled = true;
                }
            }
            return;
        }

        public override function toString():String
        {
            return "[CLIK TileList " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            if (this.padding == null) 
            {
                this.padding = new scaleform.clik.utils.Padding();
            }
            if (_itemRenderer == null && !_usingExternalRenderers) 
            {
                itemRendererName = _itemRendererName;
            }
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.SCROLL_BAR)) 
            {
                this.createScrollBar();
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.RENDERERS)) 
            {
                this._autoRowHeight = NaN;
                this._autoColumnWidth = NaN;
                if (_usingExternalRenderers) 
                {
                    this._totalColumns = this.externalColumnCount != 0 ? this.externalColumnCount : 1;
                    this._totalRows = Math.ceil(_renderers.length / this._totalColumns);
                }
            }
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.updateScrollBar();
            }
            return;
        }

        public function get direction():String
        {
            return this._direction;
        }

        protected function createScrollBar():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (this._scrollBar) 
            {
                this._scrollBar.removeEventListener(flash.events.Event.SCROLL, this.handleScroll);
                this._scrollBar.removeEventListener(flash.events.Event.CHANGE, this.handleScroll);
                this._scrollBar.focusTarget = null;
                if (container.contains(this._scrollBar as flash.display.DisplayObject)) 
                {
                    container.removeChild(this._scrollBar as flash.display.DisplayObject);
                }
                this._scrollBar = null;
            }
            if (!this._scrollBarValue || this._scrollBarValue == "") 
            {
                return;
            }
            this._autoScrollBar = false;
            if (this._scrollBarValue is String) 
            {
                if (parent != null) 
                {
                    loc1 = parent.getChildByName(this._scrollBarValue.toString()) as scaleform.clik.interfaces.IScrollBar;
                }
                if (loc1 == null) 
                {
                    loc2 = flash.utils.getDefinitionByName(this._scrollBarValue.toString()) as Class;
                    if (loc2) 
                    {
                        loc1 = new loc2() as scaleform.clik.interfaces.IScrollBar;
                    }
                    if (loc1) 
                    {
                        this._autoScrollBar = true;
                        loc3 = loc1 as Object;
                        if (loc3 && this.thumbOffset) 
                        {
                            loc3.offsetTop = this.thumbOffset.top;
                            loc3.offsetBottom = this.thumbOffset.bottom;
                        }
                        loc1.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.blockMouseWheel, false, 0, true);
                        container.addChild(loc1 as flash.display.DisplayObject);
                    }
                }
            }
            else if (this._scrollBarValue is Class) 
            {
                loc1 = new (this._scrollBarValue as Class)() as scaleform.clik.interfaces.IScrollBar;
                loc1.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.blockMouseWheel, false, 0, true);
                if (loc1 != null) 
                {
                    this._autoScrollBar = true;
                    (loc1 as Object).offsetTop = this.thumbOffset.top;
                    (loc1 as Object).offsetBottom = this.thumbOffset.bottom;
                    container.addChild(loc1 as flash.display.DisplayObject);
                }
            }
            else 
            {
                loc1 = this._scrollBarValue as scaleform.clik.interfaces.IScrollBar;
            }
            this._scrollBar = loc1;
            this._siWidth = this._scrollBar.width;
            invalidateSize();
            if (this._scrollBar == null) 
            {
                return;
            }
            this._scrollBar.addEventListener(flash.events.Event.SCROLL, this.handleScroll, false, 0, true);
            this._scrollBar.addEventListener(flash.events.Event.CHANGE, this.handleScroll, false, 0, true);
            this._scrollBar.focusTarget = this;
            this._scrollBar.tabEnabled = false;
            return;
        }

        protected override function calculateRendererTotal(arg1:Number, arg2:Number):uint
        {
            var loc3:*=null;
            var loc1:*=isNaN(this._rowHeight) && isNaN(this._autoRowHeight);
            var loc2:*=isNaN(this._columnWidth) && isNaN(this._autoColumnWidth);
            if (loc1 || loc2) 
            {
                loc3 = createRenderer(0);
                if (loc1) 
                {
                    this._autoRowHeight = loc3.height;
                }
                if (loc2) 
                {
                    this._autoColumnWidth = loc3.width;
                }
                cleanUpRenderer(loc3);
            }
            this._totalRows = this.availableHeight / this.rowHeight >> 0;
            this._totalColumns = this.availableWidth / this.columnWidth >> 0;
            _totalRenderers = this._totalRows * this._totalColumns;
            return _totalRenderers;
        }

        protected override function updateSelectedIndex():void
        {
            if (_selectedIndex == _newSelectedIndex) 
            {
                return;
            }
            if (_totalRenderers == 0) 
            {
                return;
            }
            var loc1:*=this.getRendererAt(_selectedIndex, this.scrollPosition);
            if (loc1 != null) 
            {
                loc1.selected = false;
                loc1.validateNow();
            }
            super.selectedIndex = _newSelectedIndex;
            if (_selectedIndex < 0 || _selectedIndex >= _dataProvider.length) 
            {
                return;
            }
            loc1 = this.getRendererAt(_selectedIndex, this._scrollPosition);
            if (loc1 == null) 
            {
                this.scrollToIndex(_selectedIndex);
                loc1 = this.getRendererAt(_selectedIndex, this.scrollPosition);
                if (loc1) 
                {
                    loc1.selected = true;
                    loc1.validateNow();
                }
            }
            else 
            {
                loc1.selected = true;
                loc1.validateNow();
            }
            return;
        }

        protected override function refreshData():void
        {
            var loc1:*=this._direction != scaleform.clik.constants.DirectionMode.HORIZONTAL ? this._totalColumns : this._totalRows;
            var loc2:*=Math.ceil(_dataProvider.length / loc1);
            var loc3:*=loc2 - (this._direction != scaleform.clik.constants.DirectionMode.HORIZONTAL ? this._totalRows : this._totalColumns);
            this._scrollPosition = Math.max(0, Math.min(loc3, this._scrollPosition));
            var loc4:*;
            var loc5:*=((loc4 = this._scrollPosition * loc1) + this._totalColumns * this._totalRows - 1);
            this.selectedIndex = Math.min((_dataProvider.length - 1), _selectedIndex);
            this.updateSelectedIndex();
            _dataProvider.requestItemRange(loc4, loc5, this.populateData);
            return;
        }

        protected override function changeFocus():void
        {
            super.changeFocus();
            var loc1:*=this.getRendererAt(_selectedIndex, this._scrollPosition);
            if (loc1 != null) 
            {
                loc1.displayFocus = focused > 0;
                loc1.validateNow();
            }
            return;
        }

        protected function populateData(arg1:Array):void
        {
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=null;
            var loc1:*=arg1.length;
            var loc2:*=_renderers.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = this.getRendererAt(loc3);
                loc5 = this._scrollPosition * (this._direction != scaleform.clik.constants.DirectionMode.HORIZONTAL ? this._totalColumns : this._totalRows) + loc3;
                loc6 = new scaleform.clik.data.ListData(loc5, itemToLabel(arg1[loc3]), _selectedIndex == loc5);
                loc4.enabled = loc3 >= loc1 ? false : true;
                loc4.setListData(loc6);
                loc4.setData(arg1[loc3]);
                loc4.validateNow();
                ++loc3;
            }
            return;
        }

        protected function drawScrollBar():void
        {
            if (!this._autoScrollBar) 
            {
                return;
            }
            var loc1:*=this._scrollBar as scaleform.clik.controls.ScrollIndicator;
            loc1.direction = this._direction;
            if (this._direction != scaleform.clik.constants.DirectionMode.VERTICAL) 
            {
                loc1.rotation = -90;
                loc1.x = this.margin;
                loc1.y = _height - this.margin;
                loc1.width = this.availableWidth + this.padding.horizontal;
            }
            else 
            {
                loc1.rotation = 0;
                loc1.x = _width - loc1.width + this.margin;
                loc1.y = this.margin;
                loc1.height = this.availableHeight + this.padding.vertical;
            }
            this._scrollBar.validateNow();
            return;
        }

        protected function updateScrollBar():void
        {
            var loc1:*=NaN;
            var loc2:*=null;
            if (this._scrollBar == null) 
            {
                return;
            }
            if (this.direction != scaleform.clik.constants.DirectionMode.HORIZONTAL) 
            {
                loc1 = Math.ceil(_dataProvider.length / this._totalColumns) - this._totalRows;
            }
            else 
            {
                loc1 = Math.ceil(_dataProvider.length / this._totalRows) - this._totalColumns;
            }
            if (this._scrollBar is scaleform.clik.controls.ScrollIndicator) 
            {
                loc2 = this._scrollBar as scaleform.clik.controls.ScrollIndicator;
                loc2.setScrollProperties(this._direction != scaleform.clik.constants.DirectionMode.HORIZONTAL ? this._totalRows : this._totalColumns, 0, loc1);
            }
            this._scrollBar.position = this._scrollPosition;
            this._scrollBar.validateNow();
            return;
        }

        protected function handleScroll(arg1:flash.events.Event):void
        {
            this.scrollPosition = this._scrollBar.position;
            return;
        }

        protected override function scrollList(arg1:int):void
        {
            this.scrollPosition = this.scrollPosition - arg1;
            return;
        }

        protected function blockMouseWheel(arg1:flash.events.MouseEvent):void
        {
            arg1.stopPropagation();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            return;
        }

        public function get scrollBar():Object
        {
            return this._scrollBar;
        }

        public function set scrollBar(arg1:Object):void
        {
            this._scrollBarValue = arg1;
            invalidate(scaleform.clik.constants.InvalidationType.SCROLL_BAR);
            return;
        }

        public function get rowHeight():Number
        {
            return isNaN(this._autoRowHeight) ? this._rowHeight : this._autoRowHeight;
        }

        public function set rowHeight(arg1:Number):void
        {
            if (arg1 == 0) 
            {
                arg1 = NaN;
                if (_inspector) 
                {
                    return;
                }
            }
            this._rowHeight = arg1;
            this._autoRowHeight = NaN;
            invalidateSize();
            return;
        }

        public function get columnWidth():Number
        {
            return isNaN(this._autoColumnWidth) ? this._columnWidth : this._autoColumnWidth;
        }

        public function set columnWidth(arg1:Number):void
        {
            if (arg1 == 0) 
            {
                arg1 = NaN;
                if (_inspector) 
                {
                    return;
                }
            }
            this._columnWidth = arg1;
            this._autoColumnWidth = NaN;
            invalidateSize();
            return;
        }

        public function get rowCount():uint
        {
            return this._totalRows;
        }

        public function set rowCount(arg1:uint):void
        {
            var loc1:*=this.rowHeight;
            if (isNaN(loc1)) 
            {
                this.calculateRendererTotal(this.availableWidth, this.availableHeight);
                loc1 = this.rowHeight;
            }
            height = loc1 * arg1 + this.margin * 2 + this.padding.vertical + (this._direction == scaleform.clik.constants.DirectionMode.HORIZONTAL && this._autoScrollBar ? Math.round(this._siWidth) : 0);
            return;
        }

        public function get columnCount():uint
        {
            return this._totalColumns;
        }

        public function set columnCount(arg1:uint):void
        {
            var loc1:*=this.columnWidth;
            if (isNaN(loc1)) 
            {
                this.calculateRendererTotal(this.availableWidth, this.availableHeight);
                loc1 = this.columnWidth;
            }
            width = loc1 * arg1 + this.margin * 2 + this.padding.horizontal + (this._direction == scaleform.clik.constants.DirectionMode.VERTICAL && this._autoScrollBar ? Math.round(this._siWidth) : 0);
            return;
        }

        protected override function drawLayout():void
        {
            var loc8:*=null;
            var loc1:*=_renderers.length;
            var loc2:*=this.rowHeight;
            var loc3:*=this.columnWidth;
            var loc4:*=this.margin + this.padding.left;
            var loc5:*=this.margin + this.padding.top;
            var loc6:*=isInvalid(scaleform.clik.constants.InvalidationType.DATA);
            var loc7:*=0;
            while (loc7 < loc1) 
            {
                loc8 = this.getRendererAt(loc7);
                if (this.direction != scaleform.clik.constants.DirectionMode.VERTICAL) 
                {
                    loc8.x = loc7 % this._totalColumns * loc3 + loc4;
                    loc8.y = (loc7 / this._totalColumns >> 0) * loc2 + loc5;
                }
                else 
                {
                    loc8.y = loc7 % this._totalRows * loc2 + loc5;
                    loc8.x = (loc7 / this._totalRows >> 0) * loc3 + loc4;
                }
                loc8.width = loc3;
                loc8.height = loc2;
                if (!loc6) 
                {
                    loc8.validateNow();
                }
                ++loc7;
            }
            this.drawScrollBar();
            return;
        }

        public function set direction(arg1:String):void
        {
            if (arg1 == this._direction) 
            {
                return;
            }
            this._direction = arg1;
            invalidate();
            return;
        }

        public override function set selectedIndex(arg1:int):void
        {
            if (arg1 == _selectedIndex || arg1 == _newSelectedIndex) 
            {
                return;
            }
            _newSelectedIndex = arg1;
            invalidateSelectedIndex();
            return;
        }

        public function get margin():Number
        {
            return this._margin;
        }

        public function set margin(arg1:Number):void
        {
            this._margin = arg1;
            invalidateSize();
            return;
        }

        public function get padding():scaleform.clik.utils.Padding
        {
            return this._padding;
        }

        public function set padding(arg1:scaleform.clik.utils.Padding):void
        {
            this._padding = arg1;
            invalidateSize();
            return;
        }

        public function set inspectablePadding(arg1:Object):void
        {
            if (!componentInspectorSetting) 
            {
                return;
            }
            this.padding = new scaleform.clik.utils.Padding(arg1.top, arg1.right, arg1.bottom, arg1.left);
            return;
        }

        public override function get availableWidth():Number
        {
            return Math.round(_width) - this.padding.horizontal - this.margin * 2 - (this._direction == scaleform.clik.constants.DirectionMode.VERTICAL && this._autoScrollBar ? Math.round(this._siWidth) : 0);
        }

        public override function get availableHeight():Number
        {
            return Math.round(_height) - this.padding.vertical - this.margin * 2 - (this._direction == scaleform.clik.constants.DirectionMode.HORIZONTAL && this._autoScrollBar ? Math.round(this._siWidth) : 0);
        }

        public function get scrollPosition():Number
        {
            return this._scrollPosition;
        }

        public function set scrollPosition(arg1:Number):void
        {
            var loc1:*=Math.ceil((_dataProvider.length - this._totalRows * this._totalColumns) / (this._direction != scaleform.clik.constants.DirectionMode.HORIZONTAL ? this._totalColumns : this._totalRows));
            arg1 = Math.max(0, Math.min(loc1, Math.round(arg1)));
            if (this._scrollPosition == arg1) 
            {
                return;
            }
            this._scrollPosition = arg1;
            invalidateData();
            return;
        }

        public var wrapping:String="normal";

        public var thumbOffset:Object;

        public var thumbSizeFactor:Number=1;

        public var externalColumnCount:Number=0;

        protected var _rowHeight:Number=NaN;

        protected var _autoRowHeight:Number=NaN;

        protected var _columnWidth:Number=NaN;

        protected var _autoColumnWidth:Number=NaN;

        protected var _totalColumns:uint=0;

        protected var _scrollPosition:uint=0;

        protected var _autoScrollBar:Boolean=false;

        protected var _scrollBarValue:Object;

        protected var _margin:Number=0;

        protected var _padding:scaleform.clik.utils.Padding;

        protected var _direction:String="horizontal";

        protected var _siWidth:Number=0;

        protected var _scrollBar:scaleform.clik.interfaces.IScrollBar;

        protected var _totalRows:Number=0;
    }
}
