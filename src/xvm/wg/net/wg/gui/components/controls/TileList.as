package net.wg.gui.components.controls
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;

    public class TileList extends scaleform.clik.controls.TileList
    {
        public function TileList()
        {
            super();
            componentInspectorSetting = true;
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
                loc5 = _scrollPosition * (_direction != scaleform.clik.constants.DirectionMode.HORIZONTAL ? _totalColumns : _totalRows) + loc3;
                loc6 = new scaleform.clik.data.ListData(loc5, itemToLabel(arg1[loc3]), _selectedIndex == loc5);
                loc4.setListData(loc6);
                loc4.setData(arg1[loc3]);
                if (loc3 >= loc1)
                    loc4.enabled = false;
                else if (arg1[loc3].hasOwnProperty("enabled"))
                    loc4.enabled = arg1[loc3].enabled;
                else
                    loc4.enabled = true;
                loc4.validateNow();
                if (!this.showEmptyItems)
                    scaleform.clik.core.UIComponent(loc4).visible = !(arg1[loc3] == null);
                ++loc3;
            }
            return;
        }

        protected override function drawLayout():void
        {
            var loc8:*=null;
            var loc1:*=_renderers.length;
            var loc2:*=rowHeight;
            var loc3:*=columnWidth;
            var loc4:*=margin + padding.left;
            var loc5:*=margin + padding.top;
            var loc6:*=isInvalid(scaleform.clik.constants.InvalidationType.DATA);
            var loc7:*=0;
            while (loc7 < loc1)
            {
                loc8 = getRendererAt(loc7);
                if (direction != scaleform.clik.constants.DirectionMode.HORIZONTAL)
                {
                    loc8.x = loc7 % _totalColumns * (loc3 + this.paddingRight + padding.right) + margin + padding.left;
                    loc8.y = (loc7 / _totalColumns >> 0) * (loc2 + this.paddingBottom + padding.bottom) + margin + padding.top;
                }
                else
                {
                    loc8.y = loc7 % _totalRows * (loc2 + this.paddingBottom + padding.bottom) + margin + padding.top;
                    loc8.x = (loc7 / _totalRows >> 0) * (loc3 + this.paddingRight + padding.right) + margin + padding.left;
                }
                if (!loc6)
                    loc8.validateNow();
                ++loc7;
            }
            drawScrollBar();
            return;
        }

        protected override function cleanUpRenderer(arg1:scaleform.clik.interfaces.IListItemRenderer):void
        {
            super.cleanUpRenderer(arg1);
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, handleMouseWheel, false);
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput, false);
            this.disposeRenderers();
            if (_scrollBar)
            {
                _scrollBar.removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, blockMouseWheel, false);
                _scrollBar.removeEventListener(flash.events.Event.SCROLL, handleScroll, false);
                _scrollBar.removeEventListener(flash.events.Event.CHANGE, handleScroll, false);
                _scrollBar.focusTarget = null;
                _scrollBar.dispose();
                if (container.contains(flash.display.DisplayObject(_scrollBar)))
                    container.removeChild(flash.display.DisplayObject(_scrollBar));
                _scrollBar = null;
            }
            if (_dataProvider)
            {
                _dataProvider.removeEventListener(flash.events.Event.CHANGE, handleDataChange, false);
                _dataProvider.cleanUp();
                _dataProvider = null;
            }
            if (container && contains(container))
            {
                removeChild(container);
                container = null;
            }
            thumbOffset = null;
            _padding = null;
            super.dispose();
            return;
        }

        public function disposeRenderers():void
        {
            var loc3:*=NaN;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc1:*=App.utils.commons;
            var loc2:*=_renderers.length;
            --loc3;
            while (loc3 >= 0)
            {
                if ((loc4 = getRendererAt(loc3)) != null)
                {
                    this.cleanUpRenderer(loc4);
                    loc5 = loc4 as net.wg.infrastructure.interfaces.entity.IDisposable;
                    if (loc5)
                        loc5.dispose();
                    loc6 = loc4 as flash.display.DisplayObject;
                    loc1.releaseReferences(loc6);
                    if (container.contains(loc6))
                        container.removeChild(loc6);
                }
                _renderers.splice(loc3, 1);
                --loc3;
            }
            return;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (isInvalid(scaleform.clik.constants.InvalidationType.SCROLL_BAR))
                createScrollBar();
            if (isInvalid(scaleform.clik.constants.InvalidationType.RENDERERS))
            {
                _autoRowHeight = NaN;
                _autoColumnWidth = NaN;
                if (_usingExternalRenderers)
                {
                    _totalColumns = externalColumnCount != 0 ? externalColumnCount : 1;
                    _totalRows = Math.ceil(_renderers.length / _totalColumns);
                }
            }
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
                        this.cleanUpRenderer(loc3);
                        loc4 = loc3 as flash.display.DisplayObject;
                        if (container.contains(loc4))
                            container.removeChild(loc4);
                        ++loc1;
                    }
                }
                _renderers = new Vector.<scaleform.clik.interfaces.IListItemRenderer>();
                invalidateData();
            }
            if (!_usingExternalRenderers && isInvalid(scaleform.clik.constants.InvalidationType.SIZE))
            {
                (loc5 = App.utils.events).disableDisposingForObj(container);
                removeChild(container);
                setActualSize(_width, _height);
                container.scaleX = 1 / scaleX;
                container.scaleY = 1 / scaleY;
                _totalRenderers = calculateRendererTotal(availableWidth, availableHeight);
                addChild(container);
                loc5.enableDisposingForObj(container);
                invalidateData();
            }
            if (!_usingExternalRenderers && isInvalid(scaleform.clik.constants.InvalidationType.RENDERERS, scaleform.clik.constants.InvalidationType.SIZE))
            {
                drawRenderers(_totalRenderers);
                this.drawLayout();
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA))
            {
                refreshData();
                updateScrollBar();
            }
            return;
        }

        public var showEmptyItems:Boolean;

        public var paddingBottom:Number;

        public var paddingRight:Number;
    }
}
