package net.wg.gui.lobby.sellDialog 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.utils.*;
    
    public class SlidingScrollingList extends scaleform.clik.controls.ScrollingList
    {
        public function SlidingScrollingList()
        {
            super();
            return;
        }

        public function getRenderers():__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.ISaleItemBlockRenderer>
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=new Vector.<net.wg.infrastructure.interfaces.ISaleItemBlockRenderer>();
            var loc5:*=0;
            var loc6:*=_renderers;
            for each (loc2 in loc6) 
            {
                loc3 = net.wg.gui.lobby.sellDialog.SellDialogListItemRenderer(loc2).getRenderers();
                var loc7:*=0;
                var loc8:*=loc3;
                for each (loc4 in loc8) 
                    loc1.push(loc4);
            }
            return loc1;
        }

        public override function get availableWidth():Number
        {
            return Math.round(_width) - margin * 2 - (_autoScrollBar ? Math.round(_scrollBar.width + this.sbPadding) : 0);
        }

        public override function get scrollPosition():Number
        {
            return _scrollPosition;
        }

        public override function set scrollPosition(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=Math.round((this.totalHeight - this._height) / 100 * arg1);
            container.y = -loc1;
            var loc5:*=0;
            var loc6:*=_renderers;
            for each (loc2 in loc6) 
            {
                loc3 = net.wg.gui.lobby.sellDialog.SellDialogListItemRenderer(loc2).getRenderers();
                var loc7:*=0;
                var loc8:*=loc3;
                for each (loc4 in loc8) 
                    net.wg.gui.lobby.sellDialog.SaleItemBlockRenderer(loc4).ddm.close();
            }
            return;
        }

        protected override function configUI():void
        {
            if (container == null) 
            {
                container = new flash.display.Sprite();
                addChild(container);
            }
            tabEnabled = _focusable && enabled;
            tabChildren = false;
            addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.handleMouseWheel, true, 0, true);
            addEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput, false, 0, true);
            if (padding == null) 
                padding = new scaleform.clik.utils.Padding();
            if (_itemRenderer == null && !_usingExternalRenderers) 
                itemRendererName = _itemRendererName;
            this.useHandCursor = false;
            this._defaultListHeight = Math.round(_height);
            this.scrRect = new flash.geom.Rectangle(0, 0, _width, this._defaultListHeight + this.downMargin);
            this.scrollRect = this.scrRect;
            this.upperContainer.mouseEnabled = false;
            this.listVisibleHight = _height + this.downMargin;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            if (isInvalid(scaleform.clik.constants.InvalidationType.SCROLL_BAR)) 
                this.createScrollBar();
            if (isInvalid(scaleform.clik.constants.InvalidationType.RENDERERS)) 
                _autoRowHeight = NaN;
            if (isInvalid(scaleform.clik.constants.InvalidationType.SELECTED_INDEX)) 
                updateSelectedIndex();
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
                if (_newFrame) 
                {
                    gotoAndPlay(_newFrame);
                    _newFrame = null;
                }
            if (!_usingExternalRenderers && isInvalid(scaleform.clik.constants.InvalidationType.RENDERERS)) 
            {
                if (_renderers != null) 
                {
                    loc2 = _renderers.length;
                    loc1 = 0;
                    while (loc1 < loc2) 
                    {
                        loc3 = getRendererAt(loc1);
                        cleanUpRenderer(loc3);
                        loc4 = loc3 as flash.display.DisplayObject;
                        if (container.contains(loc4)) 
                            container.removeChild(loc4);
                        ++loc1;
                    }
                }
                _renderers = new Vector.<scaleform.clik.interfaces.IListItemRenderer>();
                invalidateData();
            }
            if (!_usingExternalRenderers && (isInvalid(scaleform.clik.constants.InvalidationType.SIZE) || isInvalid(scaleform.clik.constants.InvalidationType.DATA))) 
            {
                this.lowerContainer.removeChild(container);
                setActualSize(_width, _height);
                container.scaleX = 1 / scaleX;
                container.scaleY = 1 / scaleY;
                _totalRenderers = dataProvider.length;
                this.lowerContainer.addChild(container);
                invalidateData();
            }
            if (!_usingExternalRenderers && isInvalid(scaleform.clik.constants.InvalidationType.RENDERERS, scaleform.clik.constants.InvalidationType.SIZE)) 
                drawRenderers(_totalRenderers);
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                refreshData();
                this.updateScrollBar();
            }
            return;
        }

        protected override function updateScrollBar():void
        {
            var loc2:*=null;
            this.stepSize = Math.round(20 * this.height / this.totalHeight);
            var loc1:*=Math.round(this.height / this.totalHeight * 100);
            if (_scrollBar == null) 
                return;
            if (_scrollBar is scaleform.clik.controls.ScrollIndicator) 
            {
                loc2 = _scrollBar as scaleform.clik.controls.ScrollIndicator;
                loc2.setScrollProperties(loc1, 0, 100, this.stepSize);
            }
            _scrollBar.position = _scrollPosition;
            _scrollBar.validateNow();
            return;
        }

        protected override function populateData(arg1:Array):void
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
                loc5 = _scrollPosition + loc3;
                loc6 = new scaleform.clik.data.ListData(loc5, itemToLabel(arg1[loc3]), _selectedIndex == loc5);
                loc4.enabled = loc3 >= loc1 ? false : true;
                loc4.setListData(loc6);
                loc4.setData(arg1[loc3]);
                loc4.validateNow();
                ++loc3;
            }
            this.drawLayout();
            return;
        }

        protected override function drawLayout():void
        {
            var loc6:*=null;
            var loc1:*=_renderers.length;
            var loc2:*=8;
            var loc3:*=this.availableWidth - padding.horizontal;
            this.totalHeight = 0;
            var loc4:*=margin + padding.left;
            var loc5:*=isInvalid(scaleform.clik.constants.InvalidationType.DATA);
            var loc7:*=0;
            while (loc7 < loc1) 
            {
                (loc6 = getRendererAt(loc7)).x = loc4;
                if (loc7 != 0) 
                    loc6.y = getRendererAt((loc7 - 1)).y + getRendererAt((loc7 - 1)).height + loc2;
                else 
                    loc6.y = 0;
                this.totalHeight = loc6.y + loc6.height;
                if (!loc5) 
                    loc6.validateNow();
                ++loc7;
            }
            if (this.totalHeight < this.height) 
            {
                if (_scrollBar) 
                {
                    _scrollBar.removeEventListener(flash.events.Event.SCROLL, handleScroll, false);
                    _scrollBar.removeEventListener(flash.events.Event.CHANGE, handleScroll, false);
                    _scrollBar.focusTarget = null;
                    if (this.upperContainer.contains(_scrollBar as flash.display.DisplayObject)) 
                        this.upperContainer.removeChild(_scrollBar as flash.display.DisplayObject);
                    _scrollBar = null;
                    _autoScrollBar = false;
                }
                this.listVisibleHight = this.totalHeight + this.downMargin;
                this.scrRect = new flash.geom.Rectangle(0, 0, _width, this.listVisibleHight);
                this.scrollRect = this.scrRect;
                removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.handleMouseWheel);
            }
            else 
                this.drawScrollBar();
            if (this.totalHeight == 0) 
                this.listVisibleHight = 0;
            var loc8:*=0;
            while (loc8 < loc1) 
            {
                ((loc6 = getRendererAt(loc8)) as scaleform.clik.core.UIComponent).setSize(this.availableWidth, loc6.height);
                ++loc8;
            }
            this.upperContainer.height = this.listVisibleHight;
            dispatchEvent(new net.wg.gui.events.VehicleSellDialogEvent(net.wg.gui.events.VehicleSellDialogEvent.LIST_WAS_DRAWN, this.listVisibleHight));
            return;
        }

        protected override function createScrollBar():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (_scrollBar) 
            {
                _scrollBar.removeEventListener(flash.events.Event.SCROLL, handleScroll, false);
                _scrollBar.removeEventListener(flash.events.Event.CHANGE, handleScroll, false);
                _scrollBar.focusTarget = null;
                if (this.upperContainer.contains(_scrollBar as flash.display.DisplayObject)) 
                    this.upperContainer.removeChild(_scrollBar as flash.display.DisplayObject);
                _scrollBar = null;
            }
            if (!_scrollBarValue || _scrollBarValue == "") 
                return;
            _autoScrollBar = false;
            if (_scrollBarValue is String) 
            {
                if (parent != null) 
                    loc1 = parent.getChildByName(_scrollBarValue.toString()) as scaleform.clik.interfaces.IScrollBar;
                if (loc1 == null) 
                {
                    loc2 = flash.utils.getDefinitionByName(_scrollBarValue.toString()) as Class;
                    if (loc2) 
                        loc1 = new loc2() as scaleform.clik.interfaces.IScrollBar;
                    if (loc1) 
                    {
                        _autoScrollBar = true;
                        loc3 = loc1 as Object;
                        if (loc3 && thumbOffset) 
                        {
                            loc3.offsetTop = thumbOffset.top;
                            loc3.offsetBottom = thumbOffset.bottom;
                        }
                        loc1.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, blockMouseWheel, false, 0, true);
                        this.upperContainer.addChild(loc1 as flash.display.DisplayObject);
                    }
                }
            }
            else if (_scrollBarValue is Class) 
            {
                loc1 = new (_scrollBarValue as Class)() as scaleform.clik.interfaces.IScrollBar;
                loc1.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, blockMouseWheel, false, 0, true);
                if (loc1 != null) 
                {
                    _autoScrollBar = true;
                    (loc1 as Object).offsetTop = thumbOffset.top;
                    (loc1 as Object).offsetBottom = thumbOffset.bottom;
                    this.upperContainer.addChild(loc1 as flash.display.DisplayObject);
                }
            }
            else 
                loc1 = _scrollBarValue as scaleform.clik.interfaces.IScrollBar;
            _scrollBar = loc1;
            invalidateSize();
            if (_scrollBar == null) 
                return;
            _scrollBar.addEventListener(flash.events.Event.SCROLL, handleScroll, false, 0, true);
            _scrollBar.addEventListener(flash.events.Event.CHANGE, handleScroll, false, 0, true);
            _scrollBar.focusTarget = this;
            _scrollBar.tabEnabled = false;
            return;
        }

        protected override function drawScrollBar():void
        {
            if (!_autoScrollBar) 
                return;
            _scrollBar.x = _width - _scrollBar.width - this.sbPadding;
            _scrollBar.y = this.sbPadding;
            _scrollBar.height = availableHeight - this.sbPadding * 2;
            _scrollBar.validateNow();
            return;
        }

        protected override function scrollList(arg1:int):void
        {
            _scrollBar.position = _scrollBar.position - arg1 * this.stepSize;
            _scrollBar.validateNow();
            return;
        }

        protected override function handleMouseWheel(arg1:flash.events.MouseEvent):void
        {
            this.scrollList(arg1.delta > 0 ? 1 : -1);
            arg1.stopImmediatePropagation();
            return;
        }

        public var lowerContainer:flash.display.MovieClip;

        public var upperContainer:flash.display.MovieClip;

        internal var _defaultListHeight:Number;

        internal var listVisibleHight:Number=0;

        internal var scrollingListHeigth:Number=0;

        internal var autoScrollBar:Boolean=true;

        internal var wasResized:Boolean=false;

        internal var eventLengs:Number=0;

        internal var scrRect:flash.geom.Rectangle;

        internal var downMargin:Number=9;

        internal var sbPadding:Number=5;

        internal var stepSize:Number=5;

        internal var totalHeight:Number=0;
    }
}
