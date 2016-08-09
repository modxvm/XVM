/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.tankcarousel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.gui.components.carousels.*;
    import net.wg.gui.components.controls.scroller.*;
    import scaleform.clik.constants.*;

    public /*dynamic*/ class MultiRowsScrollerViewPort extends HorizontalScrollerViewPort
    {
        private var cfg:CCarousel;
        private var _itemWidth:int;
        private var _itemWidthWithPadding:int;
        private var _itemHeight:int;
        private var _itemHeightWithPadding:int;
        private var _dataCount:int = 0;
        private var _leftIdx:int = 0;

        public function MultiRowsScrollerViewPort():void
        {
            //Logger.add("MultiRowsScrollerViewPort");
            super();
            cfg = Config.config.hangar.carousel;
            _itemWidth = Math.ceil(UI_TankCarouselItemRenderer.ITEM_WIDTH * cfg.zoom) + UI_TankCarouselItemRenderer.ITEM_MARGIN * 2;
            _itemWidthWithPadding = _itemWidth + cfg.padding.horizontal;
            _itemHeight = Math.ceil(UI_TankCarouselItemRenderer.ITEM_HEIGHT * cfg.zoom) + UI_TankCarouselItemRenderer.ITEM_MARGIN * 2;
            _itemHeightWithPadding = _itemHeight + cfg.padding.vertical;
        }

        override public function set horizontalScrollPosition(value:Number):void
        {
            _leftIdx = Math.floor(value / _itemWidthWithPadding) * cfg.rows;
            super.horizontalScrollPosition = _leftIdx * (rendererWidth + gap);
        }

        override public function set visibleWidth(value:Number):void
        {
            var visibleCount:int = (Math.ceil(value / _itemWidthWithPadding) + 1) * cfg.rows;
            super.visibleWidth = visibleCount * (rendererWidth + gap) - gap;
        }

        override public function updateDataCount():void
        {
            _dataCount = (dataProvider != null) ? dataProvider.length : 0;
            xfw_dataCount = _dataCount;
        }

        override public function resize():void
        {
            var w:int = Math.ceil(_dataCount / cfg.rows) * _itemWidthWithPadding;
            if (_width !== w || _height !== visibleHeight)
            {
                _width = w;
                _height = this.visibleHeight;
                if (hasEventListener(Event.RESIZE))
                {
                    dispatchEvent(new Event(Event.RESIZE));
                }
            }
        }

        override public function layoutItemRenderers():void
        {
            var renderer:IScrollerItemRenderer = null;
            if (this.xfw_activeRenderers.length == 0)
            {
                return;
            }
            var zoom:Number = cfg.zoom;
            for each (renderer in this.xfw_activeRenderers)
            {
                var idx:int = renderer.index;
                renderer.x = int(idx / cfg.rows) * _itemWidthWithPadding;
                renderer.y = int(idx % cfg.rows) * _itemHeightWithPadding + UI_TankCarousel.VERTICAL_MARGIN;
            }
        }
    }
}
