package net.wg.gui.components.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.ui.*;
    import scaleform.clik.utils.*;

    public class ScrollingListEx extends net.wg.gui.components.controls.CoreListEx
    {
        public function ScrollingListEx()
        {
            super();
            return;
        }

        protected function updateScrollBar():void
        {
            var loc1:*=null;
            if (this._scrollBar == null)
                return;
            if (this._scrollBar is scaleform.clik.controls.ScrollIndicator)
            {
                loc1 = this._scrollBar as scaleform.clik.controls.ScrollIndicator;
                if (_dataProvider.length > _totalRenderers)
                    loc1.setScrollProperties(_totalRenderers, 0, _dataProvider.length - _totalRenderers);
                else
                    loc1.setScrollProperties(_dataProvider.length - _totalRenderers, 0, _dataProvider.length - _totalRenderers);
            }
            this._scrollBar.position = this._scrollPosition;
            this._scrollBar.validateNow();
            return;
        }

        protected override function changeFocus():void
        {
            super.changeFocus();
            var loc1:*=getRendererAt(_selectedIndex, this._scrollPosition);
            if (loc1 != null)
            {
                loc1.displayFocus = focused > 0;
                loc1.validateNow();
            }
            return;
        }

        protected override function refreshData():void
        {
            this._scrollPosition = Math.min(Math.max(0, _dataProvider.length - _totalRenderers), this._scrollPosition);
            this.selectedIndex = Math.min((_dataProvider.length - 1), _selectedIndex);
            this.updateSelectedIndex();
            _dataProvider.requestItemRange(this._scrollPosition, Math.min((_dataProvider.length - 1), (this._scrollPosition + _totalRenderers - 1)), this.populateData);
            return;
        }

        protected override function updateSelectedIndex():void
        {
            if (_selectedIndex == _newSelectedIndex)
                return;
            if (_totalRenderers == 0)
                return;
            var loc1:*=getRendererAt(_selectedIndex, this.scrollPosition);
            if (loc1 != null)
            {
                loc1.selected = false;
                loc1.validateNow();
            }
            super.selectedIndex = _newSelectedIndex;
            if (_selectedIndex < 0 || _selectedIndex >= _dataProvider.length)
                return;
            loc1 = getRendererAt(_selectedIndex, this._scrollPosition);
            if (loc1 == null)
            {
                this.scrollToIndex(_selectedIndex);
                loc1 = getRendererAt(_selectedIndex, this.scrollPosition);
                loc1.selected = true;
                loc1.validateNow();
            }
            else
            {
                loc1.selected = true;
                loc1.validateNow();
            }
            return;
        }

        protected override function calculateRendererTotal(arg1:Number, arg2:Number):uint
        {
            var loc1:*=null;
            if (isNaN(this._rowHeight) && isNaN(this._autoRowHeight))
            {
                loc1 = createRenderer(0);
                this._autoRowHeight = Math.round(loc1.height);
                cleanUpRenderer(loc1);
            }
            return (this.availableHeight - this.padding.vertical) / this.rowHeight >> 0;
        }

        public function set rowCount(arg1:uint):void
        {
            var loc1:*=this.rowHeight;
            if (isNaN(this.rowHeight))
                this.calculateRendererTotal(this.availableWidth, this.availableHeight);
            loc1 = this.rowHeight;
            height = loc1 * arg1 + this.margin * 2 + this.padding.vertical;
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
                loc4 = getRendererAt(loc3);
                loc5 = this._scrollPosition + loc3;
                loc6 = new scaleform.clik.data.ListData(loc5, itemToLabel(arg1[loc3]), _selectedIndex == loc5);
                loc4.enabled = loc3 >= loc1 ? false : true;
                loc4.setListData(loc6);
                loc4.setData(arg1[loc3]);
                loc4.validateNow();
                ++loc3;
            }
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

        public function disposeRenderers():void
        {
            var loc2:*=NaN;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=_renderers ? _renderers.length : 0;
            var loc6:*=App.utils.commons;
            --loc2;
            while (loc2 >= 0)
            {
                loc3 = getRendererAt(loc2);
                if (loc3 != null)
                {
                    cleanUpRenderer(loc3);
                    loc4 = loc3 as net.wg.infrastructure.interfaces.entity.IDisposable;
                    if (loc4)
                    {
                        loc4.dispose();
                        loc6.releaseReferences(loc4);
                    }
                    loc5 = loc3 as flash.display.DisplayObject;
                    if (container.contains(loc5))
                    {
                        loc6.releaseReferences(loc5);
                        container.removeChild(loc5);
                    }
                }
                _renderers.splice(loc2, 1);
                --loc2;
            }
            if (this._scrollBar)
            {
                this._scrollBar.removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.blockMouseWheel, false);
                this._scrollBar.removeEventListener(flash.events.Event.SCROLL, this.handleScroll, false);
                this._scrollBar.removeEventListener(flash.events.Event.CHANGE, this.handleScroll, false);
                this._scrollBar.focusTarget = null;
                this._scrollBar.dispose();
                loc6.releaseReferences(this._scrollBar);
                this._scrollBar = null;
            }
            if (container)
            {
                loc6.releaseReferences(container);
                removeChild(container);
                container = null;
            }
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, handleMouseWheel, false);
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false);
            this.cleanData();
            this.disposeRenderers();
            this.thumbOffset = null;
            this._padding = null;
            this._scrollBarValue = null;
            super.dispose();
            return;
        }

        protected function cleanData():void
        {
            if (_dataProvider)
            {
                _dataProvider.removeEventListener(flash.events.Event.CHANGE, handleDataChange, false);
                _dataProvider.cleanUp();
                _dataProvider = null;
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
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
                return;
            this.padding = new scaleform.clik.utils.Padding(arg1.top, arg1.right, arg1.bottom, arg1.left);
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

        public function get scrollPosition():Number
        {
            return this._scrollPosition;
        }

        public function set scrollPosition(arg1:Number):void
        {
            arg1 = Math.max(0, Math.min(_dataProvider.length - _totalRenderers, Math.round(arg1)));
            if (this._scrollPosition == arg1)
                return;
            this._scrollPosition = arg1;
            invalidateData();
            return;
        }

        public override function set selectedIndex(arg1:int):void
        {
            if (arg1 == _selectedIndex || arg1 == _newSelectedIndex)
                return;
            _newSelectedIndex = arg1;
            invalidateSelectedIndex();
            return;
        }

        public function get rowCount():uint
        {
            return _totalRenderers;
        }

        protected function handleScroll(arg1:flash.events.Event):void
        {
            this.scrollPosition = this._scrollBar.position;
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
                    return;
            }
            this._rowHeight = arg1;
            this._autoRowHeight = NaN;
            invalidateSize();
            return;
        }

        public override function get availableWidth():Number
        {
            return Math.round(_width) - this.margin * 2 - (this._autoScrollBar ? Math.round(this._scrollBar.width) : 0);
        }

        public override function get availableHeight():Number
        {
            return Math.round(_height) - this.margin * 2;
        }

        public override function scrollToIndex(arg1:uint):void
        {
            if (_totalRenderers == 0)
                return;
            if (arg1 >= this._scrollPosition && arg1 < this._scrollPosition + _totalRenderers)
                return;
            if (arg1 < this._scrollPosition)
                this.scrollPosition = arg1;
            else
                this.scrollPosition = arg1 - (_totalRenderers - 1);
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.handled)
                return;
            var loc1:*=getRendererAt(_selectedIndex, this._scrollPosition);
            if (loc1 != null)
            {
                loc1.handleInput(arg1);
                if (arg1.handled)
                    return;
            }
            var loc2:*=arg1.details;
            var loc3:*=loc2.value == scaleform.clik.constants.InputValue.KEY_DOWN || loc2.value == scaleform.clik.constants.InputValue.KEY_HOLD;
            var loc4:*=loc2.navEquivalent;
            switch (loc4)
            {
                case scaleform.clik.constants.NavigationCode.UP:
                    if (selectedIndex != -1)
                        if (_selectedIndex > 0)
                            if (loc3)
                                selectedIndex--;
                        else if (this.wrapping != scaleform.clik.constants.WrappingMode.STICK)
                            if (this.wrapping != scaleform.clik.constants.WrappingMode.WRAP)
                                return;
                            else if (loc3)
                                this.selectedIndex = (_dataProvider.length - 1);
                    else if (loc3)
                        this.selectedIndex = (this.scrollPosition + _totalRenderers - 1);
                    break;
                case scaleform.clik.constants.NavigationCode.DOWN:
                    if (_selectedIndex != -1)
                        if (_selectedIndex < (_dataProvider.length - 1))
                            if (loc3)
                                selectedIndex++;
                        else if (this.wrapping != scaleform.clik.constants.WrappingMode.STICK)
                            if (this.wrapping != scaleform.clik.constants.WrappingMode.WRAP)
                                return;
                            else if (loc3)
                                this.selectedIndex = 0;
                    else if (loc3)
                        this.selectedIndex = this._scrollPosition;
                    break;
                case scaleform.clik.constants.NavigationCode.END:
                    if (!loc3)
                        this.selectedIndex = (_dataProvider.length - 1);
                    break;
                case scaleform.clik.constants.NavigationCode.HOME:
                    if (!loc3)
                        this.selectedIndex = 0;
                    break;
                case scaleform.clik.constants.NavigationCode.PAGE_UP:
                    if (loc3)
                        this.selectedIndex = Math.max(0, _selectedIndex - _totalRenderers);
                    break;
                case scaleform.clik.constants.NavigationCode.PAGE_DOWN:
                    if (loc3)
                        this.selectedIndex = Math.min((_dataProvider.length - 1), _selectedIndex + _totalRenderers);
                    break;
                default:
                    return;
            }
            arg1.handled = true;
            return;
        }

        public override function toString():String
        {
            return "[WG ScrollingListEx " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            if (this.padding == null)
                this.padding = new scaleform.clik.utils.Padding();
            if (_itemRenderer == null && !_usingExternalRenderers)
                itemRendererName = _itemRendererName;
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.SCROLL_BAR))
                this.createScrollBar();
            if (isInvalid(scaleform.clik.constants.InvalidationType.RENDERERS))
                this._autoRowHeight = NaN;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA))
                this.updateScrollBar();
            return;
        }

        protected override function drawLayout():void
        {
            var loc8:*=null;
            var loc1:*=_renderers.length;
            var loc2:*=this.rowHeight;
            var loc3:*=this.availableWidth - this.padding.horizontal;
            var loc4:*=this.margin + this.padding.left;
            var loc5:*=this.margin + this.padding.top;
            var loc6:*=isInvalid(scaleform.clik.constants.InvalidationType.DATA);
            var loc7:*=0;
            while (loc7 < loc1)
            {
                (loc8 = getRendererAt(loc7)).x = Math.round(loc4);
                loc8.y = Math.round(loc5 + loc7 * loc2);
                loc8.width = loc3;
                loc8.height = loc2;
                if (!loc6)
                    loc8.validateNow();
                ++loc7;
            }
            this.drawScrollBar();
            return;
        }

        protected function createScrollBar():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (this._scrollBar)
            {
                this._scrollBar.removeEventListener(flash.events.Event.SCROLL, this.handleScroll, false);
                this._scrollBar.removeEventListener(flash.events.Event.CHANGE, this.handleScroll, false);
                this._scrollBar.focusTarget = null;
                if (container.contains(this._scrollBar as flash.display.DisplayObject))
                    container.removeChild(this._scrollBar as flash.display.DisplayObject);
                this._scrollBar = null;
            }
            if (!this._scrollBarValue || this._scrollBarValue == "")
                return;
            this._autoScrollBar = false;
            if (this._scrollBarValue is String)
            {
                if (parent != null)
                    loc1 = parent.getChildByName(this._scrollBarValue.toString()) as scaleform.clik.interfaces.IScrollBar;
                if (loc1 == null)
                {
                    loc2 = flash.utils.getDefinitionByName(this._scrollBarValue.toString()) as Class;
                    if (loc2)
                        loc1 = new loc2() as scaleform.clik.interfaces.IScrollBar;
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
                loc1 = this._scrollBarValue as scaleform.clik.interfaces.IScrollBar;
            this._scrollBar = loc1;
            invalidateSize();
            if (this._scrollBar == null)
                return;
            this._scrollBar.addEventListener(flash.events.Event.SCROLL, this.handleScroll, false, 0, true);
            this._scrollBar.addEventListener(flash.events.Event.CHANGE, this.handleScroll, false, 0, true);
            this._scrollBar.focusTarget = this;
            this._scrollBar.tabEnabled = false;
            return;
        }

        protected function drawScrollBar():void
        {
            if (!this._autoScrollBar)
                return;
            this._scrollBar.x = _width - this._scrollBar.width - this.margin;
            this._scrollBar.y = this.margin;
            this._scrollBar.height = this.availableHeight;
            this._scrollBar.validateNow();
            return;
        }

        public var wrapping:String="normal";

        public var thumbOffset:Object;

        public var thumbSizeFactor:Number=1;

        protected var _rowHeight:Number=NaN;

        protected var _autoRowHeight:Number=NaN;

        protected var _scrollPosition:uint=0;

        protected var _autoScrollBar:Boolean=false;

        protected var _scrollBarValue:Object;

        protected var _margin:Number=0;

        protected var _padding:scaleform.clik.utils.Padding;

        protected var _scrollBar:scaleform.clik.interfaces.IScrollBar;

        protected var _rowCount:Number=NaN;
    }
}
